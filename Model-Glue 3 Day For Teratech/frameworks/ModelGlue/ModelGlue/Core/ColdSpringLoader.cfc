<cfcomponent displayname="ColdSpringLoader" output="false">
	
<cffunction name="init" returntype="ColdSpringLoader" output="false">
	<cfreturn this />
</cffunction>

<cffunction name="load" returntype="ModelGlue.Bean.BeanFactory" output="false">
	<cfargument name="beanMappings" type="string" required="true" />

  <cfset var beanFactory = createObject("component","coldspring.beans.DefaultXmlBeanFactory").init()/>
  <cfset var mgAdapterFactory = createObject("component","coldspring.modelglue.ModelGlueBeanFactoryAdapter").init()/>
  <cfset var beanFile = ""/>

  <cfloop list="#arguments.beanMappings#" index="beanFile">
    <cfset beanFactory.loadBeans(expandPath(beanFile))>
  </cfloop>

	<cfset mgAdapterFactory.setBeanFactory(beanFactory)/>
	<cfreturn mgAdapterFactory />
</cffunction>

</cfcomponent>