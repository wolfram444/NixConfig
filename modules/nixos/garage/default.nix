{ pkgs, ... }:
{
  services.garage = {
    enable = true;
    package = pkgs.garage_2;

    settings = {
      replication_factor = 1;
      data_dir = "/var/lib/garage/data";
      metadata_dir = "/var/lib/garage/meta";
      db_engine = "sqlite";

      rpc_bind_addr = "0.0.0.0:3901";
      rpc_secret = "b8ed42b061bee4500b4fbe783ef87b2be78a8e58fdb6318278c9ee492c408c27";
      rpc_public_addr = "127.0.0.1:3901";

      s3_api = {
        s3_region = "garage";
        api_bind_addr = "0.0.0.0:3900";
      };

      admin = {
        api_bind_addr = "0.0.0.0:3903";
        admin_token = "tw6yNoVNtG28Qgv48nwF2YA7rGzphRZ5PuwcWFFXqZk=";
        metrics_token = "d8eCFmyqMf+nWKDqpI90cqXATEWTPLRE0V3DzyJMz3k=";
      };

      # services.garage-webui.enable = true;

      # replication_factor = 1;
      # data_dir = "/var/lib/garage/data";
      # metadata_dir = "/var/lib/garage/meta";
      # db_engine = "sqlite";

      # rpc_bind_addr = "0.0.0.0:3901";
      # rpc_secret = "110c57c2ec83e9d9fb5ee48f4e3cf622e35d97e329a4109040b3d50c216740b6";
      # rpc_public_addr = "127.0.0.1:3901";

      # s3_api = {
      #   s3_region = "ap-north-6";
      #   bind_addr = "0.0.0.0:3900";
      # };

      # admin = {
      #   api_bind_addr = "0.0.0.0:3903";
      #   admin_token = "4LCbUP2dXAqvC4rIWXMr9eYto9DkiNAoBPXS6Vyl/dQ=";
      #   metrics_token = "d8eCFmyqMf+nWKDqpI90cqXATEWTPLRE0V3DzyJMz3k=";
      # };

    };
  };
}
