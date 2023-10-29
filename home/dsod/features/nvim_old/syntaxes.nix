{ pkgs, config, lib, ... }:
{
  programs.neovim = {
    extraConfig = lib.mkAfter /* vim */ ''
      function! SetCustomKeywords()
        syn match Todo  /TODO/
        syn match Done  /DONE/
        syn match Start /START/
        syn match End   /END/
      endfunction

      autocmd Syntax * call SetCustomKeywords()
    '';
    plugins = with pkgs.vimPlugins; [
      vim-markdown
      vim-nix
      vim-toml
      pgsql-vim
      vim-terraform
      vim-jsx-typescript
      vim-caddyfile
      emmet-vim

      # Tree sitter
      {
        plugin = pkgs.vimPlugins.nvim-treesitter;
        type = "lua";
        config = /* lua */ ''
          require('nvim-treesitter.configs').setup{
            highlight = {
              enable = true,
              additional_vim_regex_highlighting = false,
            },
          }
        '';
      }
    ];
  };
}
