<cfcomponent>
	
	<cfset variables.bodyTemplateText = "" />
	<cfset variables.bodyTemplateHtml = "" />
	<cfset variables.query = 0 />
	<cfset variables.subject = "" />
	<cfset variables.from = "" />
	<cfset variables.to = "" />
	<cfset variables.cc = "" />
	<cfset variables.bcc = "" />
	<cfset variables.query = 0 />
	<cfset variables.data = StructNew() />
	
	<cffunction name="init" access="public" hint="I configure an email message.  Any parameters passed in via the constructor or getters/setters are overridden by the query, if provided and if there are duplicates." output="false" returntype="message">
		<cfargument name="bodyTemplateText" hint="I am the path to the body text txt file." required="no" type="string" default="" />
		<cfargument name="bodyTemplateHtml" hint="I am the path to the body html txt file." required="no" type="string" default="" />
		<cfargument name="subject" hint="I am the message's subject" required="no" type="string" default="" />
		<cfargument name="from" hint="I am the from email address for the message" required="no" type="string" default="" />
		<cfargument name="to" hint="I am the to email address for the message" required="no" type="string" default="" />
		<cfargument name="cc" hint="I am the to cc email addresses for the message" required="no" type="string" default="" />
		<cfargument name="bcc" hint="I am the to bcc email addresses for the message" required="no" type="string" default="" />
		<cfargument name="query" hint="I am a query to use to populate the message" required="no" type="any" default="" />
		<cfargument name="data" hint="I am a structure of data to populate the message" required="no" type="struct" default="#StructNew()#" />
		
		<cfset setBodyTemplateText(arguments.bodyTemplateText) />
		<cfset setBodyTemplateHtml(arguments.bodyTemplateHtml) />
		<cfset setSubject(arguments.subject) />
		<cfset setFrom(arguments.from) />
		<cfset setTo(arguments.to) />
		<cfset setCc(arguments.cc) />
		<cfset setBcc(arguments.bcc) />
		<cfset setQuery(arguments.query) />
		<cfset setData(arguments.data) />
		
		<cfreturn this />		
	</cffunction>
	
	<!--- send --->
	<cffunction name="send" access="public" hint="I send this message" output="false" returntype="void">
		<cfset var data = 0 /> 
		<cfset var query = getQuery() />
		<cfset var column = 0 />
		
		<!--- copy data into the data
		<cfset var test = QueryNew("from,to,subject") />
		<cfset QueryAddRow(test) />
		<cfset QuerySetCell(test, "from", "dhughes@alagad.com") />
		<cfset QuerySetCell(test, "to", "doug@doughughes.net") />
		<cfset QuerySetCell(test, "subject", "I'm a test") /> --->
		
		
		<!--- check to see if we need to loop over a query of data --->
		<cfif IsQuery(query)>
			<!--- loop over a query of data --->
			<cfloop query="query">
				<cfset data = duplicate(getData()) />
				<cfset data.subject = variables.subject />
				<cfset data.from = variables.from />
				<cfset data.to = variables.to />
				<cfset data.cc = variables.cc />
				<cfset data.bcc = variables.bcc />
				
				<!--- add the query data to the data structure --->
				<cfloop list="#query.columnList#" index="column">
					<cfset data[column] = query[column] />
				</cfloop>
			
				<cfset sendMessage(data) />
			</cfloop>
		<cfelse>
			<!--- send only one message --->
			<cfset data = duplicate(getData()) />
			<cfset data.subject = variables.subject />
			<cfset data.from = variables.from />
			<cfset data.to = variables.to />
			<cfset data.cc = variables.cc />
			<cfset data.bcc = variables.bcc />
			<cfset sendMessage(data) />
		</cfif>
		
	</cffunction>
	
	<!--- sendMessage --->
	<cffunction name="sendMessage" access="private" hint="I send a message" output="false" returntype="void">
		<cfargument name="data" hint="I am the data to use to send the message" required="yes" type="struct" />
		<cfset var content = "" />
		<cfset var type = "html" />
		
		<cfif Len(getBodyTemplateText()) AND NOT Len(getBodyTemplateHtml())>
			<cfset type = "plain" />
		</cfif>
		
		<cfmail from="#parse(arguments.data.from, arguments.data)#"
			to="#parse(arguments.data.to, arguments.data)#"
			cc="#parse(arguments.data.cc, arguments.data)#"
			bcc="#parse(arguments.data.bcc, arguments.data)#"
			subject="#parse(arguments.data.subject, arguments.data)#"
			type="#type#">
			
			<!--- check to see if we have an html body --->
			<cfif Len(getBodyTemplateHtml())>
				<cffile action="read" file="#expandPath(getBodyTemplateHtml())#" variable="content" />
				<cfif Len(getBodyTemplateText())>
					<cfmailpart type="text/html"><cfoutput>#parse(content, arguments.data)#</cfoutput></cfmailpart>
				<cfelse>
					<cfoutput>#parse(content, arguments.data)#</cfoutput>
				</cfif>
			</cfif>
			<!--- check to see if we have a text body --->
			<cfif Len(getBodyTemplateText())>
				<cffile action="read" file="#expandPath(getBodyTemplateText())#" variable="content" />
				<cfif Len(getBodyTemplateHtml())>
					<cfmailpart type="text/plain"><cfoutput>#parse(content, arguments.data)#</cfoutput></cfmailpart>
				<cfelse>
					<cfoutput>#parse(content, arguments.data)#</cfoutput>
				</cfif>
			</cfif>
		</cfmail>
		
	</cffunction>
	
	<cffunction name="parse" access="private" hint="I parse a string based on a set of variable data" output="false" returntype="string">
		<cfargument name="content" hint="I am a item to parse in the data struture" required="yes" type="string" />
		<cfargument name="data" hint="I am a structure of data" required="yes" type="struct" />
		
		<cfset var result = ReReplace(arguments.content, "(\{{1})(.+?)(\}{1})", "##data.\2##", "all") />
		<cfset result = Replace(result, """", """""", "all") />
		
		<cftry>
			<cfreturn evaluate("""#result#""") />		
			<cfcatch>
				<cfthrow message="Could Not Resolve Variable" detail="Your message or subject attempted to use an undefined variable named '#cfcatch.element#'." type="Email.model.email.Message.parse.Could NotResolveVariable" />
			</cfcatch>
		</cftry>
	</cffunction>
	
	<!--- setValue --->
	<cffunction name="setValue" access="public" hint="I add a value to the message data." output="false" returntype="void">
		<cfargument name="name" hint="I am the data's name" required="yes" type="string" />
		<cfargument name="value" hint="I am the data's value" required="yes" type="string" />
		<cfargument name="overwrite" hint="I indicate if the data should be overwritten if it already exists" required="no" type="boolean" default="true" />
		
		<cfif arguments.overwrite OR NOT StructKeyExists(getData(), arguments.name)>
			<cfset StructInsert(getData(), arguments.name, arguments.value, true) />
		</cfif>
	</cffunction>
	
	<!--- bodyTemplateText --->
    <cffunction name="setBodyTemplateText" access="public" output="false" returntype="void">
       <cfargument name="bodyTemplateText" hint="I am the path to the body text txt file" required="yes" type="string" />
       <cfset variables.bodyTemplateText = arguments.bodyTemplateText />
    </cffunction>
    <cffunction name="getBodyTemplateText" access="public" output="false" returntype="string">
       <cfreturn variables.bodyTemplateText />
    </cffunction>
	
	<!--- bodyTemplateHtml --->
    <cffunction name="setBodyTemplateHtml" access="public" output="false" returntype="void">
       <cfargument name="bodyTemplateHtml" hint="I am the path to the body html txt file" required="yes" type="string" />
       <cfset variables.bodyTemplateHtml = arguments.bodyTemplateHtml />
    </cffunction>
    <cffunction name="getBodyTemplateHtml" access="public" output="false" returntype="string">
       <cfreturn variables.bodyTemplateHtml />
    </cffunction>
	
	<!--- subject --->
    <cffunction name="setSubject" access="public" output="false" returntype="void">
       <cfargument name="subject" hint="I am the message's subject" required="yes" type="string" />
       <cfset variables.subject = arguments.subject />
    </cffunction>
    <cffunction name="getSubject" access="public" output="false" returntype="string">
       <cfreturn variables.subject />
    </cffunction>
	
	<!--- from --->
    <cffunction name="setFrom" access="public" output="false" returntype="void">
       <cfargument name="from" hint="I am the from email address for the message" required="yes" type="string" />
       <cfset variables.from = arguments.from />
    </cffunction>
    <cffunction name="getFrom" access="public" output="false" returntype="string">
       <cfreturn variables.from />
    </cffunction>
	
	<!--- to --->
    <cffunction name="setTo" access="public" output="false" returntype="void">
       <cfargument name="to" hint="I am the to email address for the message" required="yes" type="string" />
       <cfset variables.to = arguments.to />
    </cffunction>
    <cffunction name="getTo" access="public" output="false" returntype="string">
       <cfreturn variables.to />
    </cffunction>
	
	<!--- cc --->
    <cffunction name="setCc" access="public" output="false" returntype="void">
       <cfargument name="cc" hint="I am the cc email addresses for the message" required="yes" type="string" />
       <cfset variables.cc = arguments.cc />
    </cffunction>
    <cffunction name="getCc" access="public" output="false" returntype="string">
       <cfreturn variables.cc />
    </cffunction>
	
	<!--- bcc --->
    <cffunction name="setBcc" access="public" output="false" returntype="void">
       <cfargument name="bcc" hint="I am the bcc email addresses for the message" required="yes" type="string" />
       <cfset variables.bcc = arguments.bcc />
    </cffunction>
    <cffunction name="getBcc" access="public" output="false" returntype="string">
       <cfreturn variables.bcc />
    </cffunction>
	
	<!--- query --->
    <cffunction name="setQuery" access="public" output="false" returntype="void">
       <cfargument name="query" hint="I am a query to use to populate the message" required="yes" type="any" />
       <cfset variables.query = arguments.query />
    </cffunction>
    <cffunction name="getQuery" access="public" output="false" returntype="any">
       <cfreturn variables.query />
    </cffunction>
	
	<!--- data --->
    <cffunction name="setData" access="public" output="false" returntype="void">
       <cfargument name="data" hint="I am a structure of data to populate the message" required="yes" type="struct" />
       <cfset variables.data = arguments.data />
    </cffunction>
    <cffunction name="getData" access="public" output="false" returntype="struct">
       <cfreturn variables.data />
    </cffunction>
	
</cfcomponent>