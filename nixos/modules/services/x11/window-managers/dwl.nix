{ config, lib, pkgs, ... }:

with lib;

let

  cfg = config.services.xserver.windowManager.dwl;

in

{

  ###### interface

  options = {
    services.xserver.windowManager.dwl.enable = mkEnableOption "dwl";
  };


  ###### implementation

  config = mkIf cfg.enable {

    services.xserver.windowManager.session = singleton
      {
        name = "dwl";
        start =
          ''
            dwl &
            waitPID=$!
          '';
      };

    environment.systemPackages = [ pkgs.dwl ];

  };

}
