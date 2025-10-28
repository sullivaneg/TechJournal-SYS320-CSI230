. (Join-Path $PSScriptRoot scraping.ps1)

$Table = gatherClasses
$FullTable = daysTranslator $Table

#Queries

#List all the classes of instructor Furkan Paligu
# $FullTable | Select-Object "Class Code", Instructor, Location, Days, "Time Start", "Time End" | `
             #where{$_."Instructor" -ilike "*Furkan*" }

# List all the classes of JOYCE 310 on Mondays, only display Class Code and Time. 
# Sort by Start Time
#$FullTable | Where-Object { ($_.Location -ilike "JOYC 310") -and ($_.days -match "Monday") } | `
            #Sort-Object "Time Start" | `
            #Select-Object "Time Start", "Time End", "Class Code"

# Make a list of all the instructors that teach at least 1 course in 
# one of the courses: SYS, NET, SEC, FOR, CSI, DAT.
# Sort by name and make it unique
$ITSInstructors = $FullTable | Where-Object {($_."Class Code" -ilike "SYS*") -or`
                                             ($_."Class Code" -ilike "NET*") -or`
                                             ($_."Class Code" -ilike "SEC*") -or`
                                             ($_."Class Code" -ilike "FOR*") -or`
                                             ($_."Class Code" -ilike "CSI*") -or`
                                             ($_."Class Code" -ilike "DAT*") } `
                            # | Select-Object "Instructor" `
                            # | Sort-Object "Instructor" -Unique
#$ITSInstructors

# Group all the instructors by the number of classes they are teaching
# Sort by the number of classes they are teaching
$FullTable | where {$_.Instructor -in $ITSInstructors.Instructor  } `
           | Group-Object "Instructor" | Select-Object Count, Name | Sort-Object Count -Descending
