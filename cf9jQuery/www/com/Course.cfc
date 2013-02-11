component persistent="true" table="COURSE" accessor="true" displayname="Golf" hint="I am a course Entity" output="false"
{
	property name="id" type="numeric" fieldtype="id" column="id" generator="increment";
	property name="name" type="string" fieldtype="column" column="name";
	property name="address" type="string" fieldtype="column" column="address";
	property name="address2" type="string" fieldtype="column" column="address2";
	property name="city" type="string" fieldtype="column" column="city";
	property name="state" type="string" fieldtype="column" column="state";
	property name="zip" type="string" fieldtype="column" column="zip";
	property name="phone" type="string" fieldtype="column" column="phone";
	property name="rounds" cfc="Round" fieldtype="one-to-many" fkcolumn="courseId" lazy="true";
	property name="ratings" cfc="Rating" fieldtype="one-to-many" fkcolumn="courseId" lazy="true" ;

	public numeric function getAvgScore(){
		var score = ormExecuteQuery("select avg(score) from Round where course.id = ?", [getId()]);
		return val(score[1]);
	}
	
	public numeric function getAvgRating(){
		var rating = ormExecuteQuery("select avg(rating) from Rating where course.id = ?", [getId()]);
		return val(rating[1]);
	}
	
}