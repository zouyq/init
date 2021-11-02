param($token,$ssh_folder)
"github token is [$token]"
"target folder is [$ssh_folder]"

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



if (!(Test-Path -Path $ssh_folder)) {
    "create folder [$ssh_folder] with parents" 
    New-Item -Path $ssh_folder -ItemType Directory       
}

$Headers = @{"Authorization" = "Bearer $token" } 

For ($i = 0; $i -lt $file_list.Length; $i++) {
    $Url = $base_url + $file_list[$i]
    Invoke-RestMethod -Uri $Url -Method Get -Headers $Headers -OutFile ($ssh_folder + "/" + $file_list[$i])
    #Write-Host "download file $file_list[$i] from $Url finished!"
}

