{
  lib,
  pkgs,
  isWSL,
  ...
}:
let
  isDarwin = pkgs.stdenv.isDarwin;
  gpgSshSign =
    if isDarwin then
      "/Applications/1Password.app/Contents/MacOS/op-ssh-sign"
    else
      "${lib.getExe' pkgs._1password-cli "op-ssh-sign"}";
in
{
  programs.git = {
    enable = true;
    ignores = [
      "*.DS_Store"
      ".DS_Store"
    ];
    userName = "Franco Grobler";
    userEmail = "franco@grobler.fyi";
    aliases = {
      cleanup = "!git branch --merged | grep  -v '\\*\\|main\\|develop' | xargs -n 1 -r git branch -d";
      prettylog = "log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(r) %C(bold blue)<%an>%Creset' --abbrev-commit --date=relative";
      root = "rev-parse --show-toplevel";
    };
    extraConfig = {
      branch = {
        autosetuprebase = "always";
      };
      color = {
        ui = true;
      };
      commit = {
        gpgsign = true;
      };
      core = {
        askPass = ""; # needs to be empty to use terminal for ask pass
        sshCommand = if isWSL then "ssh.exe" else "ssh";
      };
      credential = {
        helper = "store"; # want to make this more secure
      };
      github = {
        user = "franco-from-gcc";
      };
      gpg = {
        format = "ssh";
      };
      "gpg \"ssh\"" = {
        program = gpgSshSign;
      };
      init = {
        defaultBranch = "main";
      };
      push = {
        default = "tracking";
      };
      user = {
        signingKey = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDSIiPwJz9rAYiMlbrbPEqGFyxYIwf4oi7QNENCJPHWCaFWH2Y54PAVh1dt0FTQaDlY92e+fi/QA/QbJrAfoNuuhwVvP/FpZ8a4ihdljhgpBQZpiSTBa6xnA0QMd0fAOQywcazDoMYRaSMpFoOLvxXCZ+W/eoPeifaOQdNk8zs8RmXXj155nLu3hFJ2lEj2ouCuP0jkCh+k0QeoOjVumsSr1CQWn/TIb9kt1msmlWO0/2CTaMT4+q5uAuuDWxB8V2TcjINeOoDGJnkG79Q3N/jtXV09Mstt6W5qP+x62Rod/eZ+gZYVcGYxeLAFj3eTw6neEup1aLI57UbDkGRVzDAw5/KNuhWrtP6ex/V+ZhQUkU8QiQXIbLzWXt351o4G9a5FBncywLob8YLWM4O1OITlz50ciUeWytUNXIuqMlVvzyueJ4c2LCz8KArNU9avhz0F2whBzDMOlWWDOQGS90OIPfxOtHlUx+YY7oFSpdFqZkwu5Dc1+CvNkCM8oSFlLpc=";
      };
    };
  };

  programs.jujutsu = {
    enable = true;
  };
}
