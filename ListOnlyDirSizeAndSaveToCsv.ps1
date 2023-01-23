#Get input from user
$InputDirectory = Read-Host "Please enter a directory path"

#Remove double quotes from input
$InputDirectory = $InputDirectory.Replace('"','')

#Get all folders from the directory
$Folders = Get-ChildItem -Path $InputDirectory -Directory

#Loop through the folders and get the size in GB for each folder
foreach ($Folder in $Folders)
{
    $FolderSize = [Math]::Round(((Get-ChildItem -Path $Folder.FullName -Recurse | Measure-Object -Property Length -Sum).Sum / 1024 / 1024 / 1024), 3)
    Write-Host "Folder: $($Folder.Name)  Size: $FolderSize GB"
}

#Store the directory and size in array
$FolderData = @()
foreach ($Folder in $Folders)
{
    $FolderSize = [Math]::Round(((Get-ChildItem -Path $Folder.FullName -Recurse | Measure-Object -Property Length -Sum).Sum / 1024 / 1024 / 1024), 3)
    $FolderData += New-Object PSObject -Property @{
        Directory = $Folder.Name
        Size = $FolderSize
    }
}

#Display the array
$FolderData

#Ask user for destination directory
$DestinationDirectory = Read-Host "Please enter a destination directory to save as .csv file"

#Export the array to csv file
$FolderData | Export-Csv -Path "$DestinationDirectory\FolderSizeData.csv" -NoTypeInformation