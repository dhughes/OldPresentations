
<!--- note that the collector will use any sorter --->
<cfset collector = CreateObject("Component", "ShapeCollector").init(CreateObject("Component", "areaSorter")) />

<cfset circle = CreateObject("Component", "Circle") />
<cfset circle.setRadius(randrange(1,100)) />
<cfset circle.setColor("Orange") />
<cfset collector.addShape(circle) />


<cfset rectangle = CreateObject("Component", "Rectangle") />
<cfset rectangle.setWidth(randrange(1,100)) />
<cfset rectangle.setHeight(randrange(1,100)) />
<cfset rectangle.setColor("Red") />
<cfset collector.addShape(rectangle) />


<cfset circle = CreateObject("Component", "Circle") />
<cfset circle.setRadius(randrange(1,100)) />
<cfset circle.setColor("Indigo") />
<cfset collector.addShape(circle) />


<cfset rectangle = CreateObject("Component", "Rectangle") />
<cfset rectangle.setWidth(randrange(1,100)) />
<cfset rectangle.setHeight(randrange(1,100)) />
<cfset rectangle.setColor("Green") />
<cfset collector.addShape(rectangle) />


<cfset circle = CreateObject("Component", "Circle") />
<cfset circle.setRadius(randrange(1,100)) />
<cfset circle.setColor("Orange") />
<cfset collector.addShape(circle) />


<cfset rectangle = CreateObject("Component", "Rectangle") />
<cfset rectangle.setWidth(randrange(1,100)) />
<cfset rectangle.setHeight(randrange(1,100)) />
<cfset rectangle.setColor("Yellow") />
<cfset collector.addShape(rectangle) />


<!--- get the sorted shapes --->
<cfset sorted = collector.getSorted() />

<cfloop from="1" to="#ArrayLen(sorted)#" index="x">
	<p>
	<cfdump var="#sorted[x]#" />
	<cfoutput>area: #sorted[x].getArea()#<br /></cfoutput>
	<cfoutput>color:#sorted[x].getColor()#</cfoutput>
	</p>
</cfloop>


<cfset collector.addShape(rectangle) />

