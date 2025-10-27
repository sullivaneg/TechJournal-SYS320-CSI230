#Deliverable 1: Get the Link Count from my web page
$scraped_page = Invoke-WebRequest -Uri http://10.0.17.39/ToBeScraped.html -TimeoutSec 10

# Get a count of the links in the page
$scraped_page.Links.Count

# Deliverable 2: Get the links as HTML elements
$scraped_page.Links

# Deliverable 3: Get the links and display only the URL and its text. 
$scraped_page.Links | Select-Object outerText, href

#Deliverable 4: Get outer text of every element with the tag h2
$h2s=$scraped_page.ParsedHtml.body.getElementsbyTagName("h2") | Select-Object outerText
$h2s

#Deliverable 5: Print innerText of every div element that has the class as "div-1"
$divs1=$scraped_page.ParsedHtml.body.getElementsByTagName("div") | where { `
$_.getAttributeNode("class").Value -ilike "div-1"} | select innerText 
$divs1