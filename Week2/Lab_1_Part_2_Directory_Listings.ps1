# Choose a directory where you have some .ps1 files
cd $PSScriptRoot

# List files based on the file name
$files=(Get-ChildItem)
for ($j=0; $j -le $files.Length; $j++){
    if ($files[$j].Name -ilike "*.ps1"){
        Write-Host $files[$j].Name
    }
}

#Create a folder called "outfolder" if it does not already exist
$folderpath="$PSScriptRoot\outfolder"
if (Test-Path $folderpath){
    Write-Host "Folder Already Exists"
    }
else{
    New-Item -Path $folderpath -ItemType Directory
    }

# List all files in your working directory )forany other directory that has .ps1 files that has the extension .ps1
# and save the results to out.csv in the "outfolder directory.

cd $PSScriptRoot
$files = Get-ChildItem

$folderPath = "$PSScriptRoot/outfolder/"
$filePath = Join-Path $folderPath "out.csv"

$files | Where-Object {$_.Name -ilike "*.ps1"} |
Export-Csv -Path $filePath

ls $folderpath
Write-Host "-------"
cat $folderPath/out.csv
