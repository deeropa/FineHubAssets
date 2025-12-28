
$Target = "C:\Users"
$EncryptedExtension = ".weedhack"
$count = 0

Write-Host "========================================" -ForegroundColor Green
Write-Host "        WEEDHACK DECRYPTOR              " -ForegroundColor Green
Write-Host "========================================" -ForegroundColor Green


$keyFile = "$env:USERPROFILE\Desktop\WEEDHACK_RECOVERY_KEY.txt"
if (-not (Test-Path $keyFile)) {
    Write-Host "ERROR: Recovery key file not found on Desktop!" -ForegroundColor Red
    Write-Host "Expected: WEEDHACK_RECOVERY_KEY.txt" -ForegroundColor Yellow
    Write-Host "Please enter the AES Key (Base64):" -ForegroundColor Yellow
    $keyB64 = Read-Host "Key"
    Write-Host "Please enter the AES IV (Base64):" -ForegroundColor Yellow
    $ivB64 = Read-Host "IV"
} else {
    $content = Get-Content $keyFile -Raw
    if ($content -match "AES Key \(Base64\): ([A-Za-z0-9+/=]+)") {
        $keyB64 = $matches[1]
    }
    if ($content -match "AES IV \(Base64\): ([A-Za-z0-9+/=]+)") {
        $ivB64 = $matches[1]
    }
    Write-Host "Recovery key loaded from: $keyFile" -ForegroundColor Green
}


try {
    $key = [Convert]::FromBase64String($keyB64)
    $iv = [Convert]::FromBase64String($ivB64)
} catch {
    Write-Host "ERROR: Invalid Base64 key/IV format!" -ForegroundColor Red
    exit
}


$aes = [System.Security.Cryptography.Aes]::Create()
$aes.Key = $key
$aes.IV = $iv
$decryptor = $aes.CreateDecryptor()

Write-Host "Scanning for encrypted files..." -ForegroundColor Yellow
$files = Get-ChildItem $Target -Recurse -File -ErrorAction SilentlyContinue | 
    Where-Object { $_.Extension -eq $EncryptedExtension }

Write-Host "Found $($files.Count) encrypted files" -ForegroundColor Yellow

Write-Host "Decrypting files..." -ForegroundColor Yellow
foreach ($file in $files) {
    try {
  
        $encryptedData = [IO.File]::ReadAllBytes($file.FullName)
        
   
        $fileIV = $encryptedData[0..15]
        $cipherText = $encryptedData[16..($encryptedData.Length-1)]
        
      
        $aes.IV = $fileIV
        $decryptor = $aes.CreateDecryptor()
        
   
        $decrypted = $decryptor.TransformFinalBlock($cipherText, 0, $cipherText.Length)
        
      
        $originalPath = $file.FullName.Substring(0, $file.FullName.Length - $EncryptedExtension.Length)
        
       
        [IO.File]::WriteAllBytes($originalPath, $decrypted)
        
    
        [IO.File]::Delete($file.FullName)
        
        $count++
        if ($count % 100 -eq 0) {
            Write-Host "[$count/$($files.Count)]" -NoNewline
        } elseif ($count % 20 -eq 0) {
            Write-Host "." -NoNewline
        }
        
    } catch {
        Write-Host "Failed to decrypt: $($file.FullName)" -ForegroundColor Red
        continue
    }
}

Write-Host "`n`nDecrypted $count/$($files.Count) files" -ForegroundColor Green


$removeKey = Read-Host "Remove recovery key file? (y/n)"
if ($removeKey -eq 'y' -or $removeKey -eq 'Y') {
    if (Test-Path $keyFile) {
        Remove-Item $keyFile -Force
        Write-Host "Recovery key removed" -ForegroundColor Yellow
    }
}

Write-Host "Decryption complete!" -ForegroundColor Green
Write-Host "Restored files to original locations" -ForegroundColor Green
