param($labFilesName="", $labFilesUri)

[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

# Install SSMS
iex ((new-object net.webclient).DownloadString('https://chocolatey.org/install.ps1')) 
choco install sql-server-management-studio -y

# Download Lab Files
$labFilesFolder = "C:\MCW"
if ([string]::IsNullOrEmpty($labFilesName) -eq $false)
{
    Write-Host "Make sure folder exists"
    if ((Test-Path $labFilesFolder) -eq $false)
    {
        New-Item -Path $labFilesFolder -ItemType directory
    }

    Invoke-RestMethod -Uri $labFilesUri -Outfile $labFilesName

    Write-Host "Extract .ZIP file..."
    Expand-Archive -Path $labFilesName -DestinationPath $labFilesFolder -Force
}