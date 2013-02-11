component persistent="true" table="ROUND" accessor="true"  displayname="Round" hint="I am a round of golf" output="false"
{
	property name="id" type="numeric" fieldtype="id" column="id" generator="increment";
	property name="course" cfc="Course" fieldtype="many-to-one" fkcolumn="courseId";
	property name="score" type="numeric" fieldtype="column" column="score";
	property name="date" type="date" fieldtype="column" column="date";
}