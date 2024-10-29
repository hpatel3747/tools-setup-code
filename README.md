## tools-setup-code

Tools will deploy hashicorp vault instance, there are three steps

### 1. create instance
```text
make infra
```
 ### 2.Install vault on ec2 instance
```text
make ansible tool_name=vault
```
### 3. login to vault
```text
http://vault_public_ip:8200
Download keys in the json format
```
### 4. add passwords and parameter values in the vault
cd /misc/vault_secrets
make vault_token=xxxxxxxxxxxxxxxxxxxxx

