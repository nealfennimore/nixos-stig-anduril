{ ... }:
{
  services.sssd.config = ''
    [sssd]
    config_file_version = 2
    services = pam
    domains = example.com

    [domain/example.com]
    id_provider = ldap
    auth_provider = ldap

    ldap_uri = ldap://localhost
    ldap_search_base = DC=example,DC=com

    debug_level = 9
    enumerate = false
    cache_credentials = true
  '';
}
