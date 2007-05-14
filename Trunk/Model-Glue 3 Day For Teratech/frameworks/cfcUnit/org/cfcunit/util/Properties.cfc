<!---
   Copyright (c) 2006, Paul Kenney
   All rights reserved.

   Licensed under the Apache License, Version 2.0 (the "License");
   you may not use this file except in compliance with the License.
   You may obtain a copy of the License at

       http://www.apache.org/licenses/LICENSE-2.0

   Unless required by applicable law or agreed to in writing, software
   distributed under the License is distributed on an "AS IS" BASIS,
   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
   See the License for the specific language governing permissions and
   limitations under the License.
--->

<cfcomponent name="Properties" output="false"
	hint="
			This is a general-purpose class that can read standard Java properties. It 
			follows the same format specification, so it can be used in place of the
			Java class. However, this class can be extended by other CFCs.
		">

	<!-------------------------------------------------------------------------------------->
	
	
	<cfproperty name="defaults" type="Properties"/>
	<cfproperty name="keys" type="struct"/>
	
	
	<!-------------------------------------------------------------------------------------->


	<cffunction name="init" returntype="Properties" access="public" output="false">
		<cfargument name="defaults" type="Properties" required="false"/>
		
		<cfset variables.keys = structNew()>
		
		<cfif structKeyExists(arguments, "defaults")>
			<cfset variables.defaults = arguments.defaults>
		</cfif>
		
		<cfreturn this/>
	</cffunction>
	
	
	<!-------------------------------------------------------------------------------------->
	
	
	<cffunction name="load" retunrtype="Properties" access="public" output="false">
		<cfargument name="filename" type="string" required="true"/>
		
		<cfset var lines = "">
		<cfset var line = "">
		<cfset var crlf = chr(13) & chr(10)>
		<cfset var context = structNew()>
		<cfset var name = "">
		<cfset var value = "">
		
		<cffile action="read" file="#arguments.filename#" variable="lines"/>
		
		<cfloop list="#lines#" index="line" delimiters="#crlf#">
			<cfset line = lTrim(line)>
		
			<cfif len(line) AND NOT listFind("##,!", left(line, 1), ",")>
				<cfif NOT (StructKeyExists(context, "multiline") AND context.multiline IS TRUE) OR (structKeyExists(context, "lastline") AND context.lastline IS TRUE)>
					<cfset context = structNew()>
				</cfif>
		
				<cfset name = getPropertyNameFromLine(line, context)>
				<cfset value = getPropertyValueFromLine(line, context)>
				
				<cfif context.lastline>
					<cfset setProperty(name, value)>
				</cfif>
			</cfif>
		</cfloop>
		
		<cfreturn this/>
	</cffunction>
	
	
	<!-------------------------------------------------------------------------------------->
	
	
	<cffunction name="getProperty" returntype="string" access="public" output="false" 
		hint="
				Searches for the property with the specified key in this property list. 
				If the key is not found in this property list, the default property list, 
				and its defaults, recursively, are then checked. The method returns the 
				default value argument if the property is not found.
			">
		
		<cfargument name="key" type="string" required="true"/>
		<cfargument name="defaultValue" type="string" required="false" default=""/>
		
		<cfif structKeyExists(variables.keys, arguments.key)>
			<cfreturn variables.keys[arguments.key]/>
		<cfelseif structKeyExists(variables, "defaults")>
			<cfreturn variables.defaults.getProperty(arguments.key, arguments.defaultValue)/>
		</cfif>
		
		<cfreturn arguments.defaultValue/>
	</cffunction>
	
	
	<!-------------------------------------------------------------------------------------->
	
	
	<cffunction name="setProperty" returntype="string" access="public" output="false">
		<cfargument name="key" type="string" required="true"/>
		<cfargument name="value" type="string" required="true"/>
		
		<cfset var oldValue = "">
		
		<cfif structKeyExists(variables.keys, arguments.key)>
			<cfset oldValue = variables.keys[arguments.key]>
		</cfif>
		
		<cfset variables.keys[arguments.key] = arguments.value>
		
		<cfreturn oldValue/>
	</cffunction>
	
	
	<!-------------------------------------------------------------------------------------->
	
	
	<cffunction name="propertyNames" returntype="array" access="public" output="false">
		<cfset var names = structKeyArray(variables.keys)>
		<cfset var defaultNames = "">
		<cfset var i = 0>
		
		<cfif structKeyExists(variables, "defaults")>
			<cfset defaultNames = variables.defaults.propertyNames()>
			<cfloop index="i" from="1" to="#arrayLen(defaultNames)#">
				<cfif NOT names.contains(defaultNames[i])>
					<cfset arrayAppend(names, defaultNames[i])>
				</cfif>
			</cfloop>
		</cfif>
		
		<cfset arraySort(names, "text", "asc")>
		
		<cfreturn names/>
	</cffunction>


	<!-------------------------------------------------------------------------------------->
	<!-------------------------------------------------------------------------------------->


	<cffunction name="getPropertyNameFromLine" returntype="string" access="private" output="false">
		<cfargument name="line" type="string" required="true"/>
		<cfargument name="context" type="struct" required="true"/>
		
		<cfset var name = "">
		<cfset var i = 0>
		<cfset var curChar = "">
		<cfset var escapeNext = FALSE>
		
		<cfif structKeyExists(arguments.context, "name")>
			<cfset arguments.context.remaining = arguments.line>
			<cfreturn arguments.context.name/>
		</cfif>
		
		<cfset arguments.context.line = arguments.line>
		<cfset arguments.context.substring = "">
		<cfset arguments.context.remaining = arguments.line>
		<cfset arguments.context.name = "">
		
		<cfloop index="i" from="1" to="#len(arguments.line)#">
			<cfset curChar = mid(arguments.line, i, 1)>
			
			<cfset arguments.context.substring = arguments.context.substring & curChar>
			
			<cfif len(arguments.context.remaining) GT 1>
				<cfset arguments.context.remaining = right(arguments.context.remaining, len(arguments.context.remaining)-1)>
			<cfelse>
				<cfset arguments.context.remaining = "">
			</cfif>
	
			<cfif curChar IS "\">
				<cfset escapeNext = TRUE>
			<cfelse>
				<cfif NOT escapeNext AND ListFind("=,:, ", curChar, ",")>
					<cfbreak/>
				<cfelseif escapeNext AND ListFind("r,n", curChar, ",")>
					<cfif curChar IS "r">
						<cfset name = name & Chr(13)>
					<cfelse>
						<cfset name = name & Chr(10)>
					</cfif>
				<cfelse>
					<cfset name = name & curChar>
				</cfif>
		
				<cfset escapeNext = FALSE>
			</cfif>
			
			<cfset arguments.context.name = name>
		</cfloop>
		
		<cfreturn name/>
	</cffunction>
	
	
	<!-------------------------------------------------------------------------------------->
	
	
	<cffunction name="getPropertyValueFromLine" returntype="string" access="private" output="false">
		<cfargument name="line" type="string" required="true"/>
		<cfargument name="context" type="struct" required="true"/>
		
		<cfset var i = 0>
		<cfset var curChar = "">
		<cfset var value = "">
	
		<cfif NOT (structKeyExists(arguments.context, "multiline") AND arguments.context.multiline IS TRUE)>
			<cfset arguments.context.multiline = FALSE>
		</cfif>
		
		
		<cfif structKeyExists(arguments.context, "value")>
			<cfset arguments.context.firstline = FALSE>
		<cfelse>
			<cfset arguments.context.firstline = TRUE>
		</cfif>
		
		<cfif reFind("\\+$", line, 1, true).len[1] MOD 2>
			<cfset arguments.context.multiline = TRUE>
			<cfset arguments.context.lastline = FALSE>
			
			<cfif len(arguments.context.remaining) GT 1>
				<cfset arguments.context.remaining = left(arguments.context.remaining, len(arguments.context.remaining)-1)>
			<cfelse>
				<cfset arguments.context.remaining = "">
			</cfif>
			
			<cfif NOT structKeyExists(arguments.context, "lines")>
				<cfset arguments.context.lines = arrayNew(1)>
			</cfif>
		<cfelse>
			<cfset arguments.context.lastline = TRUE>
		</cfif>
		
		<cfif structKeyExists(arguments.context, "lines")>
			<cfset arrayAppend(arguments.context.lines, arguments.line)>
		</cfif>
		
		<cfloop index="i" from="1" to="#len(arguments.context.remaining)#">
			<cfset curChar = mid(arguments.context.remaining, i, 1)>
			
			<cfif listFind("=,:, ", curChar, ",")>
				<cfif len(value)>
					<cfset value = value & curChar>
				</cfif>
			<cfelse>
				<cfset value = value & curChar>
			</cfif>
		</cfloop>
		
		<cfset value = replace(value, "\r", Chr(13), "all")>
		<cfset value = replace(value, "\n", Chr(10), "all")>
		<cfset value = reReplace(value, "\\(.)", "\1", "all")>
		
		<cfif NOT arguments.context.firstline>
			<cfset value = arguments.context.value & value>
		</cfif>
	
		<cfset arguments.context.value = value>
			
		<cfreturn value/>
	</cffunction>
	
	
	<!-------------------------------------------------------------------------------------->

</cfcomponent>