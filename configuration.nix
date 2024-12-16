{ config, pkgs, lib, ... }:
{
  imports =
    [
      /etc/nixos/hardware-configuration.nix
       <home-manager/nixos>
    ];

  system.stateVersion = "24.05";

  boot = {
    loader.grub = {
      device = "/dev/sda";
      enable = true;
    };

    kernelParams = [ "mitigations=off"];
    initrd = {
      postDeviceCommands = lib.mkAfter ''
        echo 8:2 > /sys/power/resume
      '';
    };
  };

  nix.optimise.automatic = true;
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 7d";
  };

  services.logind.lidSwitch = "ignore";

  networking = {
    hostName = "SeanLaptop";
    firewall.enable = false;

    networkmanager = {
      enable = true;
      connectionConfig."connection.mdns" = 2;
      dispatcherScripts = [
        {
          source = pkgs.writeText "disableWifiOnOthernet" ''
            #!/usr/bin/env ${pkgs.bash}/bin/bash
              enable_disable_wifi ()
              {
                  result=$(${pkgs.networkmanager}/bin/nmcli dev | grep "ethernet" | grep -w "connected")
                  if [ -n "$result" ]; then
                      ${pkgs.networkmanager}/bin/nmcli radio wifi off
                  else
                      ${pkgs.networkmanager}/bin/nmcli radio wifi on
                  fi
              }

              if [ "$2" = "up" ]; then
                  enable_disable_wifi
              fi

              if [ "$2" = "down" ]; then
                  enable_disable_wifi
              fi
          '';
          type = "basic";
        }
      ];
    };
  };

  time.timeZone = "America/New_York";

  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    keyMap = "dvorak-programmer";
  };

  sound.enable = true;
  hardware = {
    bluetooth = {
      enable = true;
      powerOnBoot = true;
    };
    pulseaudio = {
      enable = true;
      support32Bit = true;
    };
    opengl = {
      enable = true;
      driSupport32Bit = true;
    };
  };

  virtualisation = {
    docker = {
      enable = true;
      enableOnBoot = false;
    };
  };

  programs = {
    dconf = {
      enable = true;
    };
    slock = {
      enable = true;
    };
    neovim = {
      enable = true;
      defaultEditor = true;
      viAlias = true;
      vimAlias = true;
    };
    bash = {
      promptInit = ''
        PROMPT_COLOR="1;31m"
        ((UID)) && PROMPT_COLOR="1;32m"
        PS1="\[\033[$PROMPT_COLOR\]\u@\h\[$(tput sgr0)\]:\[$(tput sgr0)\]\[\033[38;5;33m\]\w\[$(tput sgr0)\]\\$\[$(tput sgr0)\] "
      '';
    };
  };

  system.autoUpgrade.enable = true;

  nixpkgs = {
    config = {
      pulseaudio = true;
      allowUnfree = true;
    };
    overlays = [ (self: super:
      {
        dwm = super.dwm.overrideAttrs (oldAttrs: rec {
          patches = [
            dwm-patches/01-shiftviewclients.patch
            dwm-patches/02-statuscolors.patch
            dwm-patches/03-pertag.patch
            dwm-patches/04-fullscreen.patch
          ];

          configFile = super.writeText "config.h" (builtins.readFile ./dwm-patches/config.h);
          postPatch = "${oldAttrs.postPatch}\n cp ${configFile} config.h";
        });


        st = super.st.overrideAttrs (oldAttrs: rec {
          patches = [
            st-patches/01-scrollback.diff
          ];

          configFile = super.writeText "config.h" (builtins.readFile ./st-patches/config.h);
          postPatch = "${oldAttrs.postPatch}\n cp ${configFile} config.h";
        });

      })
    ];
  };

  users.users.sean = {
    isNormalUser = true;
    extraGroups = [ "audio" "wheel" "docker" "pulse-access"];
    packages = with pkgs; [
      acpi
      arandr
      autocutsel
      autorandr
      btop
      clang
      clang-tools_17
      discord
      dmenu
      docker-compose
      dosbox-staging
      dunst
      ffmpeg_6-full
      file
      firefox
      flatpak-builder
      gcc
      gdb
      git
      gnumake
      go
      mage
      mpc-cli
      mpv
      ncmpcpp
      neofetch
      neomutt
      nodejs
      pavucontrol
      pulsemixer
      ripgrep
      rustup
      scrot
      slack
      soulseekqt
      st
      sxiv
      tcpdump
      thunderbird
      ungoogled-chromium
      universal-ctags
      unzip
      wireshark
      xsel
      yt-dlp
      zathura
    ];
  };

  fonts.packages = with pkgs; [
    inconsolata
  ];

  home-manager.users.sean = { pkgs, ... }: {
    home = {
      stateVersion = "24.05";
      sessionVariables = {
        EDITOR = "nvim";
        LANG = "en_US.UTF-8";
        PATH = "~/.cargo/bin:~/go/bin:~/bin:$PATH";
      };
      file = {
        ".config/ncmpcpp" = {
          source = ./.config/ncmpcpp;
        };
      };
      file = {
        ".config/dosbox" = {
          source = ./.config/dosbox;
        };
      };
      file = {
        ".inputrc" = {
          source = ./.inputrc;
        };
      };
    };

    services = {
      mpd = {
        enable = true;
        musicDirectory = "/home/sean/Music";
        extraConfig = ''
          audio_output {
            type "pulse"
            name "My PulseAudio"
          }

          decoder {
            plugin "fluidsynth"
            soundfont "/home/sean/Music/MIDI/OPL3.sf2"
          }
        '';
      };
    };

    programs = {
      neovim = {
        enable = true;
        extraConfig = lib.fileContents .config/nvim/config.vim;
      };

      bash = {
        enable = true;
        shellAliases = {
          mutt        = "neomutt";
          vim         = "nvim";
          ls          = "ls -FG";
          ll          = "ls -lha";
          lr          = "ls -ltr";
          l           = "ls -lh";
          showLargest = "du -a | sort -n -r | less";
        };
        initExtra = ''
          source ~/.fzf.bash
        '';
      };

      git = {
        enable = true;
        userName  = "Sean DuBois";
        userEmail = "sean@siobud.com";
        extraConfig = {
          url."ssh://git@github.com/".insteadOf = "https://github.com/";
          pull.rebase = true;
          push.autoSetupRemote = true;
        };
      };

      tmux = {
        enable = true;
      };
    };
  };

  environment.systemPackages = with pkgs; [
    tmux
    psmisc
    libnotify
    slock
    tailscale
  ];

  services.openssh = {
    enable = true;
    settings.X11Forwarding = true;
  };

  services.xserver =  {
    enable = true;
    windowManager.dwm.enable = true;

    xkb = {
      layout = "us";
      variant = "dvp";
      options = "ctrl:nocaps";
    };

    displayManager = {
      sessionCommands = ''
        ${pkgs.xorg.xsetroot}/bin/xsetroot -solid black
        ${pkgs.autocutsel}/bin/autocutsel -s PRIMARY &
        ${pkgs.autocutsel}/bin/autocutsel -s CLIPBOARD &
        ${pkgs.bash}/bin/bash /home/sean/workspaces/dot_files/set-dwm-status.sh &
      '';
      lightdm.background = "#000000";
    };

    xautolock = {
      enable = true;
      enableNotifier = true;
      locker = let cmd = pkgs.writeScript "lock" ''
        ${pkgs.dunst}/bin/dunstctl set-paused true
        /run/wrappers/bin/slock
        ${pkgs.dunst}/bin/dunstctl set-paused false
      '';
      in ''${pkgs.bash}/bin/bash -c "${cmd} & ${pkgs.coreutils}/bin/sleep 0.5 && ${pkgs.xorg.xset}/bin/xset dpms force off"'';
      notifier = ''${pkgs.libnotify}/bin/notify-send "Locking in 10 seconds"'';
    };
  };

  services.avahi = {
    enable = true;
    publish = {
      enable = true;
      addresses = true;
      domain = true;
      hinfo = true;
      userServices = true;
      workstation = true;
    };
  };
  services.resolved.enable = true;

  services.unclutter = {
    enable = true;
    timeout = 2;
    extraOptions = [ "noevents" ];
  };

  services.clipmenu = {
    enable = true;
  };

  location.provider = "geoclue2";
  services.redshift = {
    enable = true;
  };

  services.tlp = {
    enable = true;
    settings = {
      CPU_SCALING_GOVERNOR_ON_AC = "performance";
      CPU_SCALING_GOVERNOR_ON_BAT = "powersave";

      CPU_ENERGY_PERF_POLICY_ON_BAT = "power";
      CPU_ENERGY_PERF_POLICY_ON_AC = "performance";

      CPU_MIN_PERF_ON_AC = 0;
      CPU_MAX_PERF_ON_AC = 100;
      CPU_MIN_PERF_ON_BAT = 0;
      CPU_MAX_PERF_ON_BAT = 20;

      START_CHARGE_THRESH_BAT0 = 20; # 20 and bellow it starts to charge
      STOP_CHARGE_THRESH_BAT0 = 80; # 80 and above it stops charging

     };
   };

  services.cron = {
    enable = true;
    systemCronJobs = [
      "0 1 * * *      root    systemctl hibernate"
    ];
  };

  # services.redis.servers."redis" = {
  #   enable = true;
  #   port = 6379;
  # };

  xdg.portal = {
    config.common.default = "*";
    enable = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-kde
    ];
  };

  services.flatpak.enable = true;

  services.libinput.enable = true;

  services.blueman.enable = true;

  services.tailscale.enable = true;
}
