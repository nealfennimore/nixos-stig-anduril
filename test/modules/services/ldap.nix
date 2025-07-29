{ pkgs, ... }:
{
  services.openldap = {
    enable = true;

    # enable plain connections only
    urlList = [ "ldap:///" ];

    settings = {
      attrs = {
        olcLogLevel = "conns config";
      };

      children = {
        "cn=schema".includes = [
          "${pkgs.openldap}/etc/schema/core.ldif"
          "${pkgs.openldap}/etc/schema/cosine.ldif"
          "${pkgs.openldap}/etc/schema/inetorgperson.ldif"
        ];

        "olcDatabase={1}mdb".attrs = {
          objectClass = [
            "olcDatabaseConfig"
            "olcMdbConfig"
          ];

          olcDatabase = "{1}mdb";
          olcDbDirectory = "/var/lib/openldap/data";

          olcSuffix = "dc=example,dc=com";

          # your admin account, do not use writeText on a production system
          olcRootDN = "cn=admin,dc=example,dc=com";
          olcRootPW.path = pkgs.writeText "olcRootPW" "pass";

          olcAccess = [
            # custom access rules for userPassword attributes
            ''
              {0}to attrs=userPassword
                              by self write
                              by anonymous auth
                              by * none''

            # allow read on anything else
            ''
              {1}to *
                              by * read''
          ];
        };
      };
    };
  };
}
