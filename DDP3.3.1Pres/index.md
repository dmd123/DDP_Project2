---
## Slide #1 - title page

title       : Developing Data Products
subtitle    : Course Project
author      : Mike Danielson
job         : Data Science Specialization
logo        : R-Programming.png
framework   : io2012        # {io2012, html5slides, shower, dzslides, ...}
highlighter : highlight.js  # {highlight.js, prettify, highlight}
hitheme     : tomorrow      # 
widgets    : [bootstrap, quiz, shiny, interactive]
ext_widgets: {rCharts: [libraries/nvd3]}
mode        : selfcontained
knit        : slidify::knit2slides

---
## Electricity Prices in the PJM Market
This Slidify presentation provides an explanation of the Shiny appliction that was developed for Coursera's Developing Data Projects course within the Data Science Specialization. The assignment consisted of the following components:

<ol type="1">
  <li>Shiny Application - developed for a purposed chosen by the student and deployed on Rstudio's shiny server</li>
  <li>Slidify Presentation - 5 slides to pitch the application</li>
</ol>
<br>
<br>
<br>
<br>
<br>
<br>
<a href="https://github.com/dmd123/DDP_Project/blob/master/README.md">Readme</a>

---
## Shiny Application for PJM Electricity Prices
The Shiny application is deployed on shinyapps.io.

The application includes an explanation for the user and can be accessed with the link below.

<a href="https://dmdanielson.shinyapps.io/DDP_Project3_3/">Shiny Application</a>

---
## Code & Data Source for Shiny Application
The code for the application is available on git hub at the links below. The majority of the code resides in server.R, where the data is retrieved and a calculation is performed to compute the difference in prices for the previous 1 hour interval and 5 minute interval.

<a href="https://github.com/dmd123/DDP_Project/blob/master/ui.R">ui.R</a><br>
<a href="https://github.com/dmd123/DDP_Project/blob/master/server.R">server.R</a><br>
<a href="https://github.com/dmd123/DDP_Project/blob/master/documentation.html">documentation.html</a><br>

The raw data is available at the below.

<a href="http://www.pjm.com/pub/account/lmpgen/lmppost.html">Raw Data</a>

--- .smallfont
## Sample of Embedded Code with Output

```r
library(shiny)
library(rvest)
library(XML)
library(xtable)
url <- "http://www.pjm.com/pub/account/lmpgen/lmppost.html"
LMP <- readHTMLTable(url, header = FALSE)[2]
LMP <- as.data.frame(LMP)
LMP[] <- lapply(LMP,as.character)
names(LMP)<-c(LMP[1,])
LMP <- LMP[-c(1),]
row.names(LMP) <- 1:nrow(LMP)
updatetime <- url %>% read_html() %>% html_nodes(xpath='/html/body/center[2]') %>% html_text()
LMP <- LMP[c(1,2,4,3)]
colnames(LMP)[3] <- paste("Hour ",substr(updatetime,18,19),sep="")
colnames(LMP)[4] <- paste("5min Interval ",substr(updatetime,18,19),":",substr(updatetime,21,22),sep="")
LMP[,3]<-as.numeric(LMP[,3])
LMP[,4]<-as.numeric(LMP[,4])
LMP$DIFF <- LMP[,4]-LMP[,3]
colnames(LMP)[5] <- paste("Difference")
print(xtable(LMP[1:5,1:4]),type = "html")
```

<!-- html table generated in R 3.2.5 by xtable 1.8-2 package -->
<!-- Sat Jun 18 16:28:11 2016 -->
<table border=1>
<tr> <th>  </th> <th> Name </th> <th> Type </th> <th> Hour 16 </th> <th> 5min Interval 16:20 </th>  </tr>
  <tr> <td align="right"> 1 </td> <td> AECO </td> <td> ZONE </td> <td align="right"> 35.00 </td> <td align="right"> 27.40 </td> </tr>
  <tr> <td align="right"> 2 </td> <td> AEP </td> <td> ZONE </td> <td align="right"> 36.40 </td> <td align="right"> 31.90 </td> </tr>
  <tr> <td align="right"> 3 </td> <td> APS </td> <td> ZONE </td> <td align="right"> 36.00 </td> <td align="right"> 31.50 </td> </tr>
  <tr> <td align="right"> 4 </td> <td> ATSI </td> <td> ZONE </td> <td align="right"> 36.90 </td> <td align="right"> 31.90 </td> </tr>
  <tr> <td align="right"> 5 </td> <td> BGE </td> <td> ZONE </td> <td align="right"> 39.00 </td> <td align="right"> 38.20 </td> </tr>
   </table>
