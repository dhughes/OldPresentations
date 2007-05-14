<!---
Author: Ben Edwards (ben@ben-edwards.com)
--->
<cfcomponent displayname="Exception"
	hint="Encapsulates exception information.">

	<cfset variables.type = "" />
	<cfset variables.message = "" />
	<cfset variables.errorCode = "" />
	<cfset variables.detail = "" />
	<cfset variables.extendedInfo = "" />
	<cfset variables.tagContext = ArrayNew(1) />

	<cffunction name="init" access="public" returntype="void" output="false">
		<cfargument name="type" type="string" required="false" default="" />
		<cfargument name="message" type="string" required="false" default="" />
		<cfargument name="errorCode" type="string" required="false" default="" />
		<cfargument name="detail" type="string" required="false" default="" />
		<cfargument name="extendedInfo" type="string" required="false" default="" />
		<cfargument name="tagContext" type="array" required="false" default="#ArrayNew(1)#" />
	
		<cfset setType(arguments.type) />
		<cfset setMessage(arguments.message) />
		<cfset setErrorCode(arguments.errorCode) />
		<cfset setDetail(arguments.detail) />
		<cfset setExtendedInfo(arguments.extendedInfo) />
		<cfset setTagContext(arguments.tagContext) />
	</cffunction>
	
	
	<cffunction name="setType" access="public" returntype="void" output="false">
		<cfargument name="type" type="string" required="false" />
		<cfset variables.type = arguments.type />
	</cffunction>
	<cffunction name="getType" access="public" returntype="string" output="false">
		<cfreturn variables.type />
	</cffunction>
	
	<cffunction name="setMessage" access="public" returntype="void" output="false">
		<cfargument name="message" type="string" required="false" />
		<cfset variables.message = arguments.message />
	</cffunction>
	<cffunction name="getMessage" access="public" returntype="string" output="false">
		<cfreturn variables.message />
	</cffunction>
	
	<cffunction name="setErrorCode" access="public" returntype="void" output="false">
		<cfargument name="errorCode" type="string" required="false" />
		<cfset variables.errorCode = arguments.errorCode />
	</cffunction>
	<cffunction name="getErrorCode" access="public" returntype="string" output="false">
		<cfreturn variables.errorCode />
	</cffunction>
	
	<cffunction name="setDetail" access="public" returntype="void" output="false">
		<cfargument name="detail" type="string" required="false" />
		<cfset variables.detail = arguments.detail />
	</cffunction>
	<cffunction name="getDetail" access="public" returntype="string" output="false">
		<cfreturn variables.detail />
	</cffunction>
	
	<cffunction name="setExtendedInfo" access="public" returntype="void" output="false">
		<cfargument name="extendedInfo" type="string" required="false" />
		<cfset variables.extendedInfo = arguments.extendedInfo />
	</cffunction>
	<cffunction name="getExtendedInfo" access="public" returntype="string" output="false">
		<cfreturn variables.extendedInfo />
	</cffunction>
	
	<cffunction name="setTagContext" access="public" returntype="void" output="false">
		<cfargument name="tagContext" type="array" required="false" />
		<cfset variables.tagContext = arguments.tagContext />
	</cffunction>
	<cffunction name="getTagContext" access="public" returntype="array" output="false">
		<cfreturn variables.tagContext />
	</cffunction>

</cfcomponent>