<cfcomponent>
<cfinclude template="../connection/connection.cfc">
<!--resetting variables-->
	<cfset This.user_id = "">
	<cfset This.name = "">
	<cfset This.center_id = ''>
	<cfset This.email = "">
	<cfset This.center = "">
    <cfset This.abbr = "">
    <cfset This.role = "">
	
	<cfset THIS.sBaseColor = "">
	<cfset THIS.sPaleColor = "">
	<cfset THIS.sLightColor = "">
	<cfset THIS.sImgHeader = "">
	<cfset THIS.sTitle = "">
	<cfset THIS.sAbbr = "">
	

<cffunction name="getUser" access="public" output="false" returntype="query" hint="returns a query of user info for the authenticated user">
  <cfargument name="authUser" type="string" required="yes">
  
  <CFSTOREDPROC procedure="dbo.viewUser" datasource="#datasource2#">
    <CFPROCPARAM type="IN" dbvarname="@username" value="#authUser#" cfsqltype="cf_sql_varchar">
    <CFPROCRESULT name="quser" resultset="1">
  </CFSTOREDPROC>
  
  <cfif quser.recordcount eq 1>
 
  
		  <cfset This.user_id = "#quser.id#">
		  <cfset This.name = "#quser.username#">
          <cfset This.role = "#quser.groupname#">
          <cfset This.org = "#quser.organization#">
	
	<cfelse>
			<cflocation url = "../signin.cfm?inVlogin" addtoken="no">
	<cfabort>
	</cfif>
	
						
	<cfreturn quser>
		 
</cffunction>
	<cffunction name="user_lookup" access="public" returnType="struct" output="false"
				hint="Returns a user.">
		<cfargument name="username" type="string" required="true">
		<cfset var qGetUser = "">
		<cfset var user = structNew()>
		
		<cfquery name="qGetUser" datasource="#connection.datasource#">		
		select id, username, password, email
		from tbl_staff
		where username = <cfqueryparam value="#arguments.username#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
		</cfquery>
	
		<cfif qGetUser.recordcount eq 1>
		<cfset user.emailaddress = #qGetUser.email#>
		<cfset user.username = #qGetUser.username#>
		<cfset user.password = #qGetUser.password#>
		<cfelse>
		<cfset user.emailaddress = ''>
		<cfset user.username = ''>
		<cfset user.password = ''>
		</cfif>
		<cfreturn user>
			
	</cffunction>

</cfcomponent>