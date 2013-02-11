<cfparam name="url.id" default="0" />
<cfset course = EntityLoad("Course", url.id)[1] />

<script>
	$(document).ready(function(){
		var win = ColdFusion.Window.getWindowObject("ratingsWindow");
		<cfoutput>win.setTitle('#course.getName()# Ratings');</cfoutput>
	})
</script>


<cfoutput>
	<div style="font-weight:bold; font-size:1.1em">#course.getName()#</div>
	<cfloop array="#course.getRatings()#" index="rating">
		<div>#rating.getRating()#</div>
	</cfloop>
	<div>Average Rating: #course.getAvgRating()#</div>
</cfoutput>
