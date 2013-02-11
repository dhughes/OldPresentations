component  displayname="Remote Service" hint="I get all the data for remote calls" output="false"
{
	remote struct function getCourses(numeric cfgridpage=1, numeric cfgridpagesize=5, string cfgridsortcolumn="name", string cfgridsortdirection="asc", string search="")
	 displayname="Get Courses" output="true"
	{
		var ret = {};
		if(len(trim(arguments.cfgridsortcolumn)) EQ 0){arguments.cfgridsortcolumn = "name";}
		if(len(trim(arguments.cfgridsortdirection)) EQ 0){arguments.cfgridsortdirection = "asc";}
		var courses = ORMExecuteQuery("from Course where upper(name) like ? order by #cfgridsortcolumn# #arguments.cfgridsortdirection#", ["%"&ucase(arguments.search)&"%"]);
		var coursesq = EntityToQuery(courses);
		ret = queryConvertForGrid(coursesq, arguments.cfgridpage, arguments.cfgridpagesize);
		return ret;
	}

}