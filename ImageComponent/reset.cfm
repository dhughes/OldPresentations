
<!--- delete files --->


<cfdirectory action="list" directory="#expandPath("captcha")#" filter="*.jpg" name="captchaImages" />
<cfloop query="captchaImages">
	<cfif FileExists(ExpandPath("Captcha/#captchaImages.name#"))>
		<cffile action="delete"
			file="#ExpandPath("Captcha/#captchaImages.name#")#" />
	</cfif>
</cfloop>

<cfif FileExists(ExpandPath("Image/example.cfm"))>
	<cffile action="delete"
		file="#ExpandPath("Image/example.cfm")#" />
</cfif>

<cfif FileExists(ExpandPath("Image/AicKey.txt"))>
	<cffile action="delete"
		file="#ExpandPath("Image/AicKey.txt")#" />
</cfif>

<cfif FileExists(ExpandPath("Image/smallBridge.jpg"))>
	<cffile action="delete"
		file="#ExpandPath("Image/smallBridge.jpg")#" />
</cfif>

<cfif FileExists(ExpandPath("Image/collin0.jpg"))>
	<cffile action="delete"
		file="#ExpandPath("Image/collin0.jpg")#" />
</cfif>

<cfif FileExists(ExpandPath("Image/collin100.jpg"))>
	<cffile action="delete"
		file="#ExpandPath("Image/collin100.jpg")#" />
</cfif>

<cfif FileExists(ExpandPath("Image/collin20.jpg"))>
	<cffile action="delete"
		file="#ExpandPath("Image/collin20.jpg")#" />
</cfif>

<cfif FileExists(ExpandPath("Image/collin40.jpg"))>
	<cffile action="delete"
		file="#ExpandPath("Image/collin40.jpg")#" />
</cfif>

<cfif FileExists(ExpandPath("Image/collin60.jpg"))>
	<cffile action="delete"
		file="#ExpandPath("Image/collin60.jpg")#" />
</cfif>

<cfif FileExists(ExpandPath("Image/collin80.jpg"))>
	<cffile action="delete"
		file="#ExpandPath("Image/collin80.jpg")#" />
</cfif>

<cfif FileExists(ExpandPath("Image/newCatAndCup.jpg"))>
	<cffile action="delete"
		file="#ExpandPath("Image/newCatAndCup.jpg")#" />
</cfif>

<cfif FileExists(ExpandPath("Image/newChicago.jpg"))>
	<cffile action="delete"
		file="#ExpandPath("Image/newChicago.jpg")#" />
</cfif>

<cfif FileExists(ExpandPath("Image/testCollin.jpg"))>
	<cffile action="delete"
		file="#ExpandPath("Image/testCollin.jpg")#" />
</cfif>

<cftry>
	<cfif FileExists(ExpandPath("Image/Image.cfc"))>
		<cffile action="delete"
			file="#ExpandPath("Image/Image.cfc")#" />
	</cfif>
	<cfcatch></cfcatch>
</cftry>

<cfif FileExists(ExpandPath("Captcha/form.cfm"))>
	<cffile action="delete"
		file="#ExpandPath("Captcha/form.cfm")#" />
</cfif>

<cfif FileExists(ExpandPath("Captcha/Captcha.cfc"))>
	<cffile action="delete"
		file="#ExpandPath("Captcha/Captcha.cfc")#" />
</cfif>

<cfif FileExists(ExpandPath("Captcha/image.cfm"))>
	<cffile action="delete"
		file="#ExpandPath("Captcha/image.cfm")#" />
</cfif>

<cfif FileExists(ExpandPath("Captcha/validate.cfm"))>
	<cffile action="delete"
		file="#ExpandPath("Captcha/validate.cfm")#" />
</cfif>

<cfif FileExists(ExpandPath("Captcha/captchakey.txt"))>
	<cffile action="delete"
		file="#ExpandPath("Captcha/captchakey.txt")#" />
</cfif>



<h1>Reset Complete</h1>