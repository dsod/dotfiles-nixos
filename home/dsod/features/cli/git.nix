{ pkgs, lib, config, ... }:
{
  programs.git = {
    enable = true;
    package = pkgs.gitAndTools.gitFull;
    aliases = {
      pushall = "!git remote | xargs -L1 git push --all";
      graph = "log --decorate --oneline --graph";
      add-nowhitespace = "!git diff -U0 -w --no-color | git apply --cached --ignore-whitespace --unidiff-zero -";
    };
    userName = "dsod";
    userEmail = "daniel.soderling@gmail.com";
    extraConfig = {
      feature.manyFiles = true;
      init.defaultBranch = "main";
      pull.rebase = true;
      push.autoSetupRemote = true;
    };
    lfs.enable = true;
    ignores = [ ".direnv" "result" ".devenv" ];
    signing = {
      key = "D1143A08BCBB1D288B4B8DC02904956C7390AFC3";
      signByDefault = false;
    };
  };
}
