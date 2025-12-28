# WEEDHACK DECRYPTOR
# Restores files encrypted with .weedhack extension

$Target = "C:\Users"
$EncryptedExtension = ".weedhack"
$count = 0

Write-Host "========================================" -ForegroundColor Green
Write-Host "        WEEDHACK DECRYPTOR              " -ForegroundColor Green
Write-Host "========================================" -ForegroundColor Green

# Get recovery key from Desktop
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

# Convert Base64 strings back to bytes
try {
    $key = [Convert]::FromBase64String($keyB64)
    $iv = [Convert]::FromBase64String($ivB64)
} catch {
    Write-Host "ERROR: Invalid Base64 key/IV format!" -ForegroundColor Red
    exit
}

# Create AES decryptor
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
        # Read the encrypted file
        $encryptedData = [IO.File]::ReadAllBytes($file.FullName)
        
        # Extract IV (first 16 bytes) and encrypted content (rest)
        $fileIV = $encryptedData[0..15]
        $cipherText = $encryptedData[16..($encryptedData.Length-1)]
        
        # Set the IV (should match, but using from file for safety)
        $aes.IV = $fileIV
        $decryptor = $aes.CreateDecryptor()
        
        # Decrypt
        $decrypted = $decryptor.TransformFinalBlock($cipherText, 0, $cipherText.Length)
        
        # Determine original filename (remove .weedhack extension)
        $originalPath = $file.FullName.Substring(0, $file.FullName.Length - $EncryptedExtension.Length)
        
        # Write decrypted file
        [IO.File]::WriteAllBytes($originalPath, $decrypted)
        
        # Delete encrypted file
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

# Remove recovery key if requested
$removeKey = Read-Host "Remove recovery key file? (y/n)"
if ($removeKey -eq 'y' -or $removeKey -eq 'Y') {
    if (Test-Path $keyFile) {
        Remove-Item $keyFile -Force
        Write-Host "Recovery key removed" -ForegroundColor Yellow
    }
}

Write-Host "Decryption complete!" -ForegroundColor Green
Write-Host "Restored files to original locations" -ForegroundColor Green
