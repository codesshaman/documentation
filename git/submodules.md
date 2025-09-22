Add another repo as submodule to your repo:

For machine keys:

```
git submodule add https://gitlab.com/group-name/repository-name.git module_name
```

Fore some corporate keys (change "corporate-repo" to your key name):

```
git submodule add corporate-repo:group-name/repository-name.git module_name
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

REMOVING:

```
git rm --cached path/to/submodule
```
And clean submodule data in file:

```
nano .gitmodules
```
