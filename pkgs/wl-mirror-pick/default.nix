# Pick a display to mirror using wl-mirror and slurp
{ writeShellApplication, wl-mirror, slurp }: writeShellApplication {
  name = "wl-mirror-pick";
  runtimeInputs = [ slurp wl-mirror ];

  text = /* bash */ ''
    output=$(slurp -f "%o" -o)
    wl-mirror "$output"
  '';
}
