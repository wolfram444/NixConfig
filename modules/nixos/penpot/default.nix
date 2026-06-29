{
  lib,
  inputs,
  config,
  options,
  ...
}:

{
  imports = [ inputs.penpot.nixosModules.default ];

  options = {
    uzinfocom.penpot = options.services.penpot;

    config = lib.mkIf cfg.enable {
      services.penpot = {
        enable = true;
        port = cfg.port;
        domain = cfg.domain;
        openFirewall = cfg.openFirewall;
        secretKeyFile = cfg.secretKeyFile;
        db = {
          enablePostgres = cfg.enablePostgres;
          enableRedis = cfg.enableRedis;
          postgresUri = cfg.postgresUri;
          redisUri = cfg.redisUri;
        };

      };

    };

  };

}
