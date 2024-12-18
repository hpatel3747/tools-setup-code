## tools-setup-code

Tools will deploy hashicorp vault and github-runner instances

### 1. create instance
```text
#first create infra(github-runner and vault instance) (if run again will create new DNS entries for both instances)
#if need to recreate instances, do "terraform destroy" first and then "make infra"
make infra
```
 ### 2.Install vault on ec2 instance
```text
make ansible tool_name=vault
```
### 3. login to vault
```text
http://vault.hptldevops.online:8200/
Key shares: 1
Key threshold: 1
click initialize
Download keys in the json format
click on continue to Unseal
enter the key from the downloaded keys
enter the token to login
```
### 4. add passwords and parameter values in the vault
```text
cd misc/vault_secrets
make vault_token=xxxxxxxxxxxxxxxxxxxxx
login and verify that two Key Voults are created
1. infra-secrets
2. Roboshop-dev
```
-Note: every time you stop and start vault make you sure you unseal the vault for further process
### 5. deploy github-runner (provide token in following steps from step 3 )
```text
git pull ; make ansible tool_name=github-runner -e vault_token=""
```
### 6. login to github-runner and do these steps
```text
login to github-runner
click on organization hpatel3747 | settings | Actions | runners | New runner | New Self-hosted runnner | Linux
mkdir actions-runner && cd actions-runner
curl -o actions-runner-linux-x64-2.320.0.tar.gz -L https://github.com/actions/runner/releases/download/v2.320.0/actions-runner-linux-x64-2.320.0.tar.gz
tar xzf ./actions-runner-linux-x64-2.320.0.tar.gz
./config.sh --url https://github.com/hpatel3747 --token BMS6GP7JUH5EOLBONQMS7T3HET5Z6
./run.sh
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
### How to add disk space 
1. stop the instance (github-runner instance in this case)
2. add 10 gb on the instance volume
3. start the instance and login
4. use following three commands to extend diskspace and add 10gb to the home volume
```text
df -h
sudo growpart /dev/nvme0n1 4
sudo lvextend -r -L +10g /dev/mapper/RootVG-homeVol
```
### how to make call to token from workflow
- Github allows to store the secret in github | hpatel3747 | settings | security | secrets and variables | actions | New organization secret
- create secret vault_token with appropriate token value. This will be called in workflow in github/action 
### how to unseal vault
login to vault server and sudo this cmd
```text
# VAULT_ADDR=http://127.0.0.1:8200 vault operator unseal "type_in_unseal)key"
```
