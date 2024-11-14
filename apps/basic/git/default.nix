{ pkgs, ... }: 

{
  programs.git = {
    enable = true;
  };

  home.file = {
    ".config/git/config".source = ./config;
  };
}