# Git Commands

Init new git repo and rename `master` branch in `main`:

```bash
git init
git pull git@github.com:<username>/<repo-name>.git
# after init in GitHub
git branch -m master main
```

Pull Request:
1. Fork Repo
2. `git clone` original repo
3. create new branch: `git checkout -b [BRANCH_NAME]`
4. commit changes
5. add forked repo as remote repo: `git remote add bensch98 [REPO_PATH]`
6. push to fork: `git push bensch98 [BRANCH_NAME]`
7. copy link for pull request
