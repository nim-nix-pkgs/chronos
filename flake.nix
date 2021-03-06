{
  description = ''An efficient library for asynchronous programming'';

  inputs.flakeNimbleLib.owner = "riinr";
  inputs.flakeNimbleLib.ref   = "master";
  inputs.flakeNimbleLib.repo  = "nim-flakes-lib";
  inputs.flakeNimbleLib.type  = "github";
  inputs.flakeNimbleLib.inputs.nixpkgs.follows = "nixpkgs";
  
  inputs."chronos-master".dir   = "master";
  inputs."chronos-master".owner = "nim-nix-pkgs";
  inputs."chronos-master".ref   = "master";
  inputs."chronos-master".repo  = "chronos";
  inputs."chronos-master".type  = "github";
  inputs."chronos-master".inputs.nixpkgs.follows = "nixpkgs";
  inputs."chronos-master".inputs.flakeNimbleLib.follows = "flakeNimbleLib";
  
  outputs = { self, nixpkgs, flakeNimbleLib, ...}@inputs:
  let 
    lib  = flakeNimbleLib.lib;
    args = ["self" "nixpkgs" "flakeNimbleLib"];
  in lib.mkProjectOutput {
    inherit self nixpkgs;
    meta = builtins.fromJSON (builtins.readFile ./meta.json);
    refs = builtins.removeAttrs inputs args;
  };
}