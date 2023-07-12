{ outputs, lib, config, ... }:

{
  programs.ssh = {
  };

  # Passwordless sudo when SSH'ing with keys
  security.pam.enableSSHAgentAuth = true;
}
