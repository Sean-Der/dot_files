{ config, pkgs, lib, ... }:

let
  enableNvidia = false;
in {
  imports =
    [
      /etc/nixos/hardware-configuration.nix
       <home-manager/nixos>
    ];

  system.stateVersion = "unstable";

  boot.loader.grub = {
    device = "/dev/sda";
    enable = true;
    version = 2;
  };

  systemd.targets = {
    sleep.enable = false;
    suspend.enable = false;
    hibernate.enable = false;
    hybrid-sleep.enable = false;
  };

  services.logind.lidSwitch = "ignore";

  networking = {
    hostName = "SeanLaptop";
    nameservers = [ "1.1.1.1" "1.0.0.1" ];
    firewall.enable = false;

    networkmanager = {
      enable = true;
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
    pulseaudio = {
      enable = true;
      support32Bit = true;
    };
    opengl = {
      enable = true;
      driSupport32Bit = true;
    };
  };

  virtualisation.docker = {
    enable = true;
    liveRestore = false;
  };

  programs = {
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
        PS1="\[\033[$PROMPT_COLOR\][\[\e]0;\u@\h: \w\a\]\u@\h:\w]\\$\[\033[0m\] "
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
    extraGroups = [ "audio" "wheel" "docker" "pulse-access" ];
    packages = with pkgs; [
      acpi
      autocutsel
      arandr
      brave
      clang-tools
      dmenu
      docker-compose
      dosbox-staging
      dunst
      ffmpeg
      file
      gcc
      git
      gnumake
      go
      htop
      inconsolata
      mpv
      mutt
      ncmpcpp
      neofetch
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
      timidity
      universal-ctags
      unzip
      wineWowPackages.stable
      winetricks
      yt-dlp
      zathura
    ];
  };

  home-manager.users.sean = { pkgs, ... }: {
    home = {
      stateVersion = "22.11";
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
            soundfont "/home/sean/Music/MIDI/ESFM.sf2"
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
  ];

  services.openssh = {
    enable = true;
    settings.X11Forwarding = true;
  };

  services.xserver =  {
    enable = true;
    layout = "us";
    xkbVariant = "dvp";
    xkbOptions = "ctrl:nocaps";
    libinput.enable = true;
    windowManager.dwm.enable = true;

    displayManager = {
      setupCommands =
      if enableNvidia then
        ""
      else
        "${pkgs.xorg.xrandr}/bin/xrandr --output LVDS-1 --off --output DP-2 --auto";
      sessionCommands = ''
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

    videoDrivers = if enableNvidia then
     ["nvidia"]
    else
     [];
    deviceSection =
    if enableNvidia then
      ''
        Driver         "nvidia"
        BusID          "PCI:2@0:0:0"
        Option         "AllowEmptyInitialConfiguration"
        Option         "AllowExternalGpus" "True"
      ''
    else
      "";
  };

  services.avahi = {
    enable = true;
    nssmdns = true;
    publish = {
      enable = true;
      addresses = true;
      domain = true;
      hinfo = true;
      userServices = true;
      workstation = true;
    };
  };

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

  services.tlp.enable = true;
}
