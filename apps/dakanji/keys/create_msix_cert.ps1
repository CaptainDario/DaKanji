# create certificate for msix
$CertPassword = ConvertTo-SecureString -String "<<PASSWORD>>" -Force -AsPlainText
$cert = New-SelfSignedCertificate -DnsName EC6A3F44-67FB-44EF-B45B-1DACD55293B9 -Type CodeSigning -CertStoreLocation Cert:\CurrentUser\My -NotAfter (Get-Date).AddYears(100)
Export-PfxCertificate -Cert "cert:\CurrentUser\My\$($cert.Thumbprint)" -FilePath ".\keys\dakanji_self_sign_msix.pfx" -Password $CertPassword

# validate certificate
Get-PfxCertificate -FilePath ".\keys\dakanji_self_sign_msix.pfx"

# test sign msix
dart run msix:create --install-certificate=false --build-windows=false -c .\keys\dakanji_self_sign_msix.pfx -p "<<PASSWORD>>"

# export certificate as base64
$bytes = [System.IO.File]::ReadAllBytes(".\keys\dakanji_self_sign_msix.pfx")
$base64 = [Convert]::ToBase64String($bytes)
Set-Content -Path ".\keys\dakanji_self_sign_msix_base64.txt" -Value $base64