{
  pkgs,
  config,
  lib,
  inputs,
  ...
}:
let
  certs_dir = "/var/lib/opensearch/config/certs";
  cfg = config.services.opensearch;
in
{
  # imports = [ inputs.opensearch-dashboard.nixosModules.default ];
  services.opensearch-dashboards = {
    enable = true;
    opensearchHosts = [ "https://localhost:9200" ];
  };
  services.opensearch = {
    enable = true;
    package = pkgs.opensearch;

    settings = {
      # "cluster.name" = "my-cluster1";
      # "node.name" = "node-1";
      # "network.host" = "127.0.0.1";
      # "http.port" = 9200;
      # "discovery.type" = "single-node";

      # "http.cors.enabled" = "true";
      # "http.cors.allow-origin" = "https://localhost:9200";
      # "http.cors.allow-credentials" = "true";
      # "http.cors.allow-headers" =
      #   "X-Requested-With,X-Auth-Token,Content-Type,Content-Length,Authorization";

      # "plugins.security.disabled" = false;
      # # OpenSearch reads cert's DN back formatted according to RFC 2253

      # "plugins.security.ssl.transport.enabled" = true;

      # # plugins.security.ssl.transport.pemcert_filepath: esnode.pem
      # "plugins.security.ssl.transport.pemcert_filepath" = "${certs_dir}/esnode.pem";

      # # plugins.security.ssl.transport.pemkey_filepath: esnode-key.pem
      # "plugins.security.ssl.transport.pemkey_filepath" = "${certs_dir}/esnode-key.pem";

      # # plugins.security.ssl.transport.pemtrustedcas_filepath: root-ca.pem
      # "plugins.security.ssl.transport.pemtrustedcas_filepath" = "${certs_dir}/root-ca.pem";

      # # transport.ssl.enforce_hostname_verification: false
      # "transport.ssl.enforce_hostname_verification" = false;

      # # plugins.security.ssl.http.enabled: true
      # "plugins.security.ssl.http.enabled" = true;

      # # plugins.security.ssl.http.pemcert_filepath: esnode.pem
      # "plugins.security.ssl.http.pemcert_filepath" = "${certs_dir}/esnode.pem";

      # # plugins.security.ssl.http.pemkey_filepath: esnode-key.pem
      # "plugins.security.ssl.http.pemkey_filepath" = "${certs_dir}/esnode-key.pem";

      # # plugins.security.ssl.http.pemtrustedcas_filepath: root-ca.pem
      # "plugins.security.ssl.http.pemtrustedcas_filepath" = "${certs_dir}/root-ca.pem";

      # # plugins.security.allow_unsafe_democertificates: true
      # "plugins.security.allow_unsafe_democertificates" = true;

      # # plugins.security.allow_default_init_securityindex: true
      # "plugins.security.allow_default_init_securityindex" = "true";

      # # plugins.security.authcz.admin_dn: ['CN=kirk,OU=client,O=client,L=test,C=de']
      # "plugins.security.authcz.admin_dn" = [ "CN=kirk,OU=client,O=client,L=test,C=de" ];

      # # plugins.security.audit.type: internal_opensearch
      # "plugins.security.audit.type" = "internal_opensearch";

      # # plugins.security.enable_snapshot_restore_privilege: true
      # "plugins.security.enable_snapshot_restore_privilege" = true;

      # # plugins.security.check_snapshot_restore_write_privileges: true
      # "plugins.security.check_snapshot_restore_write_privileges" = true;

      # # plugins.security.restapi.roles_enabled: [all_access, security_rest_api_access]
      # "plugins.security.restapi.roles_enabled" = [
      #   "all_access"
      #   "security_rest_api_access"
      # ];

      # # plugins.security.system_indices.enabled: true
      # "plugins.security.system_indices.enabled" = true;

      # # node.max_local_storage_nodes: 3
      # "node.max_local_storage_nodes" = 3;

      "plugins.security.disabled" = false;

      "opensearch.experimental.feature.extensions.enabled" = true;
      "plugins.security.ssl_only" = true;
      "plugins.security.ssl.transport.pemcert_filepath" = "${certs_dir}/os-node-01.pem";
      "plugins.security.ssl.transport.pemkey_filepath" = "${certs_dir}/os-node-01-key.pem";
      "plugins.security.ssl.transport.pemtrustedcas_filepath" = "${certs_dir}/root-ca.pem";
      "plugins.security.ssl.transport.enforce_hostname_verification" = false;
      "plugins.security.ssl.http.enabled" = true;
      "plugins.security.ssl.http.pemcert_filepath" = "${certs_dir}/os-node-01.pem";
      "plugins.security.ssl.http.pemkey_filepath" = "${certs_dir}/os-node-01-key.pem";
      "plugins.security.ssl.http.pemtrustedcas_filepath" = "${certs_dir}/root-ca.pem";
      "network.host" = "localhost";
    };
  };

  systemd.services.opensearch = {
    environment = {
      OPENSEARCH_INITIAL_ADMIN_PASSWORD = "Admin123";
    };
    preStart = pkgs.lib.mkBefore ''
      if [ ! -d "${certs_dir}" ]; then
        echo "Generating mandatory internal Transport TLS certificates..."
        mkdir -p "${certs_dir}"

        ${lib.getExe pkgs.openssl} genrsa -out ${certs_dir}/admin-key-temp.pem 2048
        ${lib.getExe pkgs.openssl} pkcs8 -inform PEM -outform PEM -in ${certs_dir}/admin-key-temp.pem -topk8 -nocrypt -v1 PBE-SHA1-3DES -out ${certs_dir}/admin-key.pem
        ${lib.getExe pkgs.openssl} req -new -key ${certs_dir}/admin-key.pem -subj "/C=US/ST=NEW YORK/L=BROOKLYN/O=OPENSEARCH/OU=SECURITY/CN=A" -out ${certs_dir}/admin.csr
        
        ${lib.getExe pkgs.openssl} genrsa -out ${certs_dir}/root-ca-key.pem 2048
        ${lib.getExe pkgs.openssl} req -new -x509 -sha256 -key ${certs_dir}/root-ca-key.pem -subj "/C=US/ST=NEW YORK/L=BROOKLYN/O=OPENSEARCH/OU=SECURITY/CN=ROOT" -out ${certs_dir}/root-ca.pem -days 730

        ${lib.getExe pkgs.openssl} x509 -req -in ${certs_dir}/admin.csr -CA ${certs_dir}/root-ca.pem -CAkey ${certs_dir}/root-ca-key.pem -CAcreateserial -sha256 -out ${certs_dir}/admin.pem -days 730
        ${lib.getExe pkgs.openssl} genrsa -out ${certs_dir}/os-node-01-key-temp.pem 2048
        ${lib.getExe pkgs.openssl} pkcs8 -inform PEM -outform PEM -in ${certs_dir}/os-node-01-key-temp.pem -topk8 -nocrypt -v1 PBE-SHA1-3DES -out ${certs_dir}/os-node-01-key.pem
        ${lib.getExe pkgs.openssl} req -new -key ${certs_dir}/os-node-01-key.pem -subj "/C=US/ST=NEW YORK/L=BROOKLYN/O=OPENSEARCH/OU=SECURITY/CN=os-node-01" -out ${certs_dir}/os-node-01.csr
        echo 'subjectAltName=DNS:os-node-01' | tee -a ${certs_dir}/os-node-01.ext
        echo 'subjectAltName=IP:172.20.0.11' | tee -a ${certs_dir}/os-node-01.ext
        ${lib.getExe pkgs.openssl} x509 -req -in ${certs_dir}/os-node-01.csr -CA ${certs_dir}/root-ca.pem -CAkey ${certs_dir}/root-ca-key.pem -CAcreateserial -sha256 -out ${certs_dir}/os-node-01.pem -days 730 -extfile ${certs_dir}/os-node-01.ext

        rm ${certs_dir}/admin-key-temp.pem
        rm ${certs_dir}/admin.csr
        rm ${certs_dir}/os-node-01-key-temp.pem
        rm ${certs_dir}/os-node-01.csr
        rm ${certs_dir}/os-node-01.ext
        rm ${certs_dir}/root-ca.srl

        chown -R opensearch:opensearch "${certs_dir}"
        chmod 600 "${certs_dir}"/*
      fi
    '';
  };
}
