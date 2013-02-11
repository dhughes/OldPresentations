<div style="width:600px;margin:15 auto">

<cfform name="gridForm">

<cfgrid name="grid" 
		width="600" 
		format="html" 
		pagesize="5"
		bind="cfc:com.RemoteService.getCourses({cfgridpage}, {cfgridpagesize}, {cfgridsortcolumn}, {cfgridsortdirection})">
	<cfgridcolumn header="Name" name="name" />
	<cfgridcolumn header="City" name="city" />
	<cfgridcolumn header="State" name="state" />
	<cfgridcolumn header="Phone" name="phone" />
</cfgrid>

</cfform>

</div>
