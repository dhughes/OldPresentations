Model-Glue ActionPack:  E-mail Service

Description
-------------------------------------------------------------------------------
This ActionPack provides a configurable e-mail service.  It's superior to using
the <cfmail> tag in that it's easy to configure it for "development" or 
"production" modes.  When in "development" mode, all e-mails are routed to 
whatever e-mail addreses are defined as "developer" addresses - so you'll
never accidently e-mail your customers from your development server again!


Requirements
-------------------------------------------------------------------------------
No other ActionPacks are required for this to run.   


Installation
-------------------------------------------------------------------------------
To use this ActionPack in a Model-Glue:Unity application, you need to do two
things:

1.  Copy the contents of config/Beans.xml into your application's ColdSpring.xml
file, then edit the various values to match your e-mail configuration.  They're
both self explanatory and commented.

2.  Add the following at the top of your application's ModelGlue.xml file, just
after the <modelglue> tag:

<include template="/ModelGlue/actionpacks/email/config/ModelGlue.xml" />

That's it!



Use
-------------------------------------------------------------------------------
This ActionPack adds a value to the viewstate on each request named "EmailService."

To use it inside of a controller to send an e-mail:

<cfset var svc = arguments.event.getValue("emailService") />
<cfset var email = svc.createEmail() />

<!--- 
	See model/Email.cfc for all values that can be set and how to add 
	attachments
--->
<cfset email.setTo("somebody@localhost") />
<cfset email.setSubject("Test") />
<cfset email.send() />

To use the service inside of another ColdSpring-based service, wire the service
to the new "EmailService" bean in ColdSpring.xml.


