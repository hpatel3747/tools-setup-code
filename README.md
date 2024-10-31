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
```text
cd /misc/vault_secrets
make vault_token=xxxxxxxxxxxxxxxxxxxxx
```
### To deploy git hub runner
```text
#first create infra(github-runnner instnce)
make infra
```
```text
git pull ; make ansible tool_name=github-runner -e vault_token=""
```
### create token for gh cli
```text
gh api --method POST -H "Accept: application/vnd.github+jason" -H
"X-GitHub-Api-Version: 2022-11-28" /orgs/hpatel3747/actions/runners/registration-token

gh api -H "Accept: application/vnd.github+json" -H "X-GitHub-Api-Version: 2022-11-28" /orgs/hpatel3747/actions/runners/registration-token"

# above will show token
# jq .token  #will show token
#login to github =-runner
#cd /actions-runner
$./config.sh -unattnded --url https:..github.com/hpatel3747 --token {paste-the-token-here} --name $(hostname) --runnergroup Default

```

