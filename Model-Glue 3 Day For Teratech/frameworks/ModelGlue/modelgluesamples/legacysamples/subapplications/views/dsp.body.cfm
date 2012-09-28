This is an example of how Model-Glue applications can share application / session / etc. scopes with other applications (Model-Glue or otherwise!).
<br /><br />
To do this, give your Model-Glue application a unique name in its index.cfm file by editing ModelGlue_APP_KEY (it defaults to /path/to/your/app/index.cfm).  Then, in your index.cfm, &lt;cfinclude> the application.cfm of the desired "parent" application.
<br /><br />
Below is a dump of current session scope.  If you browse to <a href="childapp">childapp</a>, you'll see that it shares this session scope, and adds in its own values in its Controller.cfc.
<br /><br />

<cfoutput>#viewState.getValue("sessionDump")#</cfoutput>
