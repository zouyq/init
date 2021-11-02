
"github token is [$github_token]"
"target folder is [$target_path]"

$base_url = "https://raw.githubusercontent.com/zouyq/secrets/main/ssh/"
$file_list = @("authorized_keys", 
    "config", 
    "id_dsa", 
    "id_dsa.pub",
    "id_ed25519",
    "id_ed25519.pem",
    "id_ed25519.pub",
    "id_rsa",
    "id_rsa.pub",
    "id_rsa_nopass",
    "id_rsa_nopass.pub")

if (!(Test-Path -Path $target_path)) {
    "create folder [$target_path] with parents" 
    New-Item -Path $target_path -ItemType Directory       
}

$Headers = @{"Authorization" = "Bearer $github_token" } 

For ($i = 0; $i -lt $file_list.Length; $i++) {
    $Url = $base_url + $file_list[$i]
    Invoke-RestMethod -Uri $Url -Method Get -Headers $Headers -OutFile ($target_path + "/" + $file_list[$i])
    Write-Host "download file $file_list[$i] from $Url finished!"
}

