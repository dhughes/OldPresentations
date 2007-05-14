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

<cfsilent>
	<!---
	**
	* CF5 Debugging Output 
	*
	* Copyright (c) 2001 Macromedia.  All Rights Reserved.
	* DO NOT REDISTRIBUTE THIS SOFTWARE IN ANY WAY WITHOUT THE EXPRESSED
	* WRITTEN PERMISSION OF MACROMEDIA. 
	--->
	
	<!---
		Modified by Paul Kenney (paul@corporatewarriors.com)
	--->

	<cfsetting showdebugoutput="true"/>
</cfsilent>

<!--------------------------------------------------------------->

<cfif IsDebugMode()>
	<cfsilent>
		<cfset startTime = getTickCount()>
		
		<cfset formEncoding = getEncoding("FORM")>
		<cfset urlEncoding = getEncoding("URL")>
		<cfset setEncoding("FORM", formEncoding)>
		<cfset setEncoding("URL", urlEncoding)>
		
		<!--- Localized strings --->
		<cfset undefined = "">
		
		<!--- Use the debugging service to check options --->
		<cftry>
			<cfset factory = CreateObject("java", "coldfusion.server.ServiceFactory")>
			<cfset cfdebugger = factory.getDebuggingService()>
			
			<cfcatch type="Any"></cfcatch>
		</cftry>
	
		<!--- Load the debugging service's event table --->
		<cfset qEvents = cfdebugger.getDebugger().getData()>
	
		<!--- Produce the filtered event queries --->
		<!--- EVENT: Templates --->
		<cftry>
			<cfquery dbType="query" name="cfdebug_templates" debug="false">
				SELECT	template, parent, Sum(endTime - StartTime) AS et
				FROM	qEvents
				WHERE	type = 'Template'
				GROUP BY template, parent
				ORDER BY et DESC
			</cfquery>
			<cfcatch type="Any"></cfcatch>
		</cftry>
		
		<!--- EVENT: SQL Queries --->
		<cftry>
			<cfquery dbType="query" name="cfdebug_queries" debug="false">
				SELECT	*, (endTime - startTime) AS executionTime
				FROM	qEvents
				WHERE	type = 'SqlQuery'
			</cfquery>
			<cfcatch type="Any"></cfcatch>
		</cftry>
		
		<!--- EVENT: Object Queries --->
		<cftry>
			<cfquery dbType="query" name="cfdebug_cfoql" debug="false">
				SELECT	*, (endTime - startTime) AS executionTime
				FROM	qEvents
				WHERE	type = 'ObjectQuery'
			</cfquery>
			<cfcatch type="Any"></cfcatch>
		</cftry>
		
		<!--- EVENT: Stored Procedures --->
		<cftry>
			<cfquery dbType="query" name="cfdebug_storedproc" debug="false">
				SELECT	*, (endTime - startTime) AS executionTime
				FROM	qEvents
				WHERE	type = 'StoredProcedure'
			</cfquery>
			<cfcatch type="Any"></cfcatch>
		</cftry>
		
		<!--- EVENT: Trace Points --->
		<cftry>
			<cfquery dbType="query" name="cfdebug_trace" debug="false">
				SELECT	*
				FROM	qEvents
				WHERE	type = 'Trace'
			</cfquery>
			<cfcatch type="Any"></cfcatch>
		</cftry>
		
		<!--- EVENT: Locking Warning Points --->
		<cftry>
			<cfquery dbType="query" name="cfdebug_lock" debug="false">
				SELECT	*
				FROM	qEvents
				WHERE	type = 'LockWarning'
			</cfquery>
			<cfcatch type="Any"></cfcatch>
		</cftry>
		
		<!--- EVENT: Exceptions --->
		<cftry>
			<cfquery dbType="query" name="cfdebug_ex" debug="false">
				SELECT	*
				FROM	qEvents
				WHERE	type = 'Exception'
			</cfquery>
			<cfcatch type="Any"></cfcatch>
		</cftry>
	
		<!----------------------------------------------------------------->
		
		<!--- Establish Section Display Flags --->
		<cfparam name="displayDebug" type="boolean" default="false"/><!--- ::	display the debug time 	:: --->
		<cfparam name="bGeneral" type="boolean" default="false"/>
		<cfparam name="bFoundExecution" type="boolean" default="false"/>
		<cfparam name="bFoundTemplates" type="boolean" default="false"/>
		<cfparam name="bFoundExceptions" type="boolean" default="false"/>
		<cfparam name="bFoundSQLQueries" type="boolean" default="false"/>
		<cfparam name="bFoundObjectQueries" type="boolean" default="false"/>
		<cfparam name="bFoundStoredProc" type="boolean" default="false"/>
		<cfparam name="bFoundTrace" type="boolean" default="false"/>
		<cfparam name="bFoundLocking" type="boolean" default="false"/>
		<cfparam name="bFoundScopeVars" type="boolean" default="false"/>
		
		<cftry>
			<cfscript>
				// no longer doing template query at the top since we have tree and summary mode
				bFoundTemplates = cfdebugger.check("Template");
				
				if( bFoundTemplates )
				{ displayDebug=true; }
	
				if ( isDefined("cfdebugger.settings.general") and cfdebugger.settings.general )
				{ bGeneral = true; displayDebug=true; }
				
				if (IsDefined("cfdebug_ex") AND cfdebug_ex.recordCount GT 0) { bFoundExceptions = true; displayDebug=true; }
				else { bFoundExceptions = false; }
				
				if (IsDefined("cfdebug_queries") AND cfdebug_queries.RecordCount GT 0) { bFoundSQLQueries = true; displayDebug=true; }
				else { bFoundSQLQueries = false; }
				
				if (IsDefined("cfdebug_cfoql") AND cfdebug_cfoql.RecordCount GT 0) { bFoundObjectQueries = true; displayDebug=true; }
				else { bFoundObjectQueries = false; }
				
				if (IsDefined("cfdebug_storedproc") AND cfdebug_storedproc.RecordCount GT 0) { bFoundStoredProc = true; displayDebug=true; }
				else { bFoundStoredProc = false; }
				
				if (IsDefined("cfdebug_trace") AND cfdebug_trace.recordCount GT 0) { bFoundTrace = true; displayDebug=true; }
				else { bFoundTrace = false; }
				
				if (IsDefined("cfdebug_lock") AND cfdebug_lock.recordCount GT 0) { bFoundLocking = true; displayDebug=true; }
				else { bFoundLocking = false; }
				
				if (IsDefined("cfdebugger") AND cfdebugger.check("Variables")) { bFoundScopeVars = true; displayDebug=true; }
				else { bFoundScopeVars = false; }
			</cfscript>
			<cfcatch type="Any"></cfcatch>
		</cftry>
	</cfsilent>
	
	<!----------------------------------------------------------------->
	<cfsetting enablecfoutputonly="true"/>
	<!----------------------------------------------------------------->
	
	<cfmodule template="/cfcunit/app/tag/layout/container.cfm" id="debugSummary" title="Debug Summary" onclick="debug_toggleContents(this);">
	
		<cfif displayDebug>
			<cfoutput>
				<cfmodule template="/cfcunit/app/tag/util/htmlhead.cfm">
					<link href="assets/styles/debug.css" rel="stylesheet" type="text/css" />
					<script src="assets/scripts/debug.js" type="text/javascript" language="JavaScript"></script>
				</cfmodule>
			</cfoutput>
		</cfif>
		
		<!---------------------------------------------------------------------->
		
		<cfif bGeneral>
			<cfoutput>
				<cftry>
					<h2><a name="cfdebug_top">General Information</a></h2>
					
					<table class="debugSection">
						<tr>
							<td><label>#server.coldfusion.productname# #server.coldfusion.productlevel#</label></td>
							<td>#server.coldfusion.productversion#</td>
						</tr>
						<tr>
							<td><label>Template</label></td>
							<td>#CGI.Script_Name#</td>
						</tr>
						<tr>
							<td><label>Time Stamp</label></td>
							<td>#DateFormat(Now())# #TimeFormat(Now())#</td>
						</tr>
						<tr>
							<td><label>Locale</label></td>
							<td>#GetLocale()#</td>
						</tr>
						<tr>
							<td><label>User Agent</label></td>
							<td>#CGI.HTTP_USER_AGENT#</td>
						</tr>
						<tr>
							<td><label>Remote IP</label></td>
							<td>#CGI.REMOTE_ADDR#</td>
						</tr>
						<tr>
							<td><label>Host Name</label></td>
							<td>#CGI.REMOTE_HOST#</td>
						</tr>
					</table>
					<cfcatch type="Any"></cfcatch>
				</cftry>
			</cfoutput>
		</cfif>
		
		<!---------------------------------------------------------------------->
		
		<!--- Template Stack and Executions Times --->
		<cfif bFoundTemplates>
			<!--- Total Execution Time of all top level pages --->
			<cfquery dbType="query" name="cfdebug_execution" debug="false">
				SELECT	(endTime - startTime) AS executionTime
				FROM	qEvents
				WHERE	type = 'ExecutionTime'
			</cfquery>
			<!--- ::	
				in the case that no execution time is recorded. 
				we will add a value of -1 so we know that a problem exists but the template continues to run properly.	
				:: --->
			<cfif not cfdebug_execution.recordCount>
				<cfscript>
					queryAddRow(cfdebug_execution);
					querySetCell(cfdebug_execution, "executionTime", "-1");
				</cfscript>
			</cfif>
			
			
			<cfquery dbType="query" name="cfdebug_top_level_execution_sum" debug="false">
				SELECT	sum(endTime - startTime) AS executionTime
				FROM	qEvents
				WHERE	type = 'Template' AND parent = ''
			</cfquery>
			
			<!--- File not found will not produce any records when looking for top level pages --->
			<cfif cfdebug_top_level_execution_sum.recordCount>
				<cfset time_other = Max(cfdebug_execution.executionTime - cfdebug_top_level_execution_sum.executionTime, 0)>
				
				<cfoutput>
				<cfmodule template="/cfcunit/app/tag/util/htmlhead.cfm">
					<style type="text/css">
						.template {	
							color: black; 
							font-family: "Times New Roman", Times, serif; 
							font-weight: normal;
						}
				
						.template_overage {
							color: red; 
							background-color: white; 
							font-family: "Times New Roman", Times, serif; 
							font-weight: bold;
						}
					</style>
				</cfmodule>
				
				<h2><a name="cfdebug_execution">Execution Time</a></h2>
				
				<div class="debugSection">
				
				<a name="cfdebug_templates" />
				</cfoutput>
					
				<cfif cfdebugger.settings.template_mode EQ "tree">
					<cfset a = arrayNew(1)>
					<cfloop query="qEvents">
					   <cfscript>
							// only want templates, IMQ of SELECT * ...where type = 'template' will result
							// in cannot convert the value "" to a boolean for cachedquery column
							// SELECT stacktrace will result in Query Of Queries runtime error.
							// Failed to get meta_data for columnqEvents.stacktrace .
							// Was told I need to define meta data for debugging event table similar to <cfldap>
							if( qEvents.type eq "template" ) {
								st = structNew();
								st.StackTrace = qEvents.stackTrace;
								st.template = qEvents.template;
								st.startTime = qEvents.starttime;
								st.endTime = qEvents.endtime;
								st.parent =  qEvents.parent;
								st.line =  qEvents.line;
								
								arrayAppend(a, st);
							}
					   </cfscript>
					</cfloop>
					
					<cfset qTree = queryNew("template,templateId,parentId,duration,line")>
					<cfloop index="i" from="1" to="#arrayLen(a)#">
						<cfset childidList = "">
						<cfset parentidList = "">
						<cfloop index="x" from="#arrayLen(a[i].stacktrace.tagcontext)#" to="1" step="-1">
							<cfscript>
								if( a[i].stacktrace.tagcontext[x].id NEQ "CF_INDEX" ) {
									// keep appending the line number from the template stack to form a unique id
									childIdList = listAppend(childIdList, a[i].stacktrace.tagcontext[x].line);
									if( x eq 1 ) {
										parentIdList = listAppend(parentIdList, a[i].stacktrace.tagcontext[x].template);
									} else {
										parentIdList = listAppend(parentIdList, a[i].stacktrace.tagcontext[x].line);
									}
								}
							</cfscript>
						</cfloop>
					
						<cfscript>
							// template is the last part of the unique id...12,5,17,c:\wwwroot\foo.cfm
							// if we don't remove the "CFC[" prefix, then the parentId and childId relationship
							// will be all wrong
							startToken = "CFC[ ";
							endToken = " | ";
							thisTemplate = a[i].template;
							startTokenIndex = FindNoCase(startToken, thisTemplate, 1);
							if( startTokenIndex NEQ 0 ) {
								endTokenIndex = FindNoCase(endToken, thisTemplate, startTokenIndex);
								thisTemplate = Trim(Mid(thisTemplate,Len(startToken),endTokenIndex-Len(startToken)));
							}
							childIdList = listAppend(childIdList, thisTemplate);
							
							queryAddRow(qTree);
							querySetCell(qTree, "template", a[i].template);    
							querySetCell(qTree, "templateId", childIdList);    
							querySetCell(qTree, "parentId", parentIdList);    
							querySetCell(qTree, "duration", a[i].endtime - a[i].starttime);    
							querySetCell(qTree, "line", a[i].line);    
						</cfscript>
					</cfloop>
					
					<cfset stTree = structNew()>
					<cfloop query="qTree">
						<cfscript>
						// empty parent assumed to be top level with the exception of application.cfm
						if( len(trim(parentId)) eq 0 ){
							parentId = 0;
						}
							stTree[parentId] = structNew();
							stTree[parentId].templateId = qTree.templateId;
							stTree[parentId].template = qTree.template;
							stTree[parentId].duration = qTree.duration;
							stTree[parentId].line = qTree.line;
							stTree[parentId].children = arrayNew(1);
						</cfscript>
					</cfloop>
					<cfloop query="qTree">
						<cfscript>
							stTree[templateId] = structNew();
							stTree[templateId].templateId = qTree.templateId;
							stTree[templateId].template = qTree.template;
							stTree[templateId].duration = qTree.duration;
							stTree[templateId].line = qTree.line;
							stTree[templateId].children = arrayNew(1);
						</cfscript>
					</cfloop>
					<cfloop query="qTree">
						<cfscript>
							arrayAppend(stTree[parentId].children, stTree[templateId]);
						</cfscript>
					</cfloop>
					
					<cfquery dbType="query" name="topNodes" debug="false">
						SELECT	parentId, template
						FROM	qTree
						WHERE	parentId = ''
					</cfquery>
					
					<cfoutput>			   
						<cfloop query="topNodes">
							#drawTree(topNodes.stTree, -1, topNodes.template, cfdebugger.settings.template_highlight_minimum)#
						</cfloop> 
						
						<p class="template">
							(#time_other# ms) STARTUP, PARSING, COMPILING, LOADING, &amp; SHUTDOWN<br />
							(#cfdebug_execution.executionTime# ms) TOTAL EXECUTION TIME<br />
							<font color="red">
							<span class="template_overage">
								red = over #cfdebugger.settings.template_highlight_minimum# ms execution time
							</span>
							</font>
						</p>
					</cfoutput>
				<cfelse>
					<!--- template_mode = summary--->
					<cftry>
						<cfquery dbType="query" name="cfdebug_templates_summary" debug="false">
							SELECT	template, 
									Sum(endTime - startTime) AS totalExecutionTime, 
									count(template) AS instances
									
							FROM	qEvents
							WHERE	type = 'Template'
							
							GROUP BY template
							ORDER BY totalExecutionTime DESC
						</cfquery>
						
						<cfoutput>
						<table border="1" cellpadding="2" cellspacing="0" class="cfdebug">
							<tr valign="bottom">
								<th>Total Time</th>
								<th>Avg Time</th>
								<th>Count</th>
								<th align="left">Template</th>
							</tr>
						</cfoutput>
				
						<cftry>
							<cfoutput query="cfdebug_templates_summary">
								<cfset templateOutput = template>
								<cfset templateAverageTime = Round(totalExecutionTime / instances)>
								
								<cfif template EQ ExpandPath(cgi.script_name)>
									<cfset templateOutput = "<img src='#getpageContext().getRequest().getContextPath()#/CFIDE/debug/images/topdoc.gif' alt='top level' border='0'> " &
										"<b>" & template & "</b>">
								<cfelse>
									<cfif templateAverageTime GT cfdebugger.settings.template_highlight_minimum>
										<cfset templateOutput = "<font color='red'><span class='template_overage'>" & template & "</span></font>">
										<cfset templateAverageTime = "<font color='red'><span class='template_overage'>" & templateAverageTime & "</span></font>">
									</cfif>
								</cfif>
			
								<tr>
									<td align="right" class="cfdebug" nowrap>#totalExecutionTime# ms</td>
									<td align="right" class="cfdebug" nowrap>#templateAverageTime# ms</td>
									<td align="center" class="cfdebug" nowrap>#instances#</td>
									<td align="left" class="cfdebug" nowrap>#templateOutput#</td>
								</tr>
								</cfoutput>
							<cfcatch type="Any"></cfcatch>
						</cftry>
						
						<cfoutput>
								<tr>
									<td align="right" class="cfdebug" nowrap><i>#time_other# ms</i></td><td colspan=2>&nbsp;</td>
									<td align="left" class="cfdebug"><i>STARTUP, PARSING, COMPILING, LOADING, &amp; SHUTDOWN</i></td>
								</tr>
								<tr>
									<td align="right" class="cfdebug" nowrap><i>#cfdebug_execution.executionTime# ms</i></td><td colspan=2>&nbsp;</td>
									<td align="left" class="cfdebug"><i>TOTAL EXECUTION TIME</i></td>
								</tr>
							</table>
							
							<font color="red">
							<span class="template_overage">
							red = over #cfdebugger.settings.template_highlight_minimum# ms average execution time
							</span>
							</font>
							</a>
						</div>
						</cfoutput>
		
						<cfcatch type="Any"></cfcatch>
					</cftry>
				</cfif>
			<cfelse>
				<!--- if top level templates are available --->
				<div class="debugSection">
					<h2><a name="cfdebug_execution">Execution Time</a></h2>
					<a name="cfdebug_templates" />
					No top level page was found.
				</div>
			</cfif>
		</cfif>
		
		<!---------------------------------------------------------------------->
		
		<!--- Exceptions --->
		<cfif bFoundExceptions>
			<cftry>
				<cfoutput>
					<h2><a name="cfdebug_exceptions">Exceptions</a></h2>
					
					<table class="debugSection">
						<cfloop query="cfdebug_ex">
							<tr valign="top">
								<td rowspan="2" width="120">#TimeFormat(cfdebug_ex.timestamp, "HH:mm:ss.SSS")#</td>
								<td>#cfdebug_ex.name#</td>
								<td>
									<cfif FindNoCase("Exception", cfdebug_ex.name) EQ 0>Exception</cfif>
									- in #cfdebug_ex.template# : line #cfdebug_ex.line#
								</td>
							</tr>
							<tr valign="top">
								<td colspan="2">
									<cfif IsDefined("cfdebug_ex.message") AND Len(Trim(cfdebug_ex.message)) GT 0>
										#HTMLCodeFormat(cfdebug_ex.message)#
										<br />
									</cfif>
								</td>
							</tr>
						</cfloop>
					</table>
				</cfoutput>
			
				<cfcatch type="Any">
					<!--- Error reporting an exception event entry. --->	
				</cfcatch>
			</cftry>
		</cfif>
		
		<!---------------------------------------------------------------------->
		
		<!--- SQL Queries --->
		<cfoutput>
		<cfif bFoundSQLQueries>
			<cftry>
				<h2><a name="cfdebug_sql">SQL Queries</a></h2>
	
				<cfloop query="cfdebug_queries">
					<code><b>#cfdebug_queries.name#</b> (Datasource=#cfdebug_queries.datasource#, Time=#Max(cfdebug_queries.executionTime, 0)#ms<cfif IsDefined("cfdebug_queries.rowcount") AND IsNumeric(cfdebug_queries.rowcount)>, Records=#Max(cfdebug_queries.rowcount, 0)#<cfelseif IsDefined("cfdebug_queries.result.recordCount")>, Records=#cfdebug_queries.result.recordCount#</cfif><cfif cfdebug_queries.cachedquery>, Cached Query</cfif>) in #cfdebug_queries.template# @ #TimeFormat(cfdebug_queries.timestamp, "HH:mm:ss.SSS")#</code><br />
					<pre>#cfdebug_queries.body#</pre>
					
					<cfif arrayLen(cfdebug_queries.attributes) GT 0>
						<code>Query Parameter Value(s) -<br />
					
						<cfloop index="x" from=1 to="#arrayLen(cfdebug_queries.attributes)#">
							<cfset thisParam = #cfdebug_queries.attributes[cfdebug_queries.currentRow][x]#>
							Parameter ###x#<cfif StructKeyExists(thisParam, "sqlType")>(#thisParam.sqlType#)</cfif> = <cfif StructKeyExists(thisParam, "value")>#thisParam.value#</cfif><br />
						</cfloop>
						</code><br />
					</cfif>
				</cfloop>
			
				<cfcatch type="Any">
					<!--- Error reporting query event --->
				</cfcatch>
			</cftry>
		</cfif>
		
		<!---------------------------------------------------------------------->
		
		<!--- Stored Procs --->
		<cfif bFoundStoredProc>
			<cftry>
				<h2><a name="cfdebug_storedproc">Stored Procedures</a></h2>
				
				<p class="cfdebug">
				<cfloop query="cfdebug_storedproc">
				<!--- Output stored procedure details, remember, include result (output params) and attributes (input params) columns --->
				<code><b>#cfdebug_storedproc.name#</b> (Datasource=#cfdebug_storedproc.datasource#, Time=#Max(cfdebug_storedproc.executionTime, 0)#ms) in #cfdebug_storedproc.template# @ #TimeFormat(cfdebug_storedproc.timestamp, "HH:mm:ss.SSS")#</code><br />
					<table border=0 cellpadding=0 cellspacing=0>
					<tr>
						<td>&nbsp;&nbsp;&nbsp;&nbsp;</td>
						<td>
							<table border=1 cellpadding=2 cellspacing=2>
							<tr bgcolor="gray"><td colspan="5" align="center"><font color="white">parameters</font></td></tr>
							<tr><td><code><i>type</i></code></td><td><code><i>CFSQLType</i></code></td><td><code><i>value</i></code></td><td><code><i>variable</i></code></td><td><code><i>dbVarName</i></code></td></tr>
							
							<cfloop index="x" from=1 to="#arrayLen(cfdebug_storedproc.attributes)#">
							<cfset thisParam = #cfdebug_storedproc.attributes[cfdebug_storedproc.currentRow][x]#>
							<tr>
								<td>&nbsp;<code><cfif StructKeyExists(thisParam, "type")>#thisParam.type#</cfif></code></td>
								<td>&nbsp;<code><cfif StructKeyExists(thisParam, "sqlType")>#thisParam.sqlType#</cfif></code></td>
								<td>&nbsp;<code><cfif StructKeyExists(thisParam, "value")>#thisParam.value#</cfif></code></td>
								<td>&nbsp;<code><cfif StructKeyExists(thisParam, "variable")>#thisParam.variable# = #CFDebugSerializable(thisParam.variable)#</cfif></code></td>
								<td>&nbsp;<code><cfif StructKeyExists(thisParam, "dbVarName")>#thisParam.dbVarName#</cfif></code></td>
							</tr>
							</cfloop>
							</table>
						</td>
					</tr>
					<tr>
						<td>&nbsp;&nbsp;&nbsp;&nbsp;</td>
						<td>
							<table border=1 cellpadding=2 cellspacing=2>
							<tr bgcolor="gray"><td colspan="5" align="center"><font color="white">resultsets</font></td></tr>
							<tr><td><code><i>name</i></code></td><td><code><i>resultset</i></code></td></tr>
							
							<cfloop index="x" from=1 to="#arrayLen(cfdebug_storedproc.result)#">
							<cfset thisParam = #cfdebug_storedproc.result[cfdebug_storedproc.currentRow][x]#>
							<tr>
								<td>&nbsp;<code><cfif StructKeyExists(thisParam, "name")>#thisParam.name#</cfif></code></td>
								<td>&nbsp;<code><cfif StructKeyExists(thisParam, "resultSet")>#thisParam.resultSet#</cfif></code></td>
							</tr>
							</cfloop>
							</table>
						</td>
					</tr>
					</table>
				</cfloop>
				</p>
				
				<cfcatch type="Any">
					<!--- Error reporting stored proc event --->
				</cfcatch>
			</cftry>
		</cfif>
		
		<!---------------------------------------------------------------------->
		
		<!--- Tracing --->
		<cfif bFoundTrace>
			<h2><a name="cfdebug_trace">Trace Points</a></h2>
		
			<p class="cfdebug">
				<cfset firstTrace = true>
				<cfset prevDelta = 0>
				
				<cfloop query="cfdebug_trace">
					<cfset deltaFromRequest = Val(cfdebug_trace.endTime)>
					<cfset deltaFromLast = Val(deltaFromRequest-prevDelta)>
					<cftry>
						<img src='#getpageContext().getRequest().getContextPath()#/CFIDE/debug/images/#Replace(cfdebug_trace.priority, " ", "%20")#_16x16.gif' alt="#cfdebug_trace.priority# type"> [#TimeFormat(cfdebug_trace.timestamp, "HH:mm:ss.lll")# #cfdebug_trace.template# @ line: #cfdebug_trace.line#] [#deltaFromRequest# ms (<cfif firstTrace>1st trace<cfelse>#deltaFromLast# ms</cfif>)] - <cfif #cfdebug_trace.category# NEQ "">[#cfdebug_trace.category#]</cfif> <cfif #cfdebug_trace.result# NEQ "">[#cfdebug_trace.result#]</cfif> <i>#cfdebug_trace.message#</i><br />
						<cfcatch type="Any"></cfcatch>
					</cftry>
					<cfset prevDelta = deltaFromRequest>
					<cfset firstTrace = false>
				</cfloop>
			</p>
		</cfif>
		
		<!---------------------------------------------------------------------->
		
		<!--- SCOPE VARIABLES --->
		<cfif bFoundScopeVars>
			<h2><a name="cfdebug_scopevars">Scope Variables</a></h2>
			
			<cftry>
				<cfif IsDefined("APPLICATION") AND IsStruct(APPLICATION) AND StructCount(APPLICATION) GT 0 AND cfdebugger.check("ApplicationVar")>
					<h3>Application Variables:</h3>
					<p>#sortedScope(application, "<br />")#</p>
				</cfif>
				<cfcatch type="Any"></cfcatch>
			</cftry>
			
			<cftry>
				<cfif IsDefined("CGI") AND IsStruct(CGI) AND StructCount(CGI) GT 0 AND cfdebugger.check("CGIVar")>
					<h3>CGI Variables:</h3>
					<p>#sortedScope(cgi, "<br />")#</p>
				</cfif>
				<cfcatch type="Any"></cfcatch>
			</cftry>
			
			<cftry>
				<cfif IsDefined("CLIENT") AND IsStruct(CLIENT) AND StructCount(CLIENT) GT 0 AND cfdebugger.check("ClientVar")>
					<h3>Client Variables:</h3>
					<p>#sortedScope(client, "<br />")#</p>
				</cfif>
				<cfcatch type="Any"></cfcatch>
			</cftry>
			
			<cftry>
				<cfif IsDefined("COOKIE") AND IsStruct(COOKIE) AND StructCount(COOKIE) GT 0 AND cfdebugger.check("CookieVar")>
					<h3>Cookie Variables:</h3>
					<p>#sortedScope(cookie, "<br />")#</p>
				</cfif>
				<cfcatch type="Any"></cfcatch>
			</cftry>
			
			<cftry>
				<cfif IsDefined("FORM") AND IsStruct(FORM) AND StructCount(FORM) GT 0 AND cfdebugger.check("FormVar")>
					<h3>Form Fields:</h3>
					<p>#sortedScope(form, "<br />")#</p>
				</cfif>
				<cfcatch type="Any"></cfcatch>
			</cftry>
			
			<cftry>
				<cfif IsDefined("REQUEST") AND IsStruct(REQUEST) AND StructCount(REQUEST) GT 0 AND cfdebugger.check("RequestVar")>
					<h3>Request Parameters:</h3>
					<p>#sortedScope(request, "<br />")#</p>
				</cfif>
				<cfcatch type="Any"></cfcatch>
			</cftry>
			
			<cftry>
				<cfif IsDefined("SERVER") AND IsStruct(SERVER) AND StructCount(SERVER) GT 0 AND cfdebugger.check("ServerVar")>
					<h3>Server Variables:</h3>
					<p>#sortedScope(server, "<br />")#</p>
				</cfif>
				<cfcatch type="Any"></cfcatch>
			</cftry>
			
			<cftry>
				<cfif IsDefined("SESSION") AND IsStruct(SESSION) AND StructCount(SESSION) GT 0 AND cfdebugger.check("SessionVar")>
					<h3>Session Variables:</h3>
					<p>#sortedScope(session, "<br />")#</p>
				</cfif>
				<cfcatch type="Any"></cfcatch>
			</cftry>
			
			<cftry>
				<cfif IsDefined("URL") AND IsStruct(URL) AND StructCount(URL) GT 0 AND cfdebugger.check("URLVar")>
					<h3>URL Parameters:</h3>
					<p>#sortedScope(url, "<br />")#</p>
				</cfif>
				<cfcatch type="Any"></cfcatch>
			</cftry>
		</cfif>
		
		<!---------------------------------------------------------------------->
		
		<cfif displayDebug>
			<cfset duration = getTickCount() - startTime>
			<h4>Debug Rendering Time: #duration# ms</h4>
		</cfif>
		</cfoutput>
	
	</cfmodule>
	
	<!---------------------------------------------------------------------->	
	<cfsetting enablecfoutputonly="false"/>	
	<cfsetting showdebugoutput="false"/>
	<!---------------------------------------------------------------------->
</cfif>

<!---------------------------------------------------------------------->
<!--- DEBUGGING FUNCTIONS ---------------------------------------------->
<!---------------------------------------------------------------------->
<cfsilent>
	<cfscript>
	//==================================================================================
	// UDF - tree writing
	function drawNode(nTree, indent, id, highlightThreshold) {
		var templateOuput = "";
		if( nTree[id].duration GT highlightThreshold ) {
			templateOutput = "<font color='red'><span class='template_overage'>(#nTree[id].duration#ms) " & nTree[id].template & " @ line " & #nTree[id].line# & "</span></font><br>";
		} else {
			templateOutput = "<span class='template'>(#nTree[id].duration#ms) " & nTree[id].template & " @ line " & #nTree[id].line# & "</span><br>";
		}
		writeOutput(repeatString("&nbsp;&nbsp;&middot;", indent + 1) & " <img src='#getpageContext().getRequest().getContextPath()#/CFIDE/debug/images/arrow.gif' alt='arrow' border='0'><img src='#getpageContext().getRequest().getContextPath()#/CFIDE/debug/images/endDoc.gif' alt='top level' border='0'> " & templateOutput);
		return "";
	}
	
	//==================================================================================
	function drawTree(tree, indent, id, highlightThreshold) {
		var alength = 1; 
		var i = 1;
		var templateOuput = "";
	
		// top level nodes (application.cfm,cgi.script_name,etc) have a -1 parent line number
		if(tree[id].line EQ -1) {
			writeoutput( "<img src='#getpageContext().getRequest().getContextPath()#/CFIDE/debug/images/topdoc.gif' alt='top level' border='0'> " & "<span class='template'><b>(#Tree[id].duration#ms) " & Tree[id].template & "</b></span><br>" );
		} else {
			if( Tree[id].duration GT highlightThreshold ) {
				templateOutput = "<font color='red'><span class='template_overage'>(#Tree[id].duration#ms) " & Tree[id].template & " @ line " & #Tree[id].line# & "</span></font><br>";
			} else {
				templateOutput = "<span class='template'>(#Tree[id].duration#ms) " & Tree[id].template & " @ line " & #Tree[id].line# & "</span><br>";
			}
			writeoutput( repeatString("&nbsp;&nbsp;&middot;", indent + 1) & " <img src='#getpageContext().getRequest().getContextPath()#/CFIDE/debug/images/arrow.gif' alt='arrow' border='0'><img src='#getpageContext().getRequest().getContextPath()#/CFIDE/debug/images/parentDoc.gif' alt='top level' border='0'> " & templateOutput );
		}
	
		if( isArray( tree[id].children ) and arrayLen( tree[id].children ) ) {
			alength = arrayLen( tree[id].children );
			for( i = 1; i lte alength; i = i + 1 ) {
				if( isArray(tree[id].children[i].children) and arrayLen( tree[id].children[i].children ) gt 0 ) {
					drawTree(tree, indent + 1, tree[id].children[i].templateid, highlightThreshold);
				} else {
					drawNode(tree, indent + 1, tree[id].children[i].templateid, highlightThreshold);
				}
			}
		} else {
			// single template, no includes?
			//drawNode(tree, indent + 1, tree[id].template, highlightThreshold);
		}
		return "";
	}
	</cfscript>

	<!----------------------------------------------------------------------->
	
	<cffunction name="CFDebugSerializable" returntype="string" output="false" hint="Handle output of complex data types.">
		<cfargument name="variable" type="any" required="true" hint=""/>
		<!--- --->
		<cfset var ret = "">
	
		<cftry>
			<cfif IsSimpleValue(arguments.variable)>
				<cfset ret = "'" & wrapText(arguments.variable, 80, 10, true) & "'">
			<cfelseif IsStruct(arguments.variable)>
				<cfset ret = "Struct&nbsp;(" & StructCount(arguments.variable) & ")">
			<cfelseif IsArray(arguments.variable)>
				<cfset ret = "Array&nbsp;(" & ArrayLen(arguments.variable) & ")">
			<cfelseif IsQuery(arguments.variable)>
				<cfset ret = "Query&nbsp;(" & arguments.variable.RecordCount & ")">
			<cfelse>
				<cfset ret = "Complex type">
			</cfif>
		
			<cfcatch type="any">
				<cfset ret = "undefined">
			</cfcatch>
		</cftry>
		
		<cfreturn ret/>
	</cffunction>
	
	<!----------------------------------------------------------------------->
	
	<cffunction name="sortedScope" returntype="string" output="false" hint="">
		<cfargument name="scope" type="struct" required="true" hint=""/>
		<cfargument name="delimiter" type="string" required="false" hint=""/>
		<!--- --->
		<cfset var delim = Chr(13) & Chr(10)>
		<cfset var keyName = "">
		<cfset var keyValue = "">
		<cfset var retVal="">
		<cfset var keys = StructKeyArray(arguments.scope)>
		
		<cfif StructKeyExists(arguments, "delimiter")>
			<cfset delim = arguments.delimiter>
		</cfif>
		
		<cfset arraySort(keys, "text")>
		
		<cfloop index="x" from=1 to="#arrayLen(keys)#">
			<cfset keyName = keys[x]>
			<cfset retVal = retVal & keyName & "=">
			   <cftry>
					<cfset keyValue = CFDebugSerializable(scope[keyname])>
				<cfcatch>
					<cfset keyValue = "undefined">
				</cfcatch>
				</cftry>
			<!--- <cfset retVal = retVal & keyValue & Chr(13) & Chr(10)> --->
			<cfset retVal = retVal & keyValue & delim>
		</cfloop>
		<cfreturn retVal>
	</cffunction>
	
	<!----------------------------------------------------------------------->
	
	<cffunction name="wrapText" returntype="string" access="public" output="false" hint="">
		<cfargument name="text" type="string" required="true" hint=""/>
		<cfargument name="lineLength" type="numeric" required="true" hint=""/>
		<cfargument name="indentBy" type="numeric" required="false" default="0" hint=""/>
		<cfargument name="useElipses" type="boolean" required="false" default="false" hint=""/>
		<!--- --->
		<cfset var aLines = ArrayNew(1)>
		<cfset var lines = "">
		<cfset var line = "">
		<cfset var currentLine = 0>
		<cfset var i = 0>
		<cfset var textLen = Len(arguments.text)>
		<cfset var elipses = "...">
		
		<cfif NOT arguments.useElipses>
			<cfset elipses = "">
		</cfif>
		
		<cfloop index="i" from="1" to="#Len(arguments.text)#">
			<cfset line = line & Mid(arguments.text, i, 1)>
			<cfif (i MOD arguments.lineLength) IS 0 OR (i IS textLen)>
				<cfif i NEQ textLen>
					<cfset line = line & elipses>
				</cfif>
				
				<cfif ArrayLen(aLines)>
					<cfset line = RepeatString("&nbsp;", arguments.indentBy) & elipses & line>
				</cfif>
				<cfset ArrayAppend(aLines, line)>
				<cfset line = "">
			</cfif>
		</cfloop>
		
		<cfset lines = ArrayToList(aLines, "<br />")>
		
		<cfreturn lines/>
	</cffunction>
	
	<!----------------------------------------------------------------------->
</cfsilent>