{ config, lib, pkgs, ... }:
let
  wofi = pkgs.wofi.overrideAttrs (oa: {
    patches = (oa.patches or [ ]) ++ [
      ./wofi-run-shell.patch # Fix for https://todo.sr.ht/~scoopta/wofi/174
    ];
  });

  pass = config.programs.password-store.package;
  passEnabled = config.programs.password-store.enable;
  rofi-pass = pkgs.rofi-pass.override { inherit pass; };
in
{
  home.packages = [ wofi ] ++
    (lib.optional passEnabled rofi-pass);

  xdg.configFile."wofi/config".text = ''
    image_size=32
    columns=1
    width=600
    height=400
    style=/home/dsod/.config/wofi/styles.css
    allow_images=true
    insensitive=true
    prompt=Search...

    run-always_parse_args=true
    run-cache_file=/dev/null
    run-exec_search=true
  '';

  xdg.configFile."wofi/styles.css".text = ''
    /* Macchiato Teal */
   @define-color accent #8bd5ca;
   @define-color txt #cad3f5;
   @define-color bg #24273a;
   @define-color bg2 #494d64;

 * {
    font-family: 'Ubuntu Nerd Font', monospace;
    font-size: 14px;
 }

 /* Window */
 window {
    margin: 0px;
    padding: 10px;
    border: 3px solid @accent;
    border-radius: 7px;
    background-color: @bg;
    animation: slideIn 0.5s ease-in-out both;
 }

 /* Slide In */
 @keyframes slideIn {
    0% {
       opacity: 0;
    }

    100% {
       opacity: 1;
    }
 }

 /* Inner Box */
 #inner-box {
    margin: 0px;
    padding: 0px;
    border: none;
    background-color: @bg;
    animation: fadeIn 0.5s ease-in-out both;
 }

 /* Fade In */
 @keyframes fadeIn {
    0% {
       opacity: 0;
    }

    100% {
       opacity: 1;
    }
 }

 /* Outer Box */
 #outer-box {
    margin: 5px;
    padding: 5px;
    border: none;
    background-color: @bg;
 }

 /* Scroll */
 #scroll {
    margin: 0px;
    padding: 5px;
    border: none;
 }

 /* Input */
 #input {
    margin: 5px;
    padding: 5px;
    border: none;
    color: @accent;
    background-color: @bg2;
    animation: fadeIn 0.5s ease-in-out both;
 }

 /* Text */
 #text {
    margin: 5px;
    padding: 5px;
    border: none;
    color: @txt;
    animation: fadeIn 0.5s ease-in-out both;
 }

 /* Selected Entry */
 #entry:selected {
   background-color: @accent;
 }

 #entry:selected #text {
    color: @bg;
 }
  '';

   xdg.configFile."wofi/config-text".text = ''
    columns=1
    width=600
    height=400
    style=/home/dsod/.config/wofi/styles-text.css
    allow_images=false
    insensitive=true
    prompt=Search...

    run-always_parse_args=true
    run-cache_file=/dev/null
    run-exec_search=true
  '';

  xdg.configFile."wofi/styles-text.css".text = ''
    /* Macchiato Teal */
@define-color accent #8bd5ca;
@define-color txt #cad3f5;
@define-color bg #24273a;
@define-color bg2 #494d64;

 * {
    font-family: 'Ubuntu Nerd Font', monospace;
    font-size: 14px;
 }

 /* Window */
 window {
    margin: 0px;
    padding: 10px;
    border: 3px solid @accent;
    border-radius: 7px;
    background-color: @bg;
    animation: slideIn 0.5s ease-in-out both;
 }

 /* Slide In */
 @keyframes slideIn {
    0% {
       opacity: 0;
    }

    100% {
       opacity: 1;
    }
 }

 /* Inner Box */
 #inner-box {
    margin: 0px;
    padding: 0px;
    border: none;
    background-color: @bg;
    animation: fadeIn 0.5s ease-in-out both;
 }

 /* Fade In */
 @keyframes fadeIn {
    0% {
       opacity: 0;
    }

    100% {
       opacity: 1;
    }
 }

 /* Outer Box */
 #outer-box {
    margin: 5px;
    padding: 5px;
    border: none;
    background-color: @bg;
 }

 /* Scroll */
 #scroll {
    margin: 0px;
    padding: 5px;
    border: none;
 }

 /* Input */
 #input {
    margin: 5px;
    padding: 5px;
    border: none;
    color: @accent;
    background-color: @bg2;
    animation: fadeIn 0.5s ease-in-out both;
 }

 /* Text */
 #text {
    margin: 0px 5px;
    padding: 2px 3px;
    border: none;
    color: @txt;
    animation: fadeIn 0.5s ease-in-out both;
 }

 /* Selected Entry */
 #entry:selected {
   background-color: @accent;
 }

 #entry:selected #text {
    color: @bg;
 }
  '';

}
