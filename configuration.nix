{ config, pkgs, ... }:

{
  imports =
    [ 
      ./hardware-configuration.nix
      ./modules/tlp.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Use latest kernel.
  boot.kernelPackages = pkgs.linuxPackages_latest;

  networking.hostName = "TARDIS"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Enable Bluetooth
  hardware.bluetooth.enable = true;
  services.blueman.enable = true;

  # Set your time zone.
  time.timeZone = "Asia/Kathmandu";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  # Configure keymap in X11
  services.xserver.xkb = { 
    layout = "us";
    variant = "";
  };

  services.flatpak.enable = true;

  #programs.nvf = {
  #  enable = true;
  #  settings = {
  #      vim = {
  #              theme = {
  #                      enable = true;
  #                      name = "gruvbox";
  #                      style = "dark";
  #              };

  #              statusline.lualine.enable = true;
  #              telescope.enable = true;
  #              autocomplete.nvim-cmp.enable = true;
  #      };
  #    };
  #  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.doctor = {
    isNormalUser = true;
    description = "doctor";
    extraGroups = [ "networkmanager" "wheel" "docker" ];
    shell = pkgs.fish;
    packages = with pkgs; [];
  };

  virtualisation.docker = {
  	enable = true;

	rootless = {
		enable = true;
		setSocketVariable = true;
	};
  };

#  services.tlp = {
#  	enable = true;
#	settings = {
#		# Change CPU energy/performance policy
#		CPU_ENERGY_PERF_POLICY_ON_AC = "performance";
#		CPU_ENERGY_PERF_POLICY_ON_BAT = "power";
#
#		# Enable the platform profiler
#		PLATFORM_PROFILE_ON_AC = "performance";
#		PLATFORM_PROFILE_ON_BAT = "low-power";
#
#		# Disable turbo boost
#		CPU_BOOST_ON_AC = 1;
#		CPU_BOOST_ON_BAT = 0;
#
#		CPU_HWP_DYN_BOOST_ON_AC = 1;
#		CPU_HWP_DYN_BOOST_ON_BAT = 0;
#
#		# Reduce power consumption / fan noice on AC power
#		RUNTIME_PM_ON_AC = "auto";
#		RUNTIME_PM_ON_BAT = "auto";
#
#		# Limit power consumption under high CPU load
#		CPU_MAX_PERF_ON_AC = 100;
#		CPU_MAX_PERF_ON_BAT = 25;
#	};
#  };


  programs.dconf.enable = true;

  programs.dconf.profiles.user.databases = [{
    settings."org/gnome/desktop/interface".color-scheme = "prefer-dark";
  }];

  xdg.portal = {
  	enable = true;
	extraPortals = with pkgs; [
		xdg-desktop-portal-gnome
	];
  };

  programs.fish.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  programs.niri.enable = true;

  programs.waybar.enable = true;

  programs.chromium.enable = true;

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  
  # Fonts
  fonts.packages = with pkgs; [
  	nerd-fonts.caskaydia-mono
  ];

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    vim
    wget
    neovim
    alacritty
    rofi
    git
    bluez
    uwsm
    nautilus
    swayosd
    brave
    docker-compose
    swww
    sxiv
    xwayland-satellite
    wl-clipboard
    fastfetch
    bat
    eza
    adwaita-icon-theme
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.05"; # Did you read the comment?

}

