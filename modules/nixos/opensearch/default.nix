{
  pkgs,
  config,
  lib,
  inputs,
  ...
}:

let
  opensearch-fixed = pkgs.opensearch.overrideAttrs (
    final: previous: {
      installPhase = previous.installPhase + ''
        chmod +x $out/plugins/opensearch-security/tools/*.sh
      '';
    }
  );

  # packages =

  # pkgs.stdenv.mkDerivation rec {
  #   pname = "opensearch-dashboards";
  #   version = "3.5.0";

  #   src = pkgs.fetchurl {
  #     url = "https://artifacts.opensearch.org/releases/bundle/opensearch-dashboards/${version}/${pname}-${version}-linux-x64.tar.gz";
  #     hash = "sha256-g0aKKvi2rAd3AFdlfkotzoyREfoSTKJFI7bihjFu2wU=";
  #   };

  #   # patches = [
  #   #   # OpenSearch Dashboard specifies that it wants nodejs 14.20.1 but nodejs in nixpkgs is at 14.21.1.
  #   #   ./disable-nodejs-version-check.patch
  #   # ];

  #   dontStrip = true;

  #   nativeBuildInputs = [ pkgs.makeWrapper ];

  #   installPhase = ''
  #     mkdir -p $out/libexec/opensearch-dashboards $out/bin
  #     mv * $out/libexec/opensearch-dashboards/
  #     rm -r $out/libexec/opensearch-dashboards/node
  #     for bin in $out/libexec/opensearch-dashboards/bin/opensearch-dashboards*; do
  #       makeWrapper $bin $out/bin/$(basename $bin) \
  #         --prefix PATH : "${
  #           lib.makeBinPath [
  #             pkgs.nodejs
  #             pkgs.coreutils
  #             pkgs.which
  #           ]
  #         }"

  #     done
  #     rm -rf $out/libexec/opensearch-dashboards/plugins/securityDashboards
  #   '';

  #   meta = {

  #     cdescription = "Visualization and user interface for OpenSearch";
  #     homepage = "https://opensearch.org";
  #     # license = licenses.asl20;
  #     # platforms = with platforms; linux;
  #     mainProgram = "opensearch-dashboards";
  #   };
  # };
in
{
  # imports = [ inputs.opensearch-dashboard.nixosModules.default ];
  services.opensearch-dashboards = {

    enable = true;
    # package = packages;
    # opensearchHosts = [ "https://search.funksiyachi.uz/" ];
    # environment = {
    #   DISABLE_SECURITY_PLUGIN = "true";
    # };
  };
  services.opensearch = {
    enable = true;
    package = opensearch-fixed;

    # extraJavaOptions = [
    #   "-Djna.tmpdir=/var/lib/opensearch/config"
    # ];

    settings = {
      "cluster.name" = "my-cluster1";
      "node.name" = "node-1";
      "network.host" = "127.0.0.1";
      "http.port" = 9200;
      "discovery.type" = "single-node";

    };
  };

  systemd.services.opensearch = {
    environment = {
      OPENSEARCH_INITIAL_ADMIN_PASSWORD = "SecureP@ssword123!";

    };
    # preStart = pkgs.lib.mkBefore ''
    #   if [ ! -d "${certs_dir}" ]; then
    #     echo "Generating mandatory internal Transport TLS certificates..."
    #     mkdir -p "${certs_dir}"

    #     ${lib.getExe pkgs.openssl} genrsa -out ${certs_dir}/admin-key-temp.pem 2048
    #     ${lib.getExe pkgs.openssl} pkcs8 -inform PEM -outform PEM -in ${certs_dir}/admin-key-temp.pem -topk8 -nocrypt -v1 PBE-SHA1-3DES -out ${certs_dir}/admin-key.pem
    #     ${lib.getExe pkgs.openssl} req -new -key ${certs_dir}/admin-key.pem -subj "/C=US/ST=NEW YORK/L=BROOKLYN/O=OPENSEARCH/OU=SECURITY/CN=A" -out ${certs_dir}/admin.csr

    #     ${lib.getExe pkgs.openssl} genrsa -out ${certs_dir}/root-ca-key.pem 2048
    #     ${lib.getExe pkgs.openssl} req -new -x509 -sha256 -key ${certs_dir}/root-ca-key.pem -subj "/C=US/ST=NEW YORK/L=BROOKLYN/O=OPENSEARCH/OU=SECURITY/CN=ROOT" -out ${certs_dir}/root-ca.pem -days 730

    #     ${lib.getExe pkgs.openssl} x509 -req -in ${certs_dir}/admin.csr -CA ${certs_dir}/root-ca.pem -CAkey ${certs_dir}/root-ca-key.pem -CAcreateserial -sha256 -out ${certs_dir}/admin.pem -days 730
    #     ${lib.getExe pkgs.openssl} genrsa -out ${certs_dir}/os-node-01-key-temp.pem 2048
    #     ${lib.getExe pkgs.openssl} pkcs8 -inform PEM -outform PEM -in ${certs_dir}/os-node-01-key-temp.pem -topk8 -nocrypt -v1 PBE-SHA1-3DES -out ${certs_dir}/os-node-01-key.pem
    #     ${lib.getExe pkgs.openssl} req -new -key ${certs_dir}/os-node-01-key.pem -subj "/C=US/ST=NEW YORK/L=BROOKLYN/O=OPENSEARCH/OU=SECURITY/CN=os-node-01" -out ${certs_dir}/os-node-01.csr
    #     echo 'subjectAltName=DNS:os-node-01' | tee -a ${certs_dir}/os-node-01.ext
    #     echo 'subjectAltName=IP:172.20.0.11' | tee -a ${certs_dir}/os-node-01.ext
    #     ${lib.getExe pkgs.openssl} x509 -req -in ${certs_dir}/os-node-01.csr -CA ${certs_dir}/root-ca.pem -CAkey ${certs_dir}/root-ca-key.pem -CAcreateserial -sha256 -out ${certs_dir}/os-node-01.pem -days 730 -extfile ${certs_dir}/os-node-01.ext

    #     rm ${certs_dir}/admin-key-temp.pem
    #     rm ${certs_dir}/admin.csr
    #     rm ${certs_dir}/os-node-01-key-temp.pem
    #     rm ${certs_dir}/os-node-01.csr
    #     rm ${certs_dir}/os-node-01.ext
    #     rm ${certs_dir}/root-ca.srl

    #     chown -R opensearch:opensearch "${certs_dir}"
    #     chmod 600 "${certs_dir}"/*
    #   fi
    # '';
  };
}
