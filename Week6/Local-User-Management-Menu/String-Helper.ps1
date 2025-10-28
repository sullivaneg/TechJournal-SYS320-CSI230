<# String-Helper
*************************************************************
   This script contains functions that help with String/Match/Search
   operations. 
************************************************************* 
#>


<# ******************************************************
   Functions: Get Matching Lines
   Input:   1) Text with multiple lines  
            2) Keyword
   Output:  1) Array of lines that contain the keyword
********************************************************* #>
function getMatchingLines($contents, $lookline){

$allines = @()
$splitted =  $contents.split([Environment]::NewLine)

for($j=0; $j -lt $splitted.Count; $j++){  
 
   if($splitted[$j].Length -gt 0){  
        if($splitted[$j] -ilike $lookline){ $allines += $splitted[$j] }
   }

}

return $allines
}


<#*************************************************************
Functions: checks if the password is at least 6 characters, if is contains 1 special character, 1 number,
           and 1 letter
Input: 1) Password
Output: 1) True if the string meets requirements
        2) False if it doesn't
*************************************************************#>
function checkPassword($password) {
    $regex = [regex] "^(?=.*[A-Za-z])(?=.*\d)(?=.*[^A-Za-z0-9])(.{7,})$"
    $reqs = $password -match $regex

    if($reqs) {
        return True
        }
    else {
        return False
        }
}