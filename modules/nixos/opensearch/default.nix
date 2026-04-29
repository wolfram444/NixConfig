{ pkgs, ... }:
{
  services.opensearch = {
    enable = true;
    package = pkgs.opensearch;

    settings = {
      "cluster.name" = "my-cluster";
      "node.name" = "node-1";
      "network.host" = "127.0.0.1";
      "http.port" = 9200;
      "discovery.type" = "single-node";
    };
  };
}
