{ pkgs, ... }:{
    environment.systemPackages = [
        pkgs.go
        pkgs.golangci-lint
    ];
}