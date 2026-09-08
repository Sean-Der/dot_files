{ config, pkgs, lib, ... }:
{
  imports =
    [
      ./hardware-configuration.nix
    ];

  system.stateVersion = "26.05";

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
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
          selection-target = "both";
        };
        mouse-bindings = {
          primary-paste = "BTN_MIDDLE";
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
          prePatch = "cp ${../dwl-patches/config.h} config.h";
          patches = (oldAttrs.patches or []) ++ [
            ../dwl-patches/01-shiftview.patch
            ../dwl-patches/02-bar.patch
            ../dwl-patches/03-pertag.patch
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
      aerc
      acpi
      codex
      clang
      docker-compose
      dosbox-staging
      fastfetch
      ffmpeg_7-full
      file
      flatpak-builder
      gcc
      gdb
      gh
      git
      gnumake
      go
      gopls
      gotools
      htop
      jq
      mpv
      ncmpcpp
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
      wdisplays
      webcord
      wireshark
      yt-dlp
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
        "bin" = {
          source = ../bin;
        };
        ".config/ncmpcpp" = {
          source = ../.config/ncmpcpp;
        };
        ".config/dosbox" = {
          source = ../.config/dosbox;
        };
        ".config/kanshi/config" = {
          text = ''
            profile docked {
              output eDP-1 disable
              output "Dell Inc. DELL P2421DC 844VS03" enable mode preferred position 0,0 scale 1
            }

            profile undocked {
              output eDP-1 enable mode preferred position 0,0 scale 1
            }
          '';
        };
        ".inputrc" = {
          source = ../.inputrc;
        };
        ".config/nvim/colors" = {
          source = ../.config/nvim/colors;
        };
      };
    };

    services = {
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

    xdg.mimeApps = {
      enable = true;
      defaultApplications = {
        "text/html" = [ "chromium-browser.desktop" ];
        "x-scheme-handler/http" = [ "chromium-browser.desktop" ];
        "x-scheme-handler/https" = [ "chromium-browser.desktop" ];
      };
    };

    programs = {
      fzf = {
        enable = true;
        enableBashIntegration = true;
      };

      neovim = {
        enable = true;
        package = pkgs.neovim-unwrapped;
        initLua = lib.fileContents ../.config/nvim/init.lua;
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
    brightnessctl
    cliphist
    dwl
    foot
    kanshi
    libnotify
    psmisc
    swayidle
    tailscale
    tmux
    wayland
    wayland-utils
    wl-clipboard
    wlopm
    wmenu
    xdg-utils
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

  services.tlp.enable = true;

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
