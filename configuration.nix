{ config, pkgs, lib, ... }:

{
  imports =
    [
      /etc/nixos/hardware-configuration.nix
       <home-manager/nixos>
    ];

  system.stateVersion = "unstable";

  boot.loader.grub.enable = true;
  boot.loader.grub.version = 2;
  boot.loader.grub.device = "/dev/sda";

  networking.hostName = "SeanLaptop";
  networking.networkmanager.enable = true;
  networking.firewall.enable = false;

  time.timeZone = "America/New_York";

  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    keyMap = "dvorak-programmer";
  };

  sound.enable = true;
  hardware.pulseaudio = {
    enable = true;
    support32Bit = true;
    extraConfig = "load-module module-native-protocol-tcp auth-ip-acl=127.0.0.1";
  };
  hardware.opengl.enable = true;

  virtualisation.docker = {
    enable = true;
    liveRestore = false;
  };

  programs.fish.enable = true;

  system.autoUpgrade.enable = true;
  system.autoUpgrade.allowReboot = true;

  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
  };

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
    shell = pkgs.fish;
    homeMode = "750";
    extraGroups = [ "audio" "wheel" "docker" ];
    packages = with pkgs; [
      acpi
      arandr
      brave
      dmenu
      docker-compose
      dosbox-staging
      dunst
      ffmpeg
      gcc
      git
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
      scrot
      slack
      soulseekqt
      st
      timidity
      universal-ctags
      yt-dlp
      wineWowPackages.stable
      zathura
    ];
  };

  systemd.user.services.dwmstatus = {
    enable = true;
    description = "Set DWM Status via xsetroot";
    serviceConfig.PassEnvironment = "DISPLAY";
    script = ''
      ${pkgs.bash}/bin/bash /home/sean/workspaces/dot_files/set-dwm-status.sh
    '';
    wantedBy = [ "multi-user.target" ];
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

    programs = {
      neovim = {
        enable = true;
        extraConfig = lib.fileContents .config/nvim/config.vim;
      };

      git = {
        enable = true;
        userName  = "Sean DuBois";
        userEmail = "sean@siobud.com";
      };

      tmux = {
        enable = true;
        shell = ''${pkgs.fish}/bin/fish'';
      };

      fish = {
        enable = true;
        interactiveShellInit = ''
          set fish_greeting
        '';
        shellAliases = {
          vim         = "nvim";
          ls          = "ls -FG";
          ll          = "ls -lha";
          lr          = "ls -ltr";
          l           = "ls -lh";
          showLargest = "du -a | sort -n -r | less";
        };
      };
    };
  };

  environment.systemPackages = with pkgs; [
    tmux
    psmisc
    libnotify
  ];

  services.openssh.enable = true;
  services.xserver = {
    enable = true;
    layout = "us";
    xkbVariant = "dvp";
    xkbOptions = "ctrl:nocaps";
    videoDrivers = [ "nvidia" ];
    libinput.enable = true;
    windowManager.dwm.enable = true;
    displayManager = {
      # setupCommands = ''
      #   ${pkgs.xorg.xrandr}/bin/xrandr --output LVDS-1 --off --output DP-2 --auto
      # '';
      lightdm.background = "#000000";
    };
    xautolock = {
      enable = true;
      enableNotifier = true;
      locker = ''${pkgs.lightdm}/bin/dm-tool lock'';
      notifier =
        ''${pkgs.libnotify}/bin/notify-send "Locking in 10 seconds"'';
    };
    deviceSection = ''
      Driver         "nvidia"
      BusID          "PCI:2@0:0:0"
      Option         "AllowEmptyInitialConfiguration"
      Option         "AllowExternalGpus" "True"
    '';
  };

  users.users.mpd.extraGroups = [ "users" ];
  services.mpd = {
    enable = true;
    musicDirectory = "/home/sean/Music";
    extraConfig = ''
      audio_output {
        type "pulse"
        name "My PulseAudio"
        server "127.0.0.1"
      }

      decoder {
        plugin "fluidsynth"
        soundfont "/home/sean/Music/MIDI/ESFM.sf2"
      }
    '';
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
}
