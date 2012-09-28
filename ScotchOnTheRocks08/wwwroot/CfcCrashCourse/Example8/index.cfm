<!--- create the boss --->
<cfset boss = CreateObject("Component", "Boss") />
<cfset boss.setFirstName("Bill") />
<cfset boss.setLastName("Blinsink") />

<!--- create some employees --->
<cfset employees = ArrayNew(1) />

<cfset employee = CreateObject("Component", "Employee") /> 
<cfset employee.setFirstName("Bob") /> 
<cfset employee.setLastName("Smith") />
<cfset employee.setBoss(boss) />

<cfset ArrayAppend(employees, employee) />

<cfset employee = CreateObject("Component", "Employee") /> 
<cfset employee.setFirstName("Ann") /> 
<cfset employee.setLastName("Miller") />
<cfset employee.setBoss(boss) />

<cfset ArrayAppend(employees, employee) />

<!--- add the employees to the boss --->
<cfset boss.setSubordinates(employees) />

<!--- dump the boss and his employees --->
<cfdump var="#boss#" />

<cfdump var="#boss.getSubordinates()#" />