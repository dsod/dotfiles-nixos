final: prev:
{
  neovim-unwrapped = prev.neovim-unwrapped.overrideAttrs (oldAttrs:
    let
      nixpackdir = ''
        set packpath^=${prev.vimUtils.packDir oldAttrs.packpathDirs}
        set rtp^=${prev.vimUtils.packDir oldAttrs.packpathDirs}
      '';
    in
    {
      nixpackdir = nixpackdir;
    }); 
}