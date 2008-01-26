<cfset circle = CreateObject("Component", "Circle") />
<cfset circle.setRadius(10) />

<cfset rectangle = CreateObject("Component", "Rectangle") />
<cfset rectangle.setWidth(20) />
<cfset rectangle.setHeight(10) />

<!--- add these shapes to the shape collector --->
<cfset collector = CreateObject("Component", "ShapeCollector") />
<cfset collector.addShape(circle) />
<cfset collector.addShape(rectangle) />

<!--- output the areas and paremters --->
<cfoutput>
	<p>
		<b>Circle:</b><br/>
		area: #circle.getArea()#<br/>
		perimeter: #circle.getPerimeter()#
	</p>
	<p>
		<b>Rectangle:</b><br/>
		area: #rectangle.getArea()#<br/>
		perimeter: #rectangle.getPerimeter()#
	</p>
	<!--- the collector knows how to work with any object that impelements shape --->
	<p>
		<b>Collector Total:</b><br/>
		area: #collector.getTotalArea()#<br/>
		perimeter: #collector.getTotalPerimeter()#
	</p>
</cfoutput>