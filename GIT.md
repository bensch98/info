# Git Commands

Init new git repo and rename `master` branch in `main`:

```bash
git init
git pull git@github.com:<username>/<repo-name>.git
# after init in GitHub
git branch -m master main
```

Create a new branch:
```bash
git checkout -b feature/branch-name
# git add . && git commit -m 'commits'
git push -u origin feature/branch-name
```

After pushing the local branch to the remote repo, a Pull Request can be created.
When the PR is accepted the branch can be deleted in the web UI or via the CLI like this:
```bash
git push origin --delete feature/branch-name
# or
git push origin :feature/branch-name
```

In case no PR is needed, the changes of one branch can also simply merged into another branch:
```bash
git checkout main
git merge feature/branch-name
git branch -d feature/branch-name
```

The `git merge` command merges the changes of the specified branch into the currently active one.

Pull Request:
1. Fork Repo
2. `git clone` original repo
3. create new branch: `git checkout -b [BRANCH_NAME]`
4. commit changes
5. add forked repo as remote repo: `git remote add bensch98 [REPO_PATH]`
6. push to fork: `git push bensch98 [BRANCH_NAME]`
7. copy link for pull request
