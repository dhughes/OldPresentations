component persistent="true" table="RATING" accessor="true" displayname="Rating" hint="I am a course rating" output="true"
{
	property name="id" type="numeric" fieldtype="id" column="id" generator="increment";
	property name="course" cfc="Course" fieldtype="many-to-one" fkcolumn="courseId";
	property name="rating" type="numeric" fieldtype="column" column="rating";
}