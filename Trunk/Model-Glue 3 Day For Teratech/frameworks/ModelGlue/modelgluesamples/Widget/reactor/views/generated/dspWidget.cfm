    
<cfset listEvent = viewstate.getValue("myself") & viewstate.getValue("xe.list")  />
<cfset commitEvent = viewstate.getValue("myself") & viewstate.getValue("xe.commit") & "&WidgetId=" & urlEncodedFormat(viewstate.getValue("WidgetId")) />
<cfset WidgetRecord = viewstate.getValue("WidgetRecord") />
<cfset validation = viewstate.getValue("WidgetValidation", structNew()) />

<cfoutput>
<div id="breadcrumb"><a href="#listEvent#">Widgets</a> / View Widget</div>
</cfoutput>
<br />
  
<cfform class="edit">
    
<fieldset>
    

        <div class="formfield">
          <cfoutput>
	        <label for="name"><b>Name:</b></label>
	        <span class="input">#WidgetRecord.getname()#</span>
	        </cfoutput>
        </div>
    
        <div class="formfield">
          <cfoutput>
	        <label for="WidgetType"><b>Widget Type:</b>
	        </label>

					<cfif structKeyExists(WidgetRecord, "getwidgetTypeId")>
						<cfset targetObject = WidgetRecord.getwidgetTypeId() />
					<cfelseif structKeyExists(WidgetRecord, "getParentwidgetTypeId")>
						<cfset targetObject = WidgetRecord.getParentwidgetTypeId() />
					</cfif>
				
	        <div>
	       		#targetObject.getname()#
	        </div>
	        </cfoutput>
        </div>
      
        <div class="formfield">
          <cfoutput>
	        <label for="isActive"><b>Is Active:</b></label>
	        <span class="input">#WidgetRecord.getisActive()#</span>
	        </cfoutput>
        </div>
    
        <div class="formfield">
        	<label><b>name(s):</b></label>

					<!--- This XSL supports both Reactor and Transfer --->
					<cfif structKeyExists(WidgetRecord, "getWidgetCategoryStruct")>
						<cfset selected = WidgetRecord.getWidgetCategoryStruct() />
					<cfelseif structKeyExists(WidgetRecord, "getWidgetCategoryArray")>
						<cfset selected = WidgetRecord.getWidgetCategoryArray() />
					<cfelse>
						<cfset selected = WidgetRecord.getWidgetCategoryIterator().getQuery() />
					</cfif>

					<cfif isQuery(selected)>
						<cfset selectedList = valueList(selected.WidgetCategoryId) />
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
    
	
