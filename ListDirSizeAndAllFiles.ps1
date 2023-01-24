#Begin Script

#Define Input - The Directory
$Directory = (Read-Host -Prompt "Please input the directory name").Replace('"','')

#Get Size of Files in the Directory
$Files = Get-ChildItem -Path $Directory -Recurse | Select-Object -Property Name, Length

#Loop Through Files to Calculate Size in GB
$FilesSizeInGB=@()
foreach($File in $Files)
{
$Size = [math]::Round(($File.Length/1GB),3)
$FileSizeInGB = [pscustomobject]@{
Name = $File.Name
SizeGB = $Size
}
$FilesSizeInGB += $FileSizeInGB
}

#Display Output
$FilesSizeInGB | Format-Table -AutoSize

#Ask User for Destination Directory
$DestinationDirectory = (Read-Host -Prompt "Please input the destination directory").Replace('"','')

#Export Output to CSV
$FilesSizeInGB | Export-Csv -Path "$DestinationDirectory\filesize.csv" -NoTypeInformation

#End Script
