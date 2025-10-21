# Choose a directory where you have some .ps1 files
cd $PSScriptRoot

# List files based on the file name
$files=(Get-ChildItem)
for ($j=0; $j -le $files.Length; $j++){
    if ($files[$j].Name -ilike "*.ps1"){
        Write-Host $files[$j].Name
    }
}