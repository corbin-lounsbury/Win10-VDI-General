#net use z: \\blap-sto3\isovol1 /user:guest password
New-SmbMapping -LocalPath "Z:" -RemotePath "\\blap-sto3\isovol1" -persistent $true -username Guest -password "password"