<cfsilent><cfapplication name="ContactManagerMG" sessionmanagement="true"/>

<!---
  If your path to ModelGlue.xml is custom, change it here.  Otherwise,
  it will default to config/ModelGlue.xml
	<cfset ModelGlue_CONFIG_PATH = expandPath(".") & "/config/ModelGlue.xml" />
--->

<!--- If your path to ModelGlue.cfm is different, you'll need to change this line. --->
</cfsilent><cfinclude template="/ModelGlue/ModelGlue.cfm" />