{pkgs, ...}: {
    home.packages = with pkgs; [
        awscli2
    ];

  home.file.".aws/config".text = ''
    [profile qbnk-prod]
    sso_session = qbnk-prod
    sso_account_id = 408592795527
    sso_role_name = QbankProdAccess
    region = eu-north-1
    output = json

    [sso-session qbnk-prod]
    sso_region = eu-west-1
    sso_start_url = https://qloudx.awsapps.com/start#
    sso_registration_scopes = sso:account:access

    [profile qbnk-staging]
    sso_session = qbnk-staging
    sso_account_id = 679932716217
    sso_role_name = QbankStagingAccess
    region = eu-north-1
    output = json

    [sso-session qbnk-staging]
    sso_region = eu-west-1
    sso_start_url = https://qloudx.awsapps.com/start#
    sso_registration_scopes = sso:account:access

    [profile qbnk-dev]
    sso_session = qbnk-dev
    sso_account_id = 674406042406
    sso_role_name = QbankDevAccess
    region = eu-north-1
    output = json

    [sso-session qbnk-dev]
    sso_region = eu-west-1
    sso_start_url = https://qloudx.awsapps.com/start#
    sso_registration_scopes = sso:account:access
  '';
}
