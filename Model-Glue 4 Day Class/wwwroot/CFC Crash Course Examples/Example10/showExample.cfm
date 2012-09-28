<!--- create a company to add employees into --->
<cfset company = CreateObject("Component", "Company") />
<cfset company.setName("My Company, Inc.") />

<!--- create the boss --->
<cfset boss = CreateObject("Component", "Boss") />
<cfset boss.setFirstName("Bill") />
<cfset boss.setLastName("Blinsink") />

<!--- add the boss to the company --->
<cfset company.addEmployee(boss) />

<!--- create some employees --->
<cfset employees = ArrayNew(1) />

<cfset employee = CreateObject("Component", "Employee") /> 
<cfset employee.setFirstName("Bob") /> 
<cfset employee.setLastName("Smith") />
<cfset employee.setBoss(boss) />
<!--- add the employee to the company --->
<cfset company.addEmployee(employee) />

<cfset ArrayAppend(employees, employee) />

<cfset employee = CreateObject("Component", "Employee") /> 
<cfset employee.setFirstName("Ann") /> 
<cfset employee.setLastName("Miller") />
<cfset employee.setBoss(boss) />

<!--- add the employee to the company --->
<cfset company.addEmployee(employee) />

<cfset ArrayAppend(employees, employee) />

<!--- dump the boss and his employees --->
<cfdump var="#company.getEmployees()#" />