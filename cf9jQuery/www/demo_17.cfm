<script src="/js/jquery.js"></script>

<script>
	$(document).ready(function(){
		$("#search").keyup(function(){
			ColdFusion.Grid.refresh("grid");
		})
	})
</script>

<div style="width:600px;margin:15 auto">

<cfform name="gridForm">

<div style="padding:5px 0">
	<label for="search">Search :</label>
	<input type="text" id="search" name="search" />
</div>

<cfgrid name="grid" 
		width="600" 
		format="html" 
		pagesize="5"
		bind="cfc:com.RemoteService.getCourses({cfgridpage}, {cfgridpagesize}, {cfgridsortcolumn}, {cfgridsortdirection}, {search})">
	<cfgridcolumn header="Name" name="name" />
	<cfgridcolumn header="City" name="city" />
	<cfgridcolumn header="State" name="state" />
	<cfgridcolumn header="Phone" name="phone" />
</cfgrid>

</cfform>

</div>
