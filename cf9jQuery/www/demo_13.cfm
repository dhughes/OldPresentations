<script src="/js/jquery.js"></script>

<div style="width:400;margin:15 auto">

<cfset courses = ORMExecuteQuery("from Course where state in (?,?)", ['WV', 'VA']) />

<script>
	activateLinks = function(){
		$(".scorelink").live("click", function(){
			ColdFusion.Window.show("scoresWindow");
			ColdFusion.navigate("ajax/demo_13_ajax_scores.cfm?id=" + $(this).attr("ref"), "scoresWindow");
			return false;
		})
		
		$(".ratingslink").live("click", function(){
			ColdFusion.Window.show("ratingsWindow");
			ColdFusion.navigate("ajax/demo_13_ajax_ratings.cfm?id=" + $(this).attr("ref"), "ratingsWindow");
			return false;
		})
	}
	
</script>

<cfmap name="testMap" 
	centeraddress="278 St. Andrews Dr, Charles Town, WV, 25414"
	doubleclickzoom="true"
	overview="true"
	tip="The Map"
	zoomlevel="12"
	type="hybrid"
	onload="activateLinks"
	 >
	 <cfoutput>
     	<cfloop array="#courses#" index="course">
		 <cfsavecontent variable="courseText">
		 	<div class="courseMarker">
				<div style="font-weight:bold;font-size:1.3em">#course.getname()#</div>
				<div>
					#course.getAddress()#<br />
					#course.getCity()#, #course.getState()# #course.getZip()#<br />
					#course.getPhone()#
				</div>
				<div><a href="javascript:;" ref="#course.getid()#" class="scorelink">View Scores</a> <a href="javascript:;" ref="#course.getid()#" class="ratingslink">View Ratings</a></div>
			</div>
		 </cfsavecontent>
		 	<cfmapitem address="#course.getAddress()#, #course.getCity()#, #course.getState()#, #course.getZip()#" 
		 			markerwindowContent="#coursetext#"/>
		 </cfloop>
     </cfoutput>
</cfmap>

</div>

<cfwindow 
	name="scoresWindow"
	center = "true"
	modal="true"
	title="Course Scores"
	width="250"
	height="400"/>
	
	<cfwindow 
	name="ratingsWindow"
	center = "true"
	modal="true"
	title="Course Ratings"
	width="250"
	height="400"/>