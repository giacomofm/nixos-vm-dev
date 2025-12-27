{ pkgs, ... }: {
  users.users.giacomo = {
    uid = 1000;
    isNormalUser = true;
    description = "Giacomo";
    extraGroups = [ "wheel" "networkmanager" "docker" ];
    packages = with pkgs; [
      javaPackages.compiler.temurin-bin.jdk-25
      jetbrains-toolbox
      spring-boot-cli
      google-chrome
      bruno
    ];
  };

  # Servizio utente: Autostart Toolbox
  # systemd.user.services.autostart-toolbox = {
  #   description = "Avvia Jetbrains Toolbox al login utente";
  #   enable = true;
  #   wantedBy = ["graphical-session.target"];
  #   partOf   = ["graphical-session.target"];
  #   serviceConfig = {
  #     ExecStart = "${pkgs.jetbrains-toolbox}/bin/jetbrains-toolbox";
  #     RemainAfterExit = true;
  #   };
  # };
}