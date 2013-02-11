<cfset courses = EntityLoad("Course",5) />
<cfdump var="#courses[1].getAvgScore()#">
<cfdump var="#courses[1].getAvgRating()#">
