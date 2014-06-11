

<cfinclude template="../../connection/connection.cfc">
<cfoutput>#checkuser()#</cfoutput>
<!--Check if User has been authenticated-->
<!--Check if User want to log off-->
<cfif StructKeyExists(url,'logoff')>
	<cfset StructClear(Session)>
    <cflocation url="../../signin.cfm" addtoken="NO" >
</cfif>
<!--Set up Page Variables for Header include-->
	<cfset This.PageName = 'View Field Experience Site'>
    <cfset This.Icon = 'fa fa-plus'>
    
    <cfset This.CurrentLevel = '2'>
    <cfset This.HostName = '#cgi.script_name#'>
    <cfset This.ActiveFolder = 'hp'>
    <cfset This.ActiveSubFolder = 'hpSites'>

<!--Database Calls-->
    <cfquery name="rSiteTypes" datasource="#datasource2#">
        SELECT * FROM SiteTypes ORDER BY ID ASC
    </cfquery>
    
    <cfquery name="rPartners" datasource="#datasource2#">
        SELECT * FROM Partners ORDER BY ID ASC
    </cfquery>
    
    <cfquery name="rPopulations" datasource="#datasource2#">
        SELECT * FROM Populations ORDER BY ID ASC
    </cfquery>                                          

    <cfquery name="rCities" datasource="#datasource2#">
        SELECT * FROM Cities ORDER BY ID ASC
    </cfquery>  
    
<!--Fetch Record-->

<cfif StructKeyExists(url,'id')>
      <cfset Session.SiteID="#url.id#"> 
<cfelse>
	<cfif StructKeyExists(Session,'SiteID') and #Session.SiteID# NEQ ''> 
<cfelse>
	<cfset Session.SiteID="1">    	   
</cfif>   	   
</cfif>
  <!--Database Call for Viewing Site/ After Session Site ID has been set-->

      <cfstoredproc procedure="dbo.viewSitePartners" datasource="#datasource2#">
        <cfprocparam type="IN" dbvarname="@SiteID" value="#Session.SiteID#" cfsqltype="CF_SQL_CHAR">
        
        <cfprocresult name="viewSitePartners">
      </cfstoredproc>
      
      <cfstoredproc procedure="dbo.viewSitePopulations" datasource="#datasource2#">
        <cfprocparam type="IN" dbvarname="@SiteID" value="#Session.SiteID#" cfsqltype="CF_SQL_CHAR">
        
        <cfprocresult name="viewSitePopulations">
      </cfstoredproc>      
    <cfquery  name="viewSite" datasource="#datasource2#">
    SELECT S.ID, S.Status, S.SiteName, S.ContactPerson, SP.OfficePhone, SP.AlternatePhone, S.SiteEmail, S.Website, SA.Address1, SA.Address2, SA.City, 			SA.County, SA.State, SA.Country, SA.ZIP, S.GeocodeLink,S.Center, S.SiteType, ST.SiteType as SITETYPENAME, S.Notes, S.CreatedBy, S.DateCreated, S.LastEditedBy, S.DateUpdated
FROM Sites S  
LEFT JOIN dbo.Phones SP ON SP.TypeID = S.ID
LEFT JOIN dbo.Addresses SA ON SA.TypeID = S.ID
LEFT JOIN dbo.SiteTypes ST ON ST.ID = S.SiteType
Where S.ID = '#Session.SiteID#'

    </cfquery>   
    <cfquery name="rExcludePartners" datasource="#datasource2#">
        SELECT P.ID, P.Partner FROM Partners P 
        EXCEPT
        (SELECT P.ID, P.Partner
		FROM Partners P  
		LEFT JOIN dbo.SitesPartners SP ON P.ID= SP.PartnerID
		Where SP.SiteID = '#Session.SiteID#')
    </cfquery>

<cfquery name="rExcludePopulations" datasource="#datasource2#">
        SELECT P.Population, P.ID FROM Populations P 
        EXCEPT
        (SELECT P.Population, P.ID
		FROM SitesPopulations SP  
		LEFT JOIN dbo.Populations P ON P.ID= SP.PopulationID
		Where SP.SiteID = '#Session.SiteID#')
    </cfquery>
<!--set default mode/failsafe-->    
<cfset Session.SiteMode="v"> 
<cfset title = 'View Field Experience Site'>
<!--check if mode has been changed to edit-->
<cfif StructKeyExists(url,'m') and #url.m# eq "e">
  <cfset Session.SiteMode="e"> 
</cfif>
<!--set page variables incase mode was changed-->  
<cfswitch expression='#Session.SiteMode#'>
        <cfcase value="v">
                <cfset mode='View'>
                <cfset title='View Field Experience Site'>
        </cfcase>
        <cfcase value="e">
                <cfset mode='Edit'>
                <cfset title='Edit Field Experience Site'>
        </cfcase>
        <cfdefaultcase>
                <cfset mode='View'>
                <cfset title='View Field Experience Site'>
        </cfdefaultcase>
    </cfswitch>
<!--update record on validation-->
<cfif IsDefined("FORM.editSiteHDN") AND FORM.editSiteHDN EQ "True">

    <cfquery name="getCenter" datasource="#datasource2#">
		SELECT C.id as centerid
        FROM dbo.Centers C 
		LEFT JOIN Cities CT ON CT.regionalcenter = C.center_abbrev
        WHERE CT.City='#Form.City#'
    </cfquery>   
    
   <cfquery datasource="#datasource2#">   
    UPDATE dbo.Sites
SET status=<cfif IsDefined("FORM.status") AND #FORM.status# NEQ "">
<cfqueryparam value="#FORM.status#" cfsqltype="cf_sql_numeric">
<cfelse>
NULL
</cfif>
, SiteName=<cfif IsDefined("FORM.SiteName") AND #FORM.SiteName# NEQ "">
<cfqueryparam value="#FORM.SiteName#" cfsqltype="cf_sql_clob" maxlength="250">
<cfelse>
''
</cfif>
, ContactPerson=<cfif IsDefined("FORM.ContactPerson") AND #FORM.ContactPerson# NEQ "">
<cfqueryparam value="#FORM.ContactPerson#" cfsqltype="cf_sql_clob" maxlength="250">
<cfelse>
''
</cfif>
, SiteEmail=<cfif IsDefined("FORM.SiteEmail") AND #FORM.SiteEmail# NEQ "">
<cfqueryparam value="#FORM.SiteEmail#" cfsqltype="cf_sql_clob" maxlength="50">
<cfelse>
''
</cfif>
, Website=<cfif IsDefined("FORM.Website") AND #FORM.Website# NEQ "">
<cfqueryparam value="#FORM.Website#" cfsqltype="cf_sql_clob" maxlength="250">
<cfelse>
''
</cfif>
, GeocodeLink=<cfif IsDefined("FORM.GeocodeLink") AND #FORM.GeocodeLink# NEQ "">
<cfqueryparam value="#FORM.GeocodeLink#" cfsqltype="cf_sql_clob" maxlength="50">
<cfelse>
''
</cfif>
, Center='#getCenter.centerid#'
, SiteType=<cfif IsDefined("FORM.SiteType") AND #FORM.SiteType# NEQ "">
<cfqueryparam value="#FORM.SiteType#" cfsqltype="cf_sql_numeric">
<cfelse>
NULL
</cfif>
, FedPcHPSA=<cfif IsDefined("FORM.FedPcHPSA") AND #FORM.FedPcHPSA# NEQ "">
<cfqueryparam value="#FORM.FedPcHPSA#" cfsqltype="cf_sql_clob" maxlength="50">
<cfelse>
''
</cfif>
, FedMentHPSA=<cfif IsDefined("FORM.FedMentHPSA") AND #FORM.FedMentHPSA# NEQ "">
<cfqueryparam value="#FORM.FedMentHPSA#" cfsqltype="cf_sql_clob" maxlength="50">
<cfelse>
''
</cfif>
, FedDentHPSA=<cfif IsDefined("FORM.FedDentHPSA") AND #FORM.FedDentHPSA# NEQ "">
<cfqueryparam value="#FORM.FedDentHPSA#" cfsqltype="cf_sql_clob" maxlength="50">
<cfelse>
''
</cfif>
, FedMUA=<cfif IsDefined("FORM.FedMUA") AND #FORM.FedMUA# NEQ "">
<cfqueryparam value="#FORM.FedMUA#" cfsqltype="cf_sql_clob" maxlength="50">
<cfelse>
''
</cfif>
, FedRural=<cfif IsDefined("FORM.FedRural") AND #FORM.FedRural# NEQ "">
<cfqueryparam value="#FORM.FedRural#" cfsqltype="cf_sql_clob" maxlength="50">
<cfelse>
''
</cfif>
, AzMUA=<cfif IsDefined("FORM.AzMUA") AND #FORM.AzMUA# NEQ "">
<cfqueryparam value="#FORM.AzMUA#" cfsqltype="cf_sql_clob" maxlength="50">
<cfelse>
''
</cfif>
, AzRural=<cfif IsDefined("FORM.AzRural") AND #FORM.AzRural# NEQ "">
<cfqueryparam value="#FORM.AzRural#" cfsqltype="cf_sql_clob" maxlength="50">
<cfelse>
''
</cfif>
, PCoffer=<cfif IsDefined("FORM.PCoffer") AND #FORM.PCoffer# NEQ "">
<cfqueryparam value="#FORM.PCoffer#" cfsqltype="cf_sql_clob" maxlength="50">
<cfelse>
''
</cfif>
, Notes=<cfif IsDefined("FORM.Notes") AND #FORM.Notes# NEQ "">
<cfqueryparam value="#FORM.Notes#" cfsqltype="cf_sql_clob" maxlength="4000">
<cfelse>
''
</cfif>
,LastEditedBy='#Session.UserID#'
,DateUpdated=DEFAULT
, FedPcHPSA_DV=<cfif IsDefined("FORM.FedPcHPSA_DV") AND #FORM.FedPcHPSA_DV# NEQ "">
<cfqueryparam value="#FORM.FedPcHPSA_DV#" cfsqltype="cf_sql_timestamp">
<cfelse>
NULL
</cfif>
, FedMentHPSA_DV=<cfif IsDefined("FORM.FedMentHPSA_DV") AND #FORM.FedMentHPSA_DV# NEQ "">
<cfqueryparam value="#FORM.FedMentHPSA_DV#" cfsqltype="cf_sql_timestamp">
<cfelse>
NULL
</cfif>
, FedDentHPSA_DV=<cfif IsDefined("FORM.FedDentHPSA_DV") AND #FORM.FedDentHPSA_DV# NEQ "">
<cfqueryparam value="#FORM.FedDentHPSA_DV#" cfsqltype="cf_sql_timestamp">
<cfelse>
NULL
</cfif>
, FedMUA_DV=<cfif IsDefined("FORM.FedMUA_DV") AND #FORM.FedMUA_DV# NEQ "">
<cfqueryparam value="#FORM.FedMUA_DV#" cfsqltype="cf_sql_timestamp">
<cfelse>
NULL
</cfif>
, FedRural_DV=<cfif IsDefined("FORM.FedRural_DV") AND #FORM.FedRural_DV# NEQ "">
<cfqueryparam value="#FORM.FedRural_DV#" cfsqltype="cf_sql_timestamp">
<cfelse>
NULL
</cfif>
, PCoffer_DV=<cfif IsDefined("FORM.PCoffer_DV") AND #FORM.PCoffer_DV# NEQ "">
<cfqueryparam value="#FORM.PCoffer_DV#" cfsqltype="cf_sql_timestamp">
<cfelse>
NULL
</cfif>
WHERE ID='#Session.SiteID#'
  </cfquery>
<!--Remove Partners--> 
        <cfquery datasource="#datasource2#">   
            DELETE FROM dbo.SitesPartners WHERE SiteID='#Session.SiteID#'
        </cfquery> 
<!--Remove Populations Partners-->        
        <cfquery datasource="#datasource2#">   
            DELETE FROM dbo.SitesPopulations WHERE SiteID='#Session.SiteID#'
        </cfquery>         
<!--Add Partners-->
    <cfloop index="Partner" list="#FORM.SitePartners#" delimiters=",">
        <cfquery datasource="#datasource2#">   
            INSERT INTO dbo.SitesPartners (SiteID,PartnerID)
        VALUES (#Session.SiteID#, #Partner#)
        </cfquery> 
     </cfloop> 
 <!--Add Populations-->
    <cfloop index="Populations" list="#FORM.SitePopulations#" delimiters=",">
        <cfquery datasource="#datasource2#">   
            INSERT INTO dbo.SitesPopulations (SiteID,PopulationID)
        VALUES (#Session.SiteID#, #Populations#)
        </cfquery> 
     </cfloop>  
 <!--Update Phone-->
<cfquery datasource="#datasource2#">   
    UPDATE dbo.Phones
SET OfficePhone=<cfif IsDefined("FORM.OfficePhone") AND #FORM.OfficePhone# NEQ "">
<cfqueryparam value="#FORM.OfficePhone#" cfsqltype="cf_sql_numeric">
<cfelse>
NULL
</cfif>,
AlternatePhone=<cfif IsDefined("FORM.AlternatePhone") AND #FORM.AlternatePhone# NEQ "">
<cfqueryparam value="#FORM.AlternatePhone#" cfsqltype="cf_sql_numeric">
<cfelse>
NULL
</cfif>
WHERE PhoneType='Site' AND TypeID='#Session.SiteID#'

</cfquery>
      <cfset Session.SiteRecordEdit="Yes">
      <cfset Session.SiteMode="V">
      <cflocation url = "?id=#Session.SiteID#" addtoken="no">
</cfif>

<!--Open Navigation-->

<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0">
  <meta name="description" content="">
  <meta name="author" content="Ashar Babar Concepts">
  <link rel="shortcut icon" href="../../images/favicon.ico" type="image/png">

  <title>AZAHEC Admin - View Trainee</title>

  <link href="/css/style.default.css" rel="stylesheet">
  <link href="/css/morris.css" rel="stylesheet">
  <link href="/css/jquery.datatables.css" rel="stylesheet">
  <link href="/css/jquery.gritter.css" rel="stylesheet">
  <link id="fontswitch" rel="stylesheet" href="/css/font.helvetica-neue.css">
  <link rel="stylesheet" type="text/css" href="http://redbar.arizona.edu/sites/default/files/ua-banner/ua-web-branding/css/ua-web-branding.css">	
  <!-- HTML5 shim and Respond.js IE8 support of HTML5 elements and media queries -->
  <!--[if lt IE 9]>
  <script src="js/html5shiv.js"></script>
  <script src="js/respond.min.js"></script>
  <![endif]-->
	
</head>

<body>

<!-- Preloader -->
<div id="preloader">
    <div id="status"><i class="fa fa-spinner fa-spin"></i></div>
</div>
<!--UA Web Banner -->
<div id="ua-web-branding-banner-v1" class="ua-wrapper bgLight dark-gray-grad twenty-five">
  <a class="ua-home asdf" href="http://arizona.edu" title="The University of Arizona">
    <p>The University of Arizona</p>
  </a>
</div>
<section>
  
    <!-- leftpanel -->
  	<cfinclude template="../../includes/leftpanel.cfm">
  <!-- leftpanel -->
  
  <!-- mainpanel start -->
  <div class="mainpanel">
    
	  <!-- header -->
  		<cfinclude template="../../includes/header.cfm">
  	  <!-- header -->
    
        <!-- content dynamic -->
<div class="contentpanel">

      <div class="row">
        <div class="col-sm-3">
        <div id="gmap-marker" class="thumbnail img-responsive" style="height: 240px;"></div>
<div class="infosummary">
  
        <ul>
            <li>
                <div class="datainfo">
                    <span class="text-muted">Total Trainees</span>
                    <h4>0</h4>
                </div>
                <div id="trainee-chart" class="chart"><canvas width="59" height="30" style="display: inline-block; width: 59px; height: 30px; vertical-align: top;"></canvas></div>   
            </li>
            <li>
                <div class="datainfo">
                    <span class="text-muted">Total Preceptors</span>
                    <h4>0</h4>
                </div>
                <div id="preceptor-chart" class="chart"><canvas width="59" height="30" style="display: inline-block; width: 59px; height: 30px; vertical-align: top;"></canvas></div>   
            </li>
            <li>
                <div class="datainfo">
                    <span class="text-muted">Total Experiences</span>
                    <h4>0</h4>
                </div>
                <div id="experience-chart" class="chart"><canvas width="59" height="30" style="display: inline-block; width: 59px; height: 30px; vertical-align: top;"></canvas></div>   
            </li>
        </ul>
      </div>

			<h5 class="subtitle">Contact Site</h5>
            	<abbr title="Phone">P:</abbr><br />    
<ul class="profile-social-list">
            <li><i class="fa fa-envelope-square"></i> <a href="">Email Address</a></li>
            <li><i class="fa fa-desktop"></i> <a href="">Website</a></li>
          </ul>                
          <div class="mb30"></div>
          
        </div><!-- col-sm-3 -->
        <div class="col-sm-9">
          <div class="profile-header">
                    <h2 class="profile-name"><cfoutput>#viewSite.SiteName#</cfoutput></h2>
					<p><i class="fa fa-tags"></i> Site ID: <strong><cfoutput>#viewSite.ID#</cfoutput></strong></p>
                    <p><i class="fa fa-pencil-square-o"></i> Last Edited: <strong><cfoutput>#viewSite.LastEditedBy#</cfoutput> on <cfoutput>#viewSite.DateUpdated#</cfoutput></strong></p>
                    <div class="mb5"></div>
							<div class="btn-group mr10">
                                <a href="?m=e&id=<cfoutput>#Session.SiteID#</cfoutput>" class="btn btn-primary"><i class="fa fa-pencil"></i> Edit Site</a>
                                <button class="btn btn-danger" type="button"><i class="fa fa-trash-o mr5"></i> Delete</button>
                            </div>  
							<div class="btn-group">
                                <button data-toggle="dropdown" class="btn btn-default dropdown-toggle" type="button">
                                    <i class="fa fa-plus mr5"></i> Add
                                    <span class="caret"></span>
                                </button>
                                <ul class="dropdown-menu">
                                    <li><a href="#">Add Trainee Experience at this Site</a></li>
                                </ul>
                            </div> 
							<div class="btn-group">
                                <button data-toggle="dropdown" class="btn btn-success dropdown-toggle" type="button">
                                    <i class="fa fa-arrow-circle-o-down mr5"></i> Export
                                    <span class="caret"></span>
                                </button>
                                <ul class="dropdown-menu">
                                    <li><a href="#">PDF</a></li>
                                    <li><a href="#">Print</a></li>
                                </ul>
                            </div>                                                             
                  </div>
          <!-- profile-header -->
          
          <!-- Nav tabs -->
        <ul class="nav nav-tabs nav-justified nav-profile">
          <li class="active"><a href="#snapshot" data-toggle="tab"><strong>Snapshot</strong></a></li>
          <li><a href="#profile" data-toggle="tab"><strong>Details</strong></a></li>
          <li><a href="#rotations" data-toggle="tab"><strong>Experiences</strong></a></li>
          <li><a href="#degrees" data-toggle="tab"><strong>Contacts</strong></a></li>
          <li><a href="#map" data-toggle="tab"><strong>Map</strong></a></li>
        </ul>
        
        <!-- Tab panes -->
        <div class="tab-content">
          <div class="tab-pane active" id="snapshot">
<div class="row">
            <div class="col-md-6">
              <h5 class="subtitle">Trainee Level</h5>
              <p>Showing the typical trainee distribution at this site in terms of gender</p>
              <div id="donut-chart" style="height: 200px;"></div>
            </div>
            <div class="col-md-6">
              <h5 class="subtitle">Preceptor Preferance</h5>
              <p>Showing the most popular preceptor at this field experience site </p>
              <div id="donut-chart2" style="height: 200px;"></div>
            </div>
          </div>
          </div>
          <div class="tab-pane" id="profile">
            <!-- activity-list -->
<!-- form goes here -->
<form class="form-horizontal form-bordered" id="addSite" method="Post">
      
      <div class="panel panel-default">
        <div class="panel-heading">
          <h4 class="panel-title"><cfoutput>#title#</cfoutput></h4>
        </div>
		
        <div class="panel-body panel-body-nopadding">
          <div class="form-group">
              <div class="reqd">
                <label class="col-sm-2 control-label">Status <span class="asterisk">*</span></label>
                <div class="col-sm-4">
                <cfswitch expression='#mode#'>
        		<cfcase value="Edit">
                  <div class="rdio rdio-primary">
                    <input type="radio" name="status" value="1" id="statusActive" checked="checked">
                    <label for="statusActive">Active</label>
                  </div>
                  <div class="rdio rdio-primary">
                    <input type="radio" name="status" value="0" id="statusInActive" disabled>
                    <label for="statusInActive">Inactive</label>
                  </div>
              	</cfcase>
                <cfcase value="View">
                	<cfswitch expression='#viewSite.Status#'>
                    	<cfcase value="0">
                		<label class="text-primary alignleft">Inactive</label>
                        </cfcase>
                    	<cfcase value="1">
                		<label class="text-primary alignleft">Active</label>
                        </cfcase>
                   </cfswitch>                        
                </cfcase>
            </cfswitch>                
                
                </div>
              </div>
          </div>
          <div class="form-group">
              <div class="reqd">
                <label class="col-sm-2 control-label">Site Name <span class="asterisk">*</span></label>
                <div class="col-sm-4">
                <cfswitch expression='#mode#'>
        		<cfcase value="Edit">                
                  <input type="text" placeholder="Enter Site Name" class="form-control" name="SiteName" value="<cfoutput>#viewSite.SiteName#</cfoutput>" required>
              	</cfcase>
                <cfcase value="View">
                <label class="text-primary alignleft"><cfoutput>#viewSite.SiteName#</cfoutput></label>
                </cfcase>
            </cfswitch>                
                
                </div>
              </div>
          </div>

        </div>        
      </div>  

      <div class="panel panel-default">
        <div class="panel-heading">
          <h4 class="panel-title">Contact Information</h4>
        </div>
		
        <div class="panel-body panel-body-nopadding">
          <div class="form-group">
            <label class="col-sm-2 control-label">Contact Person</label>
            <div class="col-sm-4">
                <cfswitch expression='#mode#'>
        		<cfcase value="Edit">             
              <input type="text" placeholder="Enter Contact Person" class="form-control" name="ContactPerson" value="<cfoutput>#viewSite.ContactPerson#</cfoutput>">
              	</cfcase>
                <cfcase value="View">
                <label class="text-primary alignleft"><cfoutput>#viewSite.ContactPerson#</cfoutput></label>
                </cfcase>
            </cfswitch>             
            </div>
          </div>
          <div class="form-group">
          <div class="reqd">
              <label class="col-sm-2 control-label">Office Phone <span class="asterisk">*</span></label>
                <div class="col-sm-4">
                <cfswitch expression='#mode#'>
        		<cfcase value="Edit">                      
                  <div class="input-group"> <span class="input-group-addon"><i class="glyphicon glyphicon-earphone"></i></span>
                    <input type="text" placeholder="Office Number" id="OfficePhone" name="OfficePhone" class="form-control" value="<cfoutput>#viewSite.OfficePhone#</cfoutput>" required>
                  </div>
                  <label class="error" for="OfficePhone"></label>
				</cfcase>
                <cfcase value="View">
                <label class="text-primary alignleft"><cfoutput>#viewSite.OfficePhone#</cfoutput></label>
                </cfcase>
            </cfswitch>  
            </div>               
          </div>
            <label class="col-sm-2 control-label">Alternate Phone</label>
            <div class="col-sm-4">
                <cfswitch expression='#mode#'>
        		<cfcase value="Edit">               
              <div class="input-group"> <span class="input-group-addon"><i class="glyphicon glyphicon-earphone"></i></span>
                <input type="text" placeholder="Alternate Number" id="AlternatePhone" name="AlternatePhone" class="form-control" value="<cfoutput>#viewSite.AlternatePhone#</cfoutput>">
              </div>
				</cfcase>
                <cfcase value="View">
                <label class="text-primary alignleft"><cfoutput>#viewSite.AlternatePhone#</cfoutput></label>
                </cfcase>
            </cfswitch>                             
            </div>
          </div>
		<div class="form-group">
            <label class="col-sm-2 control-label">Site Email</label>
            <div class="col-sm-4">
                <cfswitch expression='#mode#'>
        		<cfcase value="Edit">             
              <div class="input-group"> <span class="input-group-addon"><i class="glyphicon glyphicon-envelope"></i></span>
                <input type="text" placeholder="Office Email" id="SiteEmail" name="SiteEmail" class="form-control" value="<cfoutput>#viewSite.SiteEmail#</cfoutput>">
              </div>
				</cfcase>
                <cfcase value="View">
                <label class="text-primary alignleft"><cfoutput>#viewSite.SiteEmail#</cfoutput></label>
                </cfcase>
            </cfswitch>               
            </div>
            <div class="reqd">
            <label class="col-sm-2 control-label">Site Website </label>
            <div class="col-sm-4">
                <cfswitch expression='#mode#'>
        		<cfcase value="Edit">               
              <div class="input-group"> <span class="input-group-addon"><i class="glyphicon glyphicon-globe"></i></span>
                <input type="text" placeholder="Site Website Address" id="Website" name="Website" class="form-control" value="<cfoutput>#viewSite.Website#</cfoutput>">
              </div> 
              <span class="help-block">* Leave blank if No Website Avaliable</span>
				</cfcase>
                <cfcase value="View">
                <label class="text-primary alignleft"><cfoutput>#viewSite.Website#</cfoutput></label>
                </cfcase>
            </cfswitch>        
            </div>
          </div>  
          </div>          
		
                  
        </div>
        <!-- panel-body --> 
        
      </div>
      <div class="panel panel-default">
                          <div class="panel-heading panel-heading">
                            <h4 class="panel-title">Site Address</h4>
                          </div>
                          <div class="panel-body  panel-body-nopadding"> 
                <cfswitch expression='#mode#'>
        		<cfcase value="Edit">                             
                            <div class="form-group">
                            <div class="reqd">
                              <label class="col-sm-2 control-label">Street Address 1 <span class="asterisk">*</span></label>
                              <div class="col-sm-4">
                                <input type="text" placeholder="Street Address 1" class="form-control"  name="Address1" value="<cfoutput>#viewSite.Address1#</cfoutput>" required>
                              </div>
                              </div>
                              <label class="col-sm-2 control-label">Street Address 2</label>
                              <div class="col-sm-4">
                                <input type="text" placeholder="Street Address 2" class="form-control"  name="Address2" value="<cfoutput>#viewSite.Address2#</cfoutput>">
                              </div>
                            </div>
                            <div class="form-group">
                            <div class="reqd">
                              <label class="col-sm-2 control-label">City <span class="asterisk">*</span></label>
                              <div class="col-sm-4">
                                  <select class="form-control" data-placeholder="Choose a City..." name="City" required>
                                      <option value="#viewSite.City#"><cfoutput>#viewSite.City#</cfoutput></option>
                                    <cfoutput query="rCities">
                                       <option value="#City#">#City#</option>
                                    </cfoutput>
                                  </select>                                
                              </div>
                             </div> 
                              <label class="col-sm-2 control-label">County </label>
                              <div class="col-sm-4">
                                <input type="text" placeholder="County" class="form-control"  name="County" value="<cfoutput>#viewSite.OfficePhone#</cfoutput>">
                              </div>
                            </div>
                            <div class="form-group">
                              <label class="col-sm-2 control-label">State <span class="asterisk">*</span></label>
                              <div class="col-sm-4">
                                <select class="form-control" name="state" id="state" required>
                                  <option value="AZ">Arizona</option>
                                </select>
                              </div>
                              
                              <label class="col-sm-2 control-label">Country/Zip <span class="asterisk">*</span></label>
                              <div class="col-sm-3">
                                <input type="text" placeholder="Country" class="form-control" value="United States of America"  name="Country" value="<cfoutput>#viewSite.Country#</cfoutput>">
                              </div>

                              <div class="col-sm-1 reqd">
                                <input type="text" placeholder="Zip Code" class="form-control"  name="Zip" value="<cfoutput>#viewSite.ZIP#</cfoutput>" required>
                              </div>
                            </div>
                            
                        <div class="form-group">
                            <label class="col-sm-2 control-label">GeoCode Tag</label>
                            <div class="col-sm-4">
                              <div class="input-group"> <span class="input-group-addon"><i class="glyphicon glyphicon-map-marker"></i></span>
                                <input type="text" placeholder="Geo Code" id="GeoCodeLink" name="GeoCodeLink" data-toggle="modal" data-target=".bs-example-modal-lg" class="form-control" onClick="google.maps.event.trigger(map, 'resize');" value="<cfoutput>#viewSite.GeoCodeLink#</cfoutput>">
                              </div>
                            </div>
                          
                          </div> 
				</cfcase>
                <cfcase value="View">
					<div class="form-group">
                            <label class="col-sm-2 control-label">Address</label>
                            <div class="col-sm-4">
								<label class="text-primary alignleft"><cfoutput>#viewSite.Address1#</cfoutput></label><br >
                                <cfif #viewSite.Address2# NEQ '' OR #viewSite.Address2# NEQ 'Null'>
                                <label class="text-primary alignleft"><cfoutput>#viewSite.Address2#</cfoutput></label><br >
                                </cfif>
                                <label class="text-primary alignleft"><cfoutput>#viewSite.City#</cfoutput></label><br >
                                <label class="text-primary alignleft"><cfoutput>#viewSite.State#</cfoutput></label><br >
                                <label class="text-primary alignleft"><cfoutput>#viewSite.Country#</cfoutput></label><br >
                                <label class="text-primary alignleft"><cfoutput>#viewSite.Zip#</cfoutput></label>
                            </div>
                          
                          </div>                
                </cfcase>
            </cfswitch>                                                      
                          </div>
      </div>
      
      <div class="panel panel-default">
        <div class="panel-heading">
          <h4 class="panel-title">Site Characteristics</h4>
        </div>
        <div class="panel-body panel-body-nopadding">
          <div class="form-group">
          <div class="reqd">
            <label class="col-sm-2 control-label">Site Type <span class="asterisk">*</span></label>
            <div class="col-sm-4">
                <cfswitch expression='#mode#'>
        		<cfcase value="Edit">             
              <select class="form-control" data-placeholder="Choose a Site Type..." name="SiteType" value="<cfoutput>#viewSite.OfficePhone#</cfoutput>" required>
                  <option value="<cfoutput>#viewSite.SiteType#</cfoutput>"><cfoutput>#viewSite.SiteTypeName#</cfoutput></option>
                <cfoutput query="rSiteTypes">
                   <option value="#ID#">#SiteType#</option>
                </cfoutput>
              </select>
				</cfcase>
                <cfcase value="View">
                <label class="text-primary alignleft"><cfoutput>#viewSite.SiteTypeName#</cfoutput></label>
                </cfcase>
            </cfswitch>               
            </div>
            </div>
		</div>
          <div class="form-group">  
          <div class="reqd" >      
            <label class="col-sm-2 control-label">Site's Partners/Consortia <span class="asterisk">*</span></label>
            <div class="col-sm-10">
                <cfswitch expression='#mode#'>
        		<cfcase value="Edit">             
              <select class="form-control chosen-select" multiple data-placeholder="Choose Site's Partners/Consortia..." name="SitePartners" required>
                <cfoutput query="viewSitePartners">
                    <option value="#viewSitePartners.ID#" selected>#viewSitePartners.Partner#</option>
                </cfoutput>
                
                <cfoutput query="rExcludePartners">
                    <option value="#ID#">#Partner#</option>
                </cfoutput>
              </select>
              <label class="error" for="SitePartners"></label>
				</cfcase>
                <cfcase value="View">
                	<cfloop query="viewSitePartners">
                    	<cfoutput><label class="text-primary alignleft">#viewSitePartners.ID#. #viewSitePartners.Partner#</label><br /></cfoutput>
                    </cfloop>
                </cfcase>
            </cfswitch>               
            </div>
          </div>
          </div>
          
          <div class="form-group">
          <div class="reqd">
            <label class="col-sm-2 control-label">Vunerable Populations Served <span class="asterisk">*</span></label>
            <div class="col-sm-10">
                <cfswitch expression='#mode#'>
        		<cfcase value="Edit">             
              <select class="form-control chosen-select" multiple data-placeholder="Choose Vunerable Populations Served..." name="SitePopulations" required>
                <cfoutput query="viewSitePopulations">
                    <option value="#viewSitePartners.ID#" selected>#viewSitePopulations.Population#</option>
                </cfoutput>
                
                <cfoutput query="rExcludePopulations">
                    <option value="#ID#">#Population#</option>
                </cfoutput>
                
                
              </select>
              <label class="error" for="SitePopulations"></label>
				</cfcase>
                <cfcase value="View" >
                	<cfloop query="viewSitePopulations">
                    	<cfoutput><label class="text-primary alignleft">#viewSitePopulations.CurrentRow#. #viewSitePopulations.Population#</label><br /></cfoutput>
                    </cfloop>
                </cfcase>
            </cfswitch>               
            </div>
          </div>
           </div>         
        </div>
        <!-- panel-body --> 
        
      </div>
<div class="panel panel-default">
        <div class="panel-heading">
          <h4 class="panel-title">Notes</h4>
        </div>
        <div class="panel-body panel-body-nopadding">
          <div class="form-group">
            <label class="col-sm-2 control-label">Notes </label>
            <div class="col-sm-10">
                <cfswitch expression='#mode#'>
        		<cfcase value="Edit">             
				<textarea class="form-control" name="notes" rows="3"><cfoutput>#viewSite.OfficePhone#</cfoutput></textarea>
				</cfcase>
                <cfcase value="View">
                <label class="text-primary alignleft"><cfoutput>#viewSite.Notes#</cfoutput></label>
                </cfcase>
            </cfswitch>                 
            </div>
		</div>
                    
        </div>
        <!-- panel-body --> 
        
      </div>
<!--Program Office Use Only-->
<div class="panel panel-default">

        <div class="panel-heading">
          <h4 class="panel-title">Program Office Use Only</h4>
          		<div class="panel-btns">
                <a href="" class="minimize">−</a>
		</div>
        </div>

        <div class="panel-body panel-body-nopadding">

		<!-- FedPcHPSA --> 
          <div class="form-group">
            <label class="col-sm-3 control-label">Federal Primary Care HPSA <span class="asterisk">*</span></label>
            <div class="col-sm-3">
              <div class="rdio rdio-primary">
                <input type="radio" name="FedPcHPSA" value="Yes" id="FedPcHPSAYes" disabled>
                <label for="statusActive">Yes</label>
              </div>
              <div class="rdio rdio-primary">
                <input type="radio" name="FedPcHPSA" value="No" id="FedPcHPSANo" checked="checked">
                <label for="statusInActive">No</label>
              </div>
            </div>

            <label class="col-sm-2 control-label">Date Verified</label>
            <div class="col-sm-4">
              <input type="text" placeholder="Verification Date" class="form-control" name="FedPcHPSA_DV" required disabled>
            </div>
          </div>
          <!-- FedMentHPSA --> 
          <div class="form-group">
            <label class="col-sm-3 control-label">Federal Mental Care HPSA <span class="asterisk">*</span></label>
            <div class="col-sm-3">
              <div class="rdio rdio-primary">
                <input type="radio" name="FedMentHPSA" value="Yes" id="FedMentHPSAYes" disabled>
                <label for="statusActive">Yes</label>
              </div>
              <div class="rdio rdio-primary">
                <input type="radio" name="FedMentHPSA" value="No" id="FedMentHPSANo" checked="checked">
                <label for="statusInActive">No</label>
              </div>
            </div>

            <label class="col-sm-2 control-label">Date Verified</label>
            <div class="col-sm-4">
              <input type="text" placeholder="Verification Date" class="form-control" name="FedMentHPSA_DV" required disabled>
            </div>
          </div>          
          <!-- FedDentHPSA --> 
          <div class="form-group">
            <label class="col-sm-3 control-label">Federal Dental Care HPSA <span class="asterisk">*</span></label>
            <div class="col-sm-3">
              <div class="rdio rdio-primary">
                <input type="radio" name="FedDentHPSA" value="Yes" id="FedDentHPSAYes" disabled>
                <label for="statusActive">Yes</label>
              </div>
              <div class="rdio rdio-primary">
                <input type="radio" name="FedDentHPSA" value="No" id="FedDentHPSANo" checked="checked">
                <label for="statusInActive">No</label>
              </div>
            </div>

            <label class="col-sm-2 control-label">Date Verified</label>
            <div class="col-sm-4">
              <input type="text" placeholder="Verification Date" class="form-control" name="FedDentHPSA_DV" required disabled>
            </div>
          </div>           
          <!-- FedMUA --> 
          <div class="form-group">
            <label class="col-sm-3 control-label">Federal MUA/P <span class="asterisk">*</span></label>
            <div class="col-sm-3">
              <div class="rdio rdio-primary">
                <input type="radio" name="FedMUA" value="Yes" id="FedMUAYes"disabled>
                <label for="statusActive">Yes</label>
              </div>
              <div class="rdio rdio-primary">
                <input type="radio" name="FedMUA" value="No" id="FedMUANo" checked="checked">
                <label for="statusInActive">No</label>
              </div>
            </div>

            <label class="col-sm-2 control-label">Date Verified</label>
            <div class="col-sm-4">
              <input type="text" placeholder="Verification Date" class="form-control" name="FedMUA_DV" required disabled> 
            </div>
          </div>           
          <!-- FedRural --> 
          <div class="form-group">
            <label class="col-sm-3 control-label">Federal Rural Designation <span class="asterisk">*</span></label>
            <div class="col-sm-3">
              <div class="rdio rdio-primary">
                <input type="radio" name="FedRural" value="Yes" id="FedRuralYes" disabled>
                <label for="statusActive">Yes</label>
              </div>
              <div class="rdio rdio-primary">
                <input type="radio" name="FedRural" value="No" id="FedRuralNo" checked="checked">
                <label for="statusInActive">No</label>
              </div>
            </div>

            <label class="col-sm-2 control-label">Date Verified</label>
            <div class="col-sm-4">
              <input type="text" placeholder="Verification Date" class="form-control" name="FedRural_DV" required disabled>
            </div>
          </div>           
          <!-- AzMUA -->
          <div class="form-group">
            <label class="col-sm-3 control-label">Arizona MUA <span class="asterisk">*</span></label>
            <div class="col-sm-3">
              <div class="rdio rdio-primary">
                <input type="radio" name="AzMUA" value="Yes" id="AzMUAYes" disabled>
                <label for="statusActive">Yes</label>
              </div>
              <div class="rdio rdio-primary">
                <input type="radio" name="AzMUA" value="No" id="AzMUANo" checked="checked">
                <label for="statusInActive">No</label>
              </div>
            </div>

            <label class="col-sm-2 control-label">Date Verified</label>
            <div class="col-sm-4">
              <input type="text" placeholder="Verification Date" class="form-control" name="SiteName" required disabled>
            </div>
          </div>            
          <!-- AzRural --> 
          <div class="form-group">
            <label class="col-sm-3 control-label">Arizona Rural Designation <span class="asterisk">*</span></label>
            <div class="col-sm-3">
              <div class="rdio rdio-primary">
                <input type="radio" name="AzRural" value="Yes" id="AzRuralYes"  disabled>
                <label for="statusActive">Yes</label>
              </div>
              <div class="rdio rdio-primary">
                <input type="radio" name="AzRural" value="No" id="AzRuralNo" checked="checked">
                <label for="statusInActive">No</label>
              </div>
            </div>

            <label class="col-sm-2 control-label">Date Verified</label>
            <div class="col-sm-4">
              <input type="text" placeholder="Verification Date" class="form-control" name="AzRural_DV" required disabled>
            </div>
          </div>           
          <!-- PCoffer -->
          <div class="form-group">
            <label class="col-sm-3 control-label">Primary Care Offered <span class="asterisk">*</span></label>
            <div class="col-sm-3">
              <div class="rdio rdio-primary">
                <input type="radio" name="PCoffer" value="Yes" id="PCofferYes" disabled>
                <label for="statusActive">Yes</label>
              </div>
              <div class="rdio rdio-primary">
                <input type="radio" name="PCoffer" value="No" id="PCofferNo" checked="checked">
                <label for="statusInActive">No</label>
              </div>
            </div>

            <label class="col-sm-2 control-label">Date Verified</label>
            <div class="col-sm-4">
              <input type="text" placeholder="Verification Date" class="form-control" name="PCoffer_DV" required disabled>
            </div>
          </div> 
            
            
		</div>
                    
      </div>
        <!-- panel-body --> 
      <cfswitch expression='#mode#'>
        		<cfcase value="Edit">        
        <div class="panel-footer">
          <div class="row">
            <div class="col-sm-12 ">
              <input type="hidden" name="editSiteHDN" value="True">
              <button class="btn btn-primary">Save</button>
              &nbsp;
              <button class="btn btn-default">Cancel</button>
            </div>
          </div>
        </div>
              	</cfcase>
                <cfcase value="View">
                
                </cfcase>
            </cfswitch>
      
   	</form>
          </div>

          <div class="tab-pane" id="rotations">
            
            <div class="follower-list">
              
              <div class="media">
                <div class="media-body">
                  <h3 class="follower-name">New Rotation from </h3>
                  <div class="profile-location"><i class="fa fa-map-marker"></i> </div>
                  <div class="profile-position"><i class="fa fa-briefcase"></i> </div>
                  
                  <div class="mb20"></div>
                  
                  <button class="btn btn-sm btn-success mr5"><i class="fa fa-user"></i> Edit Rotation</button>
                </div>
              </div><!-- media -->

              
            </div><!--follower-list -->
            
          </div>
			<div class="tab-pane" id="map">
    			        
	        </div><!-- tab-content -->
          
        </div><!-- col-sm-9 -->
      </div><!-- row -->
      
    </div>
        <!-- content dynamic -->
    
    <!-- contentpanel -->
    
  </div>
  <!-- mainpanel end -->
  </div>
  <!-- rightpanel -->
  
  
</section>

<script src="../../js/jquery-1.10.2.min.js"></script>
<script src="../../js/jquery-migrate-1.2.1.min.js"></script>
<script src="../../js/bootstrap.min.js"></script>
<script src="../../js/modernizr.min.js"></script>
<script src="../../js/jquery.sparkline.min.js"></script>
<script src="../../js/toggles.min.js"></script>
<script src="../../js/retina.min.js"></script>
<script src="../../js/morris.min.js"></script>
<script src="/js/raphael-2.1.0.min.js"></script>
<script src="../../js/jquery.cookies.js"></script>

<script src="../../js/jquery-ui-1.10.3.min.js"></script>
<script src="../../js/chosen.jquery.min.js"></script>

<script src="../../js/jquery.validate.min.js"></script>
<script src="../../js/jquery.maskedinput.min.js"></script>
<script src="../../js/jquery.gritter.min.js"></script>

<script src="https://maps.googleapis.com/maps/api/js?v=3.exp&sensor=false"></script>

<script src="../../js/custom.js"></script>

<script>
// Form validation
jQuery(document).ready(function(){ 

$.validator.setDefaults({ ignore: ":hidden:not(select)"})
  jQuery("#addTrainee").validate({
	  rules: {
		 "FirstName": {
         required: true,
         minlength: 2,
     },
		 "LastName": {
         required: true,
         minlength: 2,
     },
		 "EmailPreferred": {
         required: true,
         email: true,
     } 	 
	 	  
	  },

	messages: {
    "FirstName": {
         required: "This Field is required",
         minlength: "This field must contain at least {0} characters",
     },
    "LastName": {
         required: "This Field is required",
         minlength: "This field must contain at least {0} characters",
     },
    "EmailPreferred": {
         required: "This Field is required",
         email: "This field must contain a valid email",
     }		 	 
}
	
  });
 	  	
});

    function showError(errTitle,errMessage) {

	 return false;
	 };
</script>
<script>
    jQuery(document).ready(function() {
    new Morris.Donut({
        element: 'donut-chart',
        data: [
          {label: "Male", value: 60},
          {label: "Female", value: 40}
        ]
    });
    
    new Morris.Donut({
        element: 'donut-chart2',
        data: [
          {label: "John Doe", value: 33},
          {label: "Jane Doe", value: 45},
          {label: "Wildcat", value: 22}

        ],
        colors: ['#D9534F','#1CAF9A','#428BCA','#5BC0DE','#428BCA']
    });

    jQuery('#trainee-chart').sparkline([66,34], {
		  type: 'pie', 
		  height:'33px',
        sliceColors: ['#F0AD4E','#428BCA'],
tooltipFormat: '{{offset:offset}} ({{percent.1}}%)',
    tooltipValueLookups: {
        'offset': {
            0: 'Past',
            1: 'Current',
        }
    },		
    });

    jQuery('#preceptor-chart').sparkline([0,100], {
		  type: 'pie', 
		  height:'33px',
        sliceColors: ['#D9534F','#1CAF9A'],
    tooltipFormat: '{{offset:offset}} ({{percent.1}}%)',
    tooltipValueLookups: {
        'offset': {
            0: 'Past',
            1: 'Current',
        }
    },		
    });

    jQuery('#experience-chart').sparkline([12,88], {
		  type: 'pie', 
		  height:'33px',
        sliceColors: ['#F0AD4E','#5BC0DE'],
tooltipFormat: '{{offset:offset}} ({{percent.1}}%)',
    tooltipValueLookups: {
        'offset': {
            0: 'Past',
            1: 'Current',
        }
    },			
    });
        
        // Chosen Select
        
});
</script>
<script>
    jQuery(document).ready(function() {
        
        // Chosen Select
        jQuery(".chosen-select").chosen({'width':'100%','white-space':'nowrap'});
        
	
    });
	

</script>
<script>
var geocoder;
var map;

function initialize() {
  var myLatlng = new google.maps.LatLng(<cfoutput>#viewSite.GeoCodeLink#</cfoutput>);
  var mapOptions = {
    zoom: 19,
    center: myLatlng
  }
  var map = new google.maps.Map(document.getElementById('gmap-marker'), mapOptions);
	map.setMapTypeId(google.maps.MapTypeId.SATELLITE);
  var marker = new google.maps.Marker({
      position: myLatlng,
      map: map,
      title: '<cfoutput>#viewSite.SiteName#</cfoutput>'
  });
}

google.maps.event.addDomListener(window, 'load', initialize);
</script>

<cfif IsDefined("Session.SiteRecordEdit") AND #Session.SiteRecordEdit# EQ "Yes">
	<cfset Session.SiteRecordEdit="No">
    <cfoutput>

<script>
    jQuery(document).ready(function() {
	 jQuery.gritter.add({
		title: 'Site Record Updated',
		text: 'Site record <cfoutput>#Session.SiteID#</cfoutput> was successfully updated',
      class_name: 'growl-primary',
      image: '../../images/screen.png',
		sticky: false,
		time: ''
	 });
	 return false;
	 });
	 </script>
     </cfoutput>
     </cfif>

        
</body>
</html>
