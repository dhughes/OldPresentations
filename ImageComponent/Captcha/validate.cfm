<cfset myCaptcha = CreateObject("Component", "Captcha").configure(expandPath(".")) />

<cfif myCaptcha.validate(session.captcha.hash, form.captcha)>
	Woo hoo!  you got it right, you're not a computer!
<cfelse>
	Oh no!  You might be a computer!
</cfif>
