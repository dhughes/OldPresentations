<cfset courses = entityLoad("course", {}, "Name" ) />

<script>
	editCourse = function(id){
		ColdFusion.Window.show("editCourse");
		ColdFusion.navigate("ajax/demo_11_ajax.cfm?id="+id,"editCourse");
	}
</script>

<div style="width:400; margin:15px auto">

<cfoutput>
	<ol>
	<cfloop array="#courses#" index="course">
		<li><a href="javascript: editCourse(#course.getID()#);">#course.getName()#</a></li>
	</cfloop>
	</ol>
</cfoutput>


</div>

<cfwindow 
	name="editCourse"
	center = "true"
	modal="true"
	title="Edit Course Info"
	width="250"
	height="400"/>