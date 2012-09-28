    
<cfset listEvent = viewstate.getValue("myself") & viewstate.getValue("xe.list")  />
<cfset commitEvent = viewstate.getValue("myself") & viewstate.getValue("xe.commit") & "&WidgetCategoryId=" & urlEncodedFormat(viewstate.getValue("WidgetCategoryId")) />
<cfset WidgetCategoryRecord = viewstate.getValue("WidgetCategoryRecord") />
<cfset validation = viewstate.getValue("WidgetCategoryValidation", structNew()) />

<cfoutput>
<div id="breadcrumb"><a href="#listEvent#">Widget Categorys</a> / View Widget Category</div>
</cfoutput>
<br />
  
<cfform class="edit">
    
<fieldset>
    

        <div class="formfield">
          <cfoutput>
	        <label for="name"><b>Name:</b></label>
	        <span class="input">#WidgetCategoryRecord.getname()#</span>
	        </cfoutput>
        </div>
    
        <div class="formfield">
        	<label><b>name(s):</b></label>

					<!--- This XSL supports both Reactor and Transfer --->
					<cfif structKeyExists(WidgetCategoryRecord, "getWidgetStruct")>
						<cfset selected = WidgetCategoryRecord.getWidgetStruct() />
					<cfelseif structKeyExists(WidgetCategoryRecord, "getWidgetArray")>
						<cfset selected = WidgetCategoryRecord.getWidgetArray() />
					<cfelse>
						<cfset selected = WidgetCategoryRecord.getWidgetIterator().getQuery() />
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
    
	
