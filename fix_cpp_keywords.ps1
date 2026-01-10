# fix_cpp_keywords.ps1
# Все эти приседания нужны при сборке в MS Visual Studio
# 

param([string]$filePath)

$mutexName = "Global\ProtoCompileFixMutex"
$mutex = New-Object System.Threading.Mutex($false, $mutexName)

try {
    # Ждем максимум 5 минут
    if ($mutex.WaitOne(300000))
    {
        # Ждем, пока файл не станет доступен
        $retryCount = 10
        $retryDelay = 100  # миллисекунд

        for ($i = 0; $i -lt $retryCount; $i++)
        {
            try
            {
                # Пытаемся открыть файл с эксклюзивным доступом
                $stream = [System.IO.File]::Open($filePath, 'Open', 'ReadWrite', 'None')
                $stream.Close()
                $stream.Dispose()
                
                # Файл доступен, читаем и обрабатываем
                $content = Get-Content $filePath -Raw

                # Делаем замену
                $content = $content -replace 'namespace public {', 'namespace public_ {' `
                                    -replace '::public::', '::public_::'

                Set-Content $filePath $content -NoNewline
                break
            }
            catch [System.IO.IOException]
            {
                if ($i -eq $retryCount - 1)
                {
                    Write-Error "File $filePath is locked after $retryCount attempts"
                    exit 1
                }
                Start-Sleep -Milliseconds $retryDelay
            }
        }

    }
    else
    {
        Write-Error "Timeout waiting for mutex"
        exit 1
    }

} finally {
    $mutex.ReleaseMutex()
    $mutex.Dispose()
}

