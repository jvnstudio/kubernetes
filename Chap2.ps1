# Chap 2: Setting up Your Env
Here are the key takeaways from the video:

Podman Desktop: Simplifies running containers on regular machines and is similar to Docker Desktop or Rancher Desktop.
kind: Allows you to create Kubernetes clusters entirely in Docker without extra VMs.
Helm: A popular tool for packaging applications for Kubernetes clusters, making deployment easier.
kubectl: The official CLI for managing Kubernetes clusters.
AWS and Azure CLI: Used for deploying clusters in AWS and Azure, respectively.

These tools will help you manage and deploy your Kubernetes project efficiently.

New-Item -ItemType Directory $env:USERPROFILE\Apps

setx /m PATH "$env:PATH;$env:USERPROFILE\Apps"

Enable-WindowsOptionalFeature -Online -FeatureName VirtualMachinePlatform -All -NoRestart

wsl --install

podman run --rm hello-world

Set-Alias -Name docker -Value podman

docker run --rm hello-world


# Install Kind https://kind.sigs.k8s.io/docs/user/quick-start/
curl.exe -Lo kind-windows-amd64.exe https://kind.sigs.k8s.io/dl/v0.31.0/kind-windows-amd64
Move-Item .\kind-windows-amd64.exe F:\Kubernetes_K8s\kind.exe

# Install Helm https://helm.sh/docs/intro/install & https://github.com/helm/helm/releases
# For Windows:
# Download Helm from https://github.com/helm/helm/releases
# OR run curl -fsSL -o helm.zip https://get.helm.sh/helm-v3.6.3-windows-amd64.zip

# Decompress the file:
Expand-Archive -DestinationPath $env:USERPROFILE\apps helm-v4.1.3-windows-amd64.zip

#Move the Helm file to the apps directory:
mv $env:USERPROFILE\apps\windows-amd64\helm.exe $env:USERPROFILE\apps\helm.exe

#Verify the installation:
.\helm version

rm 'C:\Users\Johnnyvng.JVDNT\Apps\windows-amd64'


# INSTALL AWS CLI
winget install --exact --id Amazon.AWSCLI
# OR
Invoke-WebRequest -Uri "https://awscli.amazonaws.com/AWSCLIV2.msi" -OutFile "$env:TEMP\AWSCLIV2.msi"
Start-Process msiexec.exe -Wait -ArgumentList "/i `"$env:TEMP\AWSCLIV2.msi`" /qn"


# INSTALL AZURE CLI
# Azure CLI
Invoke-WebRequest -Uri "https://aka.ms/installazureclizipx64" -OutFile "$env:TEMP\AzureCLI.zip"
Expand-Archive "$env:TEMP\AzureCLI.zip" -DestinationPath "$HOME\azure-cli" -Force


# INSTALL EKSCTL

# Here are the key takeaways from the video on installing EKS CTL:

# Installation on Mac: Visit eksctl.io, navigate to the installation section, copy the Unix installation command, and run it in the terminal.
# Installation on Windows: Visit eksctl.io, navigate to the installation section, download the appropriate zip file, and use PowerShell to extract and move it to the apps directory.
# Verification: Confirm the installation by running eksctl version to ensure it returns a version number.

# Download from https://github.com/eksctl-io/eksctl
Expand-Archive -DestinationPath C:\Users\Johnnyvng.JVDNT\Apps\ C:\Users\Johnnyvng.JVDNT\Downloads\eksctl_Windows_amd64.zip

# CONFIGURE AWS CLI
# SETUP USER > ROLE IN AWS then copy Access Key ID and Secret Access Key
# Creating a User: Create a user in AWS IAM without permissions and generate access keys.
# Creating a Role: Create a role with specific permissions and configure trust relationships to allow the user to assume the role.
# Configuring AWS CLI: Use the aws configure command to set up the AWS CLI with the user's access keys.
aws configure
# Assuming the Role: Use the aws sts assume-role command to assume the created role and set environment variables for session tokens.
aws sts assume-role --role-arn arn:aws:iam::546079882565:role/K8s --external-id SuperSecret_ExtID --role-session-name JVN_K8s_SessionName

# In PowerShell, capture the returned credentials and export them with $env: variables.
# If aws sts get-caller-identity still shows the IAM user ARN, you have not switched into the role yet.
$role = aws sts assume-role --role-arn arn:aws:iam::546079882565:role/K8s --external-id SuperSecret_ExtID --role-session-name JVN_K8s_SessionName | ConvertFrom-Json
$env:AWS_ACCESS_KEY_ID = $role.Credentials.AccessKeyId
$env:AWS_SECRET_ACCESS_KEY = $role.Credentials.SecretAccessKey
$env:AWS_SESSION_TOKEN = $role.Credentials.SessionToken

# Verification: Verify the setup by running AWS CLI commands to ensure permissions are correctly applied.
aws sts get-caller-identity
aws ec2 describe-instances --max-items 1


# CONFIGURE AZURE CLI
# Here are the key takeaways from the video on configuring Azure access interactively:

# Interactive Login Method: This method is easy to use but not suitable for automation as it requires a browser for login.
# Running az login: On Windows, a pop-up will appear for login; on Mac, use az login --use-device-code to authenticate via a code.
az login
# Verification: After logging in, you can verify by running az group list to see the groups in your subscription.
az group list


# Here are the key takeaways from the video on logging into Azure with a service principal:

# Create a Service Principal: Use the Azure CLI to create a service principal with az ad sp create-for-rbac.
az account show
PS C:\Users\Johnnyvng.JVDNT\Documents\GitHub\kubernetes> az account show
{
  "environmentName": "AzureCloud",
  "homeTenantId": "12630675-1f0d-411c-ace5-a77cd5f48912",
  "id": "5eaeebcc-b962-4628-98d1-8e0fe5d276a3",
  "isDefault": true,
  "managedByTenants": [],
  "name": "Azure for Students",
  "state": "Enabled",
  "tenantDefaultDomain": "exchangelabs.gmu.edu",
  "tenantDisplayName": "George Mason University",
  "tenantId": "12630675-1f0d-411c-ace5-a77cd5f48912",
  "user": {
    "name": "dnguye33@masonlive.gmu.edu",
    "type": "user"
  }
}


az ad sp create-for-rbac --name "myServicePrincipal" --role="Owner" --scopes="/subscriptions/5eaeebcc-b962-4628-98d1-8e0fe5d276a3"

# Set Role and Scope: Assign the service principal an owner role and specify the subscription scope.
# Login with Service Principal: Use az login --service-principal along with the app ID, password, and tenant ID to log in.
# Verification: Confirm the login by checking the user property in the returned JSON object, which should indicate servicePrincipal.


