Add another repo as submodule to your repo:

```
git suиmodule add git clone corporate-repo:corporate_repo_group/your_app_repo.git app
```
Change directory:

``cd app``

Change branch to your target branch:

``git checkout master``

Pull last changes:

```
git fetch
git pull
```

Move to your repo root:

``cd ..`` or ``cd -``

Check modules file:

``cat .gitmodules``

Check git config:

``cat .git/config``

Update all submodules code:

``git submodule update --init --recursive``

Or update only target submodule (as example app):

``git submodule update --init --recursive app``

Add 
