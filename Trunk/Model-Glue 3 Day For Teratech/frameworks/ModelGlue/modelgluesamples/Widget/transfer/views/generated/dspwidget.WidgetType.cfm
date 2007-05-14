    
<cfset listEvent = viewstate.getValue("myself") & viewstate.getValue("xe.list")  />
<cfset commitEvent = viewstate.getValue("myself") & viewstate.getValue("xe.commit") & "&widget.WidgetTypeId=" & urlEncodedFormat(viewstate.getValue("widget.WidgetTypeId")) />
<cfset widget.WidgetTypeRecord = viewstate.getValue("widget.WidgetTypeRecord") />
<cfset validation = viewstate.getValue("widget.WidgetTypeValidation", structNew()) />

<cfoutput>
<div id="breadcrumb"><a href="#listEvent#">Widget Types</a> / View Widget Type</div>
</cfoutput>
<br />
  
<cfform class="edit">
    
<fieldset>
    

        <div class="formfield">
          <cfoutput>
	        <label for="name"><b>Name:</b></label>
	        <span class="input">#widget.WidgetTypeRecord.getname()#</span>
	        </cfoutput>
        </div>
    
        <div class="formfield">
        	<label><b>name(s):</b></label>

					<!--- This XSL supports both Reactor and Transfer --->
					<cfif structKeyExists(widget.WidgetTypeRecord, "getWidgetStruct")>
						<cfset selected = widget.WidgetTypeRecord.getWidgetStruct() />
					<cfelseif structKeyExists(widget.WidgetTypeRecord, "getWidgetArray")>
						<cfset selected = widget.WidgetTypeRecord.getWidgetArray() />
					<cfelse>
						<cfset selected = widget.WidgetTypeRecord.getWidgetIterator().getQuery() />
					</cfif>

					<cfif isQuery(selected)>
						<cfset selectedList = valueList(selected.widgetId) />
						<div class="formfieldinputstack">
						<cfoutput query="selected">
							#selected.name#<br />
						</cfoutput>
						</div>
					<cfelseif isStruct(selected)>
						<cfoutput>
						<div class="formfieldinputstack">
						<cfloop collection="#selected#" item="i">
							#selected[i].getname()#<br />
						</cfloop>
						</div>
						</cfoutput>
					<cfelseif isArray(selected)>
						<cfoutput>
						<div class="formfieldinputstack">
						<cfloop from="1" to="#arrayLen(selected)#" index="i">
							#selected[i].getname()#<br />
						</cfloop>
						</div>
						</cfoutput>
					</cfif>

        </div>
          
      
</fieldset>
</div>
</cfform>
    
	
