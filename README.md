#### Sample ~/.ssh/config to use with bastion

```
StrictHostKeyChecking no
UserKnownHostsFile /dev/null
UseKeychain    yes
AddKeysToAgent yes

Host bastion
  HostName bastion.domain.tld
  Port 22222
  ProxyCommand none

Host target1
  HostName target1.domain.tld
  User root
  Port 2222

Host target2
  Hostname target2.domain.tld
  Port 222
  ProxyCommand ssh -o StrictHostKeyChecking=no -W %h:%p bastion

Host * !github.com !bitbucket.org
  PreferredAuthentications=publickey
  Protocol 2
  AddressFamily inet
  ControlMaster auto
  ControlPath ~/.ssh/sockets/%r-%h-%p
  ControlPersist 10m
  ServerAliveInterval 3
  ServerAliveCountMax 60
  ExitOnForwardFailure yes
  Compression yes
  LogLevel INFO
 ```
