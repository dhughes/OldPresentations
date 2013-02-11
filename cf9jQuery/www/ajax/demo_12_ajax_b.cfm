<cfset courses = entityLoad("course", {}, "Name") />
<cfset sleep(5000) />
<cfoutput>
		<ol>
			<cfloop array="#courses#" index="course">
				<li>#course.getName()# - #numberFormat(course.getAvgScore(), '99.99')# (#arrayLen(course.getRounds())# rounds)
					<ul id="courserounds#course.getId()#">
						<cfloop array="#course.getRounds()#" index="round">
							<li>#round.getScore()# - #dateFormat(round.getDate(), "mmm d yyyy")#</li>
						</cfloop>
					</ul>
				</li>
			</cfloop>
		</ol>
</cfoutput>