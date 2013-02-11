<cfset courses = entityLoad("course", {}, "Name") />
<cfset sleep(5000) />
<cfoutput>
		<ol>
			<cfloop array="#courses#" index="course">
				<li>#course.getName()# - #numberFormat(course.getAvgRating(), '99.99')# (#arraylen(course.getRatings())# ratings)
					<ul id="courseRating#course.getId()#">
						<cfloop array="#course.getRatings()#" index="rating">
							<li>#rating.getRating()#</li>
						</cfloop>
					</ul>
				</li>
			</cfloop>
		</ol>
</cfoutput>