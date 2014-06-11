<cffunction name="QueryToArray" access="public" returntype="array" output="false"
    hint="This turns a query into an array of structures.">
 
    <!--- Define arguments. --->
    <cfargument name="Data" type="query" required="yes" />
 
    <cfscript>
 
        // Define the local scope.
        var LOCAL = StructNew();
 
        // Get the column names as an array.
        LOCAL.Columns = ListToArray( ARGUMENTS.Data.ColumnList );
 
        // Create an array that will hold the query equivalent.
        LOCAL.QueryArray = ArrayNew( 1 );
 
        // Loop over the query.
        for (LOCAL.RowIndex = 1 ; LOCAL.RowIndex LTE ARGUMENTS.Data.RecordCount ; LOCAL.RowIndex = (LOCAL.RowIndex + 1)){
 
            // Create a row structure.
            LOCAL.Row = StructNew();
 
            // Loop over the columns in this row.
            for (LOCAL.ColumnIndex = 1 ; LOCAL.ColumnIndex LTE ArrayLen( LOCAL.Columns ) ; LOCAL.ColumnIndex = (LOCAL.ColumnIndex + 1)){
 
                // Get a reference to the query column.
                LOCAL.ColumnName = LOCAL.Columns[ LOCAL.ColumnIndex ];
 
                // Store the query cell value into the struct by key.
                LOCAL.Row[ LOCAL.ColumnName ] = ARGUMENTS.Data[ LOCAL.ColumnName ][ LOCAL.RowIndex ];
 
            }
 
            // Add the structure to the query array.
            ArrayAppend( LOCAL.QueryArray, LOCAL.Row );
 
        }
 
        // Return the array equivalent.
        return( LOCAL.QueryArray );
 
    </cfscript>
</cffunction>
<cffunction name="GetSites" access="remote" output="false" returntype="any" returnformat="json">
  
   <cfquery name="local.qrySites" datasource="azahec">
  SELECT S.ID, S.Status, S.SiteName, S.ContactPerson, SP.OfficePhone, SP.AlternatePhone, S.SiteEmail, S.Website, SA.Address1, SA.Address2, SA.City, SA.County, SA.State, SA.Country, SA.ZIP, S.GeocodeLink,S.Center, ST.SiteType, S.Notes, S.CreatedBy, S.DateCreated, S.LastEditedBy, S.DateUpdated
FROM Sites S  
LEFT JOIN dbo.Phones SP ON SP.TypeID = S.ID AND SP.PhoneType = 'Site'
LEFT JOIN dbo.Addresses SA ON SA.TypeID = S.ID AND SA.AddressType = 'Site'
LEFT JOIN dbo.SiteTypes ST ON ST.ID = S.SiteType
  </cfquery>
 
  <cfscript>
  strData = StructNew();
  strData['aaData'] = QueryToArray(qrySites);
  return strData;
  </cfscript>


</cffunction>
