{ pkgs ? import <nixpkgs> {} }:

pkgs.mkShell {
  name = "vw-map-updater";
  
  buildInputs = with pkgs; [
    p7zip        # for 7za extraction
    util-linux   # for lsblk, mount
    coreutils    # for cp, rm, du, etc.
    bash
  ];
  
  shellHook = ''
    echo "VW Map Update Environment"
    echo "========================="
    echo "Available commands:"
    echo "  ./vw-map-update  - Run the update script"
    echo ""
    echo "Dependencies loaded:"
    echo "  - 7za: $(which 7za)"
    echo "  - lsblk: $(which lsblk)"
    echo ""
  '';
}
