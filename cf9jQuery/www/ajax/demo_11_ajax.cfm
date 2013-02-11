<cfparam name="url.id" default="0" />
<cfset course = entityLoad("Course", val(url.id))[1] />

<cfoutput>
	<form>
		<fieldset>
			<div>
				<label for="name">Course Name</label><br />
				<input type="text" name="name" id="address" value="#course.getName()#" style="width:200px" />
			</div>
			<div>
				<label for="address">Address</label><br />
				<input type="text" name="address" id="address" value="#course.getAddress()#" style="width:200px" />
			</div>
			<div>
				<label for="address2">Address con't'</label><br />
				<input type="text" name="address2" id="address2" value="#course.getAddress2()#" style="width:200px" />
			</div>
			<div>
				<label for="city">City</label><br />
				<input type="text" name="city" id="city" value="#course.getCity()#" style="width:200px" />
			</div>
			<div>
				<label for="state">State</label><br />
				<input type="text" name="state" id="state" value="#course.getState()#" style="width:200px" />
			</div>
			<div>
				<label for="zip">Zip</label><br />
				<input type="zip" name="zip" id="zip" value="#course.getZip()#" style="width:200px" />
			</div>
			<div>
				<label for="phone">Phone</label><br />
				<input type="phone" name="phone" id="phone" value="#course.getPhone()#" style="width:200px" />
			</div>
			<button type="button" onclick="ColdFusion.Window.hide('editCourse')">Save Course</button>
		</fieldset>
	</form>
</cfoutput>
