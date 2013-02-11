<cfset courses = entityLoad("course", {}, "Name") />
<cflayout 
	type="tab"
	name="demo"
	>
	<cflayoutarea 
		name="courses"
		title="Course List">
			<cfoutput>
			<ol>
				<cfloop array="#courses#" index="course">
					<li>#course.getName()# - #course.getCity()#, #course.getState()#
					</li>
				</cfloop>
			</ol>
			</cfoutput>
	</cflayoutarea>
	
	<cflayoutarea 
		name="ratings"
		title="Course Ratings"
		source="ajax/demo_13_ajax_a.cfm" />
	
	<cflayoutarea 
		name="scores"
		title="Rounds"
		source="ajax/demo_13_ajax_b.cfm" />
	
</cflayout>