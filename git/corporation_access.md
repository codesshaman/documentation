1. Create corporate repo key:

```
ssh-keygen -t ed25519 -C "your_email@example.com" -f ~/.ssh/corporate_repo_key
```

2. Add key to the ssh agent:

```
eval "$(ssh-agent -s)"
```
```
ssh-add ~/.ssh/corporate_repo_key
```

3. SSH-configure setting:

```
nano ~/.ssh/config
```

```
Host corporate-repo
  HostName git.corporate-repo.com
  User git
  IdentityFile ~/.ssh/corporate_repo_key
  StrictHostKeyChecking no
  IdentitiesOnly=yes
```
```
chmod 600 ~/.ssh/config
```

4. Add public key to the corporate repo

```
cat ~/.ssh/corporate_repo_key.pub
```

Add to repository ssh keys

5. Check connection:

```
ssh -T corporate-repo
```

6. Clone your repo:

```
git clone corporate-repo:corporate_repo_group/your_repo.git
```

7. Set your name and email:

```
git config user.name "Corporate User"
```
```
git config user.email "corporate_email@example.com"
```

8. Check settings:

```
git config user.name
```
```
git config user.email
```
```
git config --local --list
```
