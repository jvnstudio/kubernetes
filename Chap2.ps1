New-Item -ItemType Directory $env:USERPROFILE\Apps

setx /m PATH "$env:PATH;$env:USERPROFILE\Apps"

Enable-WindowsOptionalFeature -Online -FeatureName VirtualMachinePlatform -All -NoRestart

podman run --rm hello-world

docker run --rm hello-world

Set-Alias -Name docker -Value podman