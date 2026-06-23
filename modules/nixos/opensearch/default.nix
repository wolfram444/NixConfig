{
  pkgs,
  config,
  lib,
  inputs,
  ...
}:

let
  opensearch-fixed = pkgs.opensearch.overrideAttrs
    (final: previous: {
      installPhase = previous.installPhase + ''
        chmod +x $out/plugins/opensearch-security/tools/*.sh
      '';
    });
in
{
  # imports = [ inputs.opensearch-dashboard.nixosModules.default ];
  services.opensearch-dashboards = {
    enable = true;
    # package = packages;
    opensearchHosts = [ "http://localhost:9200" ];
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

      # "plugins.security.disabled" = false;
      # "plugins.security.allow_unsafe_democertificates" = true;
      # "plugins.security.allow_default_init_securityindex" = true;

      # # Transport layer — PEM формат
      # "plugins.security.ssl.transport.pemcert_filepath" = "esnode.pem";
      # "plugins.security.ssl.transport.pemkey_filepath" = "esnode-key.pem";
      # "plugins.security.ssl.transport.pemtrustedcas_filepath" = "root-ca.pem";
      # "plugins.security.ssl.transport.enforce_hostname_verification" = false;

      # # HTTP layer — PEM формат
      # "plugins.security.ssl.http.enabled" = true;
      # "plugins.security.ssl.http.pemcert_filepath" = "esnode.pem";
      # "plugins.security.ssl.http.pemkey_filepath" = "esnode-key.pem";
      # "plugins.security.ssl.http.pemtrustedcas_filepath" = "root-ca.pem";

      # "plugins.security.authcz.admin_dn" = [
      #   "CN=kirk,OU=client,O=client,L=test,C=test"
      # ];
      # "plugins.security.nodes_dn" = [
      #   "CN=opensearch-node1,OU=node,O=node,L=test,C=test"
      # ];
      #=========================================================

      # "cluster.name" = "my-cluster1";
      # "node.name" = "node-1";
      # "network.host" = "127.0.0.1";
      # "http.port" = 9200;
      # "discovery.type" = "single-node";

      # "plugins.security.disabled" = false;
      # "plugins.security.allow_unsafe_democertificates" = true;
      # "plugins.security.allow_default_init_securityindex" = true;

      # # Настройка SSL для межнодового взаимодействия (Transport Layer)
      # "plugins.security.ssl.transport.enforce_profile" = false;
      # "plugins.security.ssl.transport.keystore_filepath" = "esnode.pem";
      # "plugins.security.ssl.transport.truststore_filepath" = "root-ca.pem";

      # # Настройка SSL для внешних запросов / API (HTTP Layer)
      # "plugins.security.ssl.http.enabled" = true;
      # "plugins.security.ssl.http.keystore_filepath" = "esnode.pem";
      # "plugins.security.ssl.http.truststore_filepath" = "root-ca.pem";

      # # Привязка сертификата администратора (kirk) для настройки прав
      # "plugins.security.authcz.admin_dn" = [
      #   "CN=kirk,OU=client,O=client,L=test,C=test"
      # ];
      # "plugins.security.nodes_dn" = [
      #   "CN=opensearch-node1,OU=node,O=node,L=test,C=test"
      # ];

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

      # "plugins.security.disabled" = false;

      # "opensearch.experimental.feature.extensions.enabled" = true;
      # "plugins.security.ssl_only" = true;
      # "plugins.security.ssl.transport.pemcert_filepath" = "${certs_dir}/os-node-01.pem";
      # "plugins.security.ssl.transport.pemkey_filepath" = "${certs_dir}/os-node-01-key.pem";
      # "plugins.security.ssl.transport.pemtrustedcas_filepath" = "${certs_dir}/root-ca.pem";
      # "plugins.security.ssl.transport.enforce_hostname_verification" = false;
      # "plugins.security.ssl.http.enabled" = true;
      # "plugins.security.ssl.http.pemcert_filepath" = "${certs_dir}/os-node-01.pem";
      # "plugins.security.ssl.http.pemkey_filepath" = "${certs_dir}/os-node-01-key.pem";
      # "plugins.security.ssl.http.pemtrustedcas_filepath" = "${certs_dir}/root-ca.pem";
      # "network.host" = "localhost";

      ######## Start OpenSearch Security Demo Configuration ########
      # WARNING: revise all the lines below before you go into production
      # "plugins.security.ssl.transport.pemcert_filepath" = "esnode.pem";
      # "plugins.security.ssl.transport.pemkey_filepath" = "esnode-key.pem";
      # "plugins.security.ssl.transport.pemtrustedcas_filepath" = "root-ca.pem";
      # "transport.ssl.enforce_hostname_verification" = false;
      # "plugins.security.ssl.http.enabled" = true;
      # "plugins.security.ssl.http.pemcert_filepath" = "esnode.pem";
      # "plugins.security.ssl.http.pemkey_filepath" = "esnode-key.pem";
      # "plugins.security.ssl.http.pemtrustedcas_filepath" = "root-ca.pem";
      # "plugins.security.allow_unsafe_democertificates" = true;
      # "plugins.security.allow_default_init_securityindex" = true;
      # "plugins.security.authcz.admin_dn" = [
      #   "CN=kirk,OU=client,O=client,L=test,C=de"
      # ];
      # "plugins.security.audit.type" = "internal_opensearch";
      # "plugins.security.enable_snapshot_restore_privilege" = true;
      # "plugins.security.check_snapshot_restore_write_privileges" = true;
      # "plugins.security.restapi.roles_enabled" = [
      #   "all_access"
      #   "security_rest_api_access"
      # ];
      # "plugins.security.system_indices.enabled" = true;
      # "network.host" = "0.0.0.0";
      # "node.name" = "smoketestnode";
      # "cluster.initial_cluster_manager_nodes" = "smoketestnode";
      # "node.max_local_storage_nodes" = 3;
      ######## End OpenSearch Security Demo Configuration ########
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
