# 第 1 节：git 配置

1. 多账户配置

```
   # github key
Host github

   HostName github.com
   PreferredAuthentications publickey
   IdentityFile ~/.ssh/id_rsa_github
Host gitlab

   HostName gitlab.com
   PreferredAuthentications publickey
   IdentityFile ~/.ssh/id_rsa
```
