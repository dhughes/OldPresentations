<cfparam name="url.id" default="0" />
<cfset course = EntityLoad("Course", url.id)[1] />

<script>
	$(document).ready(function(){
		var win = ColdFusion.Window.getWindowObject("scoresWindow");
		<cfoutput>win.setTitle('#course.getName()# Scores');</cfoutput>
	})
</script>


<cfoutput>
	<div style="font-weight:bold; font-size:1.1em">#course.getName()#</div>
	<cfloop array="#course.getRounds()#" index="round">
		<div>#round.getScore()# - #dateFormat(round.getDate(), "mm/dd/yyyy")#</div>
	</cfloop>
	<div>Average Score: #course.getAvgScore()#</div>
</cfoutput>
