# Make Markdown for each new Module 
$mod_num = Read-Host -Prompt "Module #"
$mod_name = Read-Host -Prompt "Module Name"
$num_labs = [int](Read-Host "How many labs in this module?")

$startline = "## Module ${mod_num}: $mod_name"

$body = (1..$num_labs | ForEach-Object {
    $lab_name = Read-Host -Prompt "Lab Name"
    @"
> [[${lab_name}]]
> 
"@   
})

echo @" 
$startline
$($body -join "`n")
"@