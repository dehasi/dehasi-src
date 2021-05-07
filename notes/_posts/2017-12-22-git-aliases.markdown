---
layout: post
title:  "My git aliases"
---

I had a problem with systax formatting. That's why I've created a gist [gist](https://gist.github.com/dehasi/5b498ccf29c1f5e74aca861dc7ffd461).

```
# Switch to a branch, creating it if necessary
go = "!f() { git checkout -b \"$1\" 2> /dev/null || git checkout \"$1\"; }; f"

# Amend the currently staged files to the latest commit
amend = commit --amend --reuse-message=HEAD

# Interactive rebase with the given number of latest commits
reb = "!r() { git rebase -i HEAD~$1; }; r"

# Remove branches that have already been merged with master
dm = "!git branch --merged | grep -v '\\*' | xargs -n 1 git branch -d"

pr = pull --rebase
pf = push --force
rc = rebase --continue
remotes = remote -v
unstage = reset --mixed HEAD~1
last = log -1 HEAD
co = checkout
ci = commit
st = status
br = branch
bd = branch -d
alias = config --get-regexp ^alias\\.
d = difftool
show-files = show --pretty="format:" --name-only
oldest-ancestor = !zsh -c 'diff -u <(git rev-list --first-parent "${1:-master}") <(git rev-list --first-parent "${2:-HEAD}") | sed -ne \"s/^ //p\" | head -1' -
lg = log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit --date=relative
logp = log --graph --abbrev-commit --decorate --all --format=format:\"%C(bold blue)%h%C(reset) - %C(bold cyan)%aD%C(dim white) - %an%C(reset) %C(bold green)(%ar)%C(reset)%C(bold yellow)%d%C(reset)%n %C(white)%s%C(reset)\"
last = diff HEAD~1...HEAD
```
