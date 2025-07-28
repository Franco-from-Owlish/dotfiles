{ isWSL, ... }:
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
      init = {
        defaultBranch = "main";
      };
      push = {
        default = "tracking";
      };
    };
  };

  programs.jujutsu = {
    enable = true;
  };
}
