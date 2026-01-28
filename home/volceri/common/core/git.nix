{
  configVars,
  ...
}:
let
  # username = configVars.userSettings.username;
  name = configVars.userSettings.name;
  publicGitEmail = configVars.userSettings.email;
  signingKey = configVars.userSettings.signingKey;
  # publicKey = "${config.home.homeDirectory}/.ssh/id_yubikey.pub";
in
{
  programs.git = {
    enable = true;
    # package = pkgs.gitAndTools.gitFull;
    settings = {
      alias = {
        # ---- General ----
        al = "config --get-regexp ^alias";

        # ---- Status & context ----

        # Short status + branch + ahead/behind
        # Example: git st
        st = "status -sb";

        # List local branches with last commit
        # Example: git br
        br = "branch -v";

        # ---- Branch navigation ----

        # Switch branches (modern replacement for checkout)
        # Example: git sw main
        sw = "switch";

        # Checkout (still useful for files, older muscle memory)
        # Example: git co develop
        co = "checkout";

        # Create and switch to a new branch
        # Example: git cb feature/login
        cb = "checkout -b";

        # Delete branch safely (refuses if not merged)
        # Example: git bd feature/login
        bd = "branch -d";

        # Force delete branch (dangerous)
        # Example: git bD feature/login
        bD = "branch -D";

        # ---- Staging ----

        # Stage all changes (tracked + untracked)
        # Example: git aa
        aa = "add -A";

        # Interactive / partial staging (very useful)
        # Example: git ap
        ap = "add -p";

        # ---- Commits (signed)----

        # Commit with message (signed)
        # Example: git cm \"Fix login bug\"
        c = "commit -S";

        # Commit with message (signed)
        # Example: git cm \"Fix login bug\"
        cm = "commit -S -m";

        # Amend last commit (signed; edit message or content)
        # Example: git ca
        ca = "commit -S --amend";

        # Amend last commit without changing message (signed)
        # Example: git caa
        caa = "commit -S --amend --no-edit";
        # ---- Logs & history ----

        # Pretty, compact commit log
        # Example: git lg
        lg = "log --oneline --graph --decorate";

        # Same as lg, but across all branches
        # Example: git lga
        lga = "log --oneline --graph --decorate --all";

        # Show full details of last commit
        # Example: git last
        last = "log -1 HEAD";

        # ---- Remotes & syncing ----

        # Pull changes from remote
        # Example: git p
        p = "pull";

        # Pull using rebase (keeps history linear)
        # Example: git pl
        pl = "pull --rebase";

        # Push current branch
        # Example: git ps
        ps = "push";

        # Push and set upstream to origin
        # Example: git psu
        psu = "push -u origin HEAD";

        # ---- Recovery & cleanup ----

        # Undo last commit, keep changes staged
        # Example: git undo
        undo = "reset --soft HEAD~1";

        # Unstage files without losing changes
        # Example: git unstage file.txt
        unstage = "reset HEAD --";

        # Discard local changes to files (destructive!)
        # Example: git discard file.txt
        discard = "checkout --";

        # ---- Merge helpers ----

        # List files with merge conflicts
        # Example: git conflicts
        conflicts = "diff --name-only --diff-filter=U";

        # ---- Stash ----
        s = "stash";
        sa = "stash apply";
        sa0 = "stash apply stash@{0}";

      };

      user.name = name;
      user.email = publicGitEmail;

      log.showSignature = "true";
      init.defaultBranch = "main";
      pull.rebase = "false";
      url = {
        "ssh://git@github.com" = {
          insteadOf = "https://github.com";
        };
        "ssh://git@git.naspersclassifieds.com/" = {
          insteadOf = "https://git.naspersclassifieds.com/";
        };
      };

      commit.gpgsign = true;
      user.signingkey = signingKey;
      # Taken from https://github.com/clemak27/homecfg/blob/16b86b04bac539a7c9eaf83e9fef4c813c7dce63/modules/git/ssh_signing.nix#L14
      # gpg.ssh.allowedSignersFile = "${config.home.homeDirectory}/.ssh/allowed_signers";

      # save.directory = "${config.home.homeDirectory}/sync/obsidian-vault-01/wiki";
    };
    # signing = {
    #   signByDefault = true;
    #   key = publicKey;
    # };
    ignores = [

    ];
  };
  # NOTE: To verify github.com update commit signatures, you need to manually import
  # https://github.com/web-flow.gpg... would be nice to do that here
  # home.file.".ssh/allowed_signers".text = ''
  #   ${publicGitEmail} ${lib.fileContents (configLib.relativeToRoot "hosts/common/users/${username}/keys/id_maya.pub")}
  #   ${publicGitEmail} ${lib.fileContents (configLib.relativeToRoot "hosts/common/users/${username}/keys/id_mara.pub")}
  #   ${publicGitEmail} ${lib.fileContents (configLib.relativeToRoot "hosts/common/users/${username}/keys/id_manu.pub")}
  # '';
}
