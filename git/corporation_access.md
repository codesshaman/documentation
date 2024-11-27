1. Create corporate repo key:

``ssh-keygen -t ed25519 -C "your_email@example.com" -f ~/.ssh/corporate_repo_key``

2. Add key to the ssh agent:

```
   eval "$(ssh-agent -s)"
   ssh-add ~/.ssh/corporate_repo_key
```

4. SSH-configure setting:

``nano ~/.ssh/config``

```
Host corporate-repo
  HostName git.corporate-repo.com
  User git
  IdentityFile ~/.ssh/corporate_repo_key
```
4. Add public key to the corporate repo

``cat ~/.ssh/corporate_repo_key.pub``


