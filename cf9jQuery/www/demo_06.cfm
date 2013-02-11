<div style="width:400;margin:15 auto">

<cfset courses = ORMExecuteQuery("from Course where state in (?,?)", ['WV', 'VA']) />

<cfmap name="testMap" 
	centeraddress="278 St. Andrews Dr, Charles Town, WV, 25414"
	doubleclickzoom="true"
	overview="true"
	tip="The Map"
	zoomlevel="12"
	type="hybrid"
	 >
	 <cfloop array="#courses#" index="course">
	 	<cfmapitem address="#course.getAddress()#, #course.getCity()#, #course.getState()#, #course.getZip()#" 
	 			markerwindowContent="#course.getName()#"/>
	 </cfloop>
</cfmap>

</div>