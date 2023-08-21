{ pkgs, lib, config, ... }:
{
  home.packages = with pkgs; [lazygit];
  programs.git = {
    enable = true;
    package = pkgs.gitAndTools.gitFull;
    aliases = {
      pushall = "!git remote | xargs -L1 git push --all";
      graph = "log --decorate --oneline --graph";
      add-nowhitespace = "!git diff -U0 -w --no-color | git apply --cached --ignore-whitespace --unidiff-zero -";
    };
    userName = "dsod";
    userEmail = "d.soderling@live.se";
    extraConfig = {
      feature.manyFiles = true;
      init.defaultBranch = "main";
      pull.rebase = true;
    };
    lfs.enable = true;
    ignores = [ ".direnv" "result" ];
  };
}
