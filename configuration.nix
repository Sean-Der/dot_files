{ config, pkgs, lib, ... }:
{
  imports =
    [
      /etc/nixos/hardware-configuration.nix
       <home-manager/nixos>
    ];

  system.stateVersion = "26.05";

  boot = {
    loader.grub = {
      device = "/dev/sda";
      enable = true;
    };

    kernelParams = [ "mitigations=off"];
    initrd = {
      systemd.services.resume-config = {
        description = "Set the resume device";
        wantedBy = [ "initrd.target" ];
        serviceConfig.Type = "oneshot";
        script = "echo 8:2 > /sys/power/resume";
      };
    };
  };

  nix.optimise.automatic = true;
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 7d";
  };

  services.logind.settings.Login.HandleLidSwitch = "ignore";

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

  i18n = {
    defaultLocale = "en_US.UTF-8";
  };

  console = {
    keyMap = "dvorak-programmer";
  };

  hardware = {
    bluetooth = {
      enable = true;
      powerOnBoot = true;
    };
    graphics.enable = true;
  };

  virtualisation = {
    docker = {
      enable = true;
      enableOnBoot = false;
    };
  };

  programs = {
    foot = {
      enable = true;
      theme = "kitty";

      settings = {
        main = {
          font = "Inconsolata:pixelsize=14:antialias=true:autohint=true";
        };
      };
    };
    dconf = {
      enable = true;
    };
    neovim = {
      enable = true;
      defaultEditor = true;
      viAlias = true;
      vimAlias = true;
      package = pkgs.neovim-unwrapped;
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
      allowUnfree = true;
    };
    overlays = [ (self: super:
      {
        libsForQt5 = (super.libsForQt5 or {}) // {
          fcitx5-with-addons = super.kdePackages.fcitx5-with-addons;
        };

        dwl = super.dwl.overrideAttrs (oldAttrs: rec {
          prePatch = "cp ${./dwl-patches/config.h} config.h";
          patches = (oldAttrs.patches or []) ++ [
            ./dwl-patches/01-shiftview.patch
            ./dwl-patches/02-bar.patch
          ];
          buildInputs = (oldAttrs.buildInputs or []) ++ [ pkgs.fcft pkgs.pixman pkgs.libdrm ];
        });
      })
    ];
  };

  users.users.sean = {
    linger = true;
    isNormalUser = true;
    extraGroups = [ "audio" "wheel" "docker"];
    packages = with pkgs; [
      acpi
      btop
      clang
      docker-compose
      dosbox-staging
      ffmpeg_6-full
      file
      firefox
      flatpak-builder
      gcc
      gdb
      git
      gemini-cli
      gnumake
      go
      mage
      mpc
      mpv
      ncmpcpp
      fastfetch
      neomutt
      nodejs
      pavucontrol
      pulsemixer
      ripgrep
      rustup
      scrot
      sxiv
      tcpdump
      ungoogled-chromium
      universal-ctags
      unzip
      vesktop
      wireshark
      yt-dlp
      wdisplays
    ];
  };

  fonts.packages = [pkgs.inconsolata];

  home-manager.useGlobalPkgs = true;
  home-manager.users.sean = { pkgs, ... }: {
    home = {
      enableNixpkgsReleaseCheck = false;
      stateVersion = "26.05";
      sessionVariables = {
        EDITOR = "nvim";
        LANG = "en_US.UTF-8";
        PATH = "${config.users.users.sean.home}/.cargo/bin:${config.users.users.sean.home}/go/bin:${config.users.users.sean.home}/bin:$PATH";
      };
      file = {
        ".config/ncmpcpp" = {
          source = ./.config/ncmpcpp;
        };
        ".config/dosbox" = {
          source = ./.config/dosbox;
        };
        ".inputrc" = {
          source = ./.inputrc;
        };
      };
    };

    services = {
      kanshi = {
        enable = true;
        profiles = {
          # laptop only
          undocked = {
            outputs = [
              {
                criteria = "LVDS-1";
                status = "enable";
              }
            ];
          };
          # external monitor connected
          docked = {
            outputs = [
              {
                criteria = "DP-2";
                status = "enable";
              }
              {
                criteria = "LVDS-1";
                status = "disable";
              }
            ];
          };
        };
      };
      mpd = {
        enable = true;
        musicDirectory = "/home/sean/Music";
        extraConfig = ''
          audio_output {
            type "pipewire"
            name "My PipeWire Output"
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
        package = pkgs.neovim-unwrapped;
        initLua = lib.fileContents .config/nvim/init.lua;
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
        settings = {
          user = {
            name  = "Sean DuBois";
            email = "sean@siobud.com";
          };
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
    dwl
    foot
    kanshi
    libnotify
    psmisc
    tailscale
    tmux
    wayland
    wayland-utils
    wmenu
  ];

  services.openssh = {
    enable = true;
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

  location.provider = "geoclue2";

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

  xdg.portal = {
    config.common.default = "*";
    enable = true;
    extraPortals = with pkgs; [
      kdePackages.xdg-desktop-portal-kde
    ];
  };

  services.flatpak.enable = true;

  services.libinput.enable = true;

  services.blueman.enable = true;

  services.tailscale.enable = true;

  security = {
    polkit.enable = true;
    rtkit.enable = true;
  };

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };
}
