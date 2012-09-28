
<cfset myCaptcha = CreateObject("Component", "Captcha").configure(expandPath(".")) />

<cfset myCaptcha.setContrast(100) />
<cfset myCaptcha.setInvert(true) />
<cfset myCaptcha.setSpotsEnabled(false) />
<cfset myCaptcha.setAllowedFontList("Times New Roman") />

<cfset session.captcha = myCaptcha.createCaptcha() />

<cfparam name="form.captcha" default="" />

<cfform action="validate.cfm" format="xml" >
	<cfinput type="text" name="captcha" value="#form.captcha#" label="What do you see!?"/>

	<cfinput type="image" name="img" src="image.cfm" />
	<cfinput type="submit" name="Submit" value="Submit" />
</cfform>
