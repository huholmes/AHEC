<cfcomponent>
<cffunction name="getWebPath" access="public" output="false" returntype="string" hint="Gets the absolute path to the current web folder."> 
    <cfargument name="url" required="false" default="#getPageContext().getRequest().getRequestURI()#" hint="Defaults to the current path_info" /> 
    <cfargument name="ext" required="false" default="\.(cfml?.*|html?.*|[^.]+)" hint="Define the regex to find the extension. The default will work in most cases, unless you have really funky urls like: /folder/file.cfm/extra.path/info" /> 
    <!---// trim the path to be safe //---> 
    <cfset var sPath = trim(arguments.url) /> 
    <!---// find the where the filename starts (should be the last wherever the last period (".") is) //---> 
    <cfset var sEndDir = reFind("/[^/]+#arguments.ext#$", sPath) /> 
    <cfreturn left(sPath, sEndDir) /> 
</cffunction>
</cfcomponent>