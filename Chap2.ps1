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

docker run --rm hello-world

Set-Alias -Name docker -Value podman

# Install Kind https://kind.sigs.k8s.io/docs/user/quick-start/
curl.exe -Lo kind-windows-amd64.exe https://kind.sigs.k8s.io/dl/v0.31.0/kind-windows-amd64
Move-Item .\kind-windows-amd64.exe F:\Kubernetes_K8s\kind.exe

# Install Helm https://helm.sh/docs/intro/install & https://github.com/helm/helm/releases
# For Windows:
# Download Helm from https://github.com/helm/helm/releases
curl -fsSL -o helm.zip https://get.helm.sh/helm-v3.6.3-windows-amd64.zip

# Decompress the file:
Expand-Archive -DestinationPath $env:USERPROFILE\apps helm-v4.1.3-windows-amd64.zip

#Move the Helm file to the apps directory:
mv $env:USERPROFILE\apps\windows-amd64\helm.exe $env:USERPROFILE\apps\helm.exe

Verify the installation:
helm version