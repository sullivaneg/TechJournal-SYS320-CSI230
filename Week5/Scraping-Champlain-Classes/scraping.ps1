﻿<#******************************************************************************
function: scrapes table from a web page and saves the content to a custom object
Input: None
Output: custom object
*******************************************************************************#>
function gatherClasses(){
$page = Invoke-WebRequest -TimeoutSec 2 http://10.0.17.39/Courses2025FA.html 

# Get all the tr elements of HTML document
$trs=$page.ParsedHtml.body.getElementsbyTagName("tr")

#Empty array to hold results
$FullTable = @()
for($i=1; $i -lt $trs.length; $i++){ #Going over every tr element
    
    # Get every td element of current tr element
    $tds = $trs[$i].getElementsByTagName("td")

    # Want to seperate start time and end time from one time field
    $Times = $tds[5].innerText.Split("-")

    $FullTable +=[pscustomobject]@{"Class Code" = $tds[0].innerText;`
                                   "Title" = $tds[1].innerText;`
                                   "Days" = $tds[4].innerText;`
                                   "Time Start" = $Times[0];`
                                   "Time End" = $Times[1];`
                                   "Instructor" = $tds[6].innerText;`
                                   "Location" = $tds[9].innerText;`
                                }
} # End of for loop
return $FullTable
}

<#*******************************************************************************
function: Translates MTWTFSS into day names
input: $FullTable
output: $FullTable with days translated
*******************************************************************************#>
function daysTranslator($FullTable){

# Go over every record in the table
for($i=0; $i -lt $FullTable.length; $i++){
    
    # Empty array to hold days for every record
    $Days = @()

    # If you see "M" -> Monday
    if($FullTable[$i].Days -ilike "M*"){  $Days += "Monday" }

    # If you see "T" followed by T,W, or Friday -> Tuesday
    if($FullTable[$i].Days -ilike "*T[WTF]*") {  $Days += "Tuesday"  }
    # If you only see "T" -> Tuesday
    ElseIf($FullTable[$i].Days -ilike "T"){  $Days += "Tuesday"  }

    # If you see "W" -> Wednesday
    if($FullTable[$i].Days -ilike "*W*"){  $Days += "Wednesday"  }

    # If you see "TH" -> Thursday
    if($FullTable[$i].Days -ilike "*TH*"){  $Days += "Thursday"  }

    # F -> Friday
    if($FullTable[$i].Days -ilike "*F*"){  $Days += "Friday"  }

    # Make the Switch
    $FullTable[$i].Days = $Days
}

return $FullTable
}