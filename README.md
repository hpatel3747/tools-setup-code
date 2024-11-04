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
2.roboshop-dev
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

