<#  
    Microsoft Powershell script created by Sonickyle27.
    This takes text within quotes and sends it to DeepL to be translated.
    You need an API key from DeepL that you can get from https://www.deepl.com/pro#developer
#>

$apikey="570e1808-22a0-241d-75c2-c99fbf5ddf7a" # Put your API key here! This is an example!
# Look at https://www.deepl.com/docs-api/translating-text/request/ for supported languages
$sourcelang="JA"
$targetlang="EN"

Write-Host "Recieved from input:" $Args[0]
If ($sourcelang -eq 'JA') {
    $preparedsource=$Args[0] -replace '\s',''
    Write-Host "Without spaces:" $preparedsource
} Else {
    $preparedsource=$Args[0]
}
$url=-join ("https://api.deepl.com/v2/translate?auth_key=",$apikey,"&text=",$preparedsource,"&target_lang=",$targetlang,"&source_lang=",$sourcelang)
try {
    $json=(Invoke-RestMethod -Uri $url -Method Post | ConvertTo-Json -Depth 2)
} catch {
    Write-Host "StatusCode:" $_.Exception.Response.StatusCode.value__ 
    Write-Host "StatusDescription:" $_.Exception.Response.StatusDescription
    New-BurntToastNotification -Text (-join "DeepL script -",$sourcelang,"to",$targetlang),("The translation failed! Is there an internet connection?`r`nSource:",$preparedsource)
    exit
}
if($?)
{
    $translated=(($json | ConvertFrom-Json).translations.text)
    Write-Host "Translation:" $preparedsource
    New-BurntToastNotification -Text (-join "DeepL script -",$sourcelang,"to",$targetlang),(-join "Sucessfully translated.`r`nSource:",$preparedsource,"`r`nTranslation:",$translated)
}
