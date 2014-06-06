<cfset pageName = listFirst(listLast(CGI.ScriptName, '/'), '?')>
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
	<cfset Session.SiteID="1">    	   
</cfif>
  <!--Database Call for Viewing Site/ After Session Site ID has been set-->
      <cfstoredproc procedure="dbo.viewSite" datasource="#datasource2#">
        <cfprocparam type="IN" dbvarname="@SiteID" value="#Session.SiteID#" cfsqltype="CF_SQL_CHAR">
        
        <cfprocresult name="viewSite" resultset="1">
      </cfstoredproc>

      <cfstoredproc procedure="dbo.viewSitePartners" datasource="#datasource2#">
        <cfprocparam type="IN" dbvarname="@SiteID" value="#Session.SiteID#" cfsqltype="CF_SQL_CHAR">
        
        <cfprocresult name="viewSitePartners">
      </cfstoredproc>
      
      <cfstoredproc procedure="dbo.viewSitePopulations" datasource="#datasource2#">
        <cfprocparam type="IN" dbvarname="@SiteID" value="#Session.SiteID#" cfsqltype="CF_SQL_CHAR">
        
        <cfprocresult name="viewSitePopulations">
      </cfstoredproc>      
       
    <cfquery name="viewDegrees" datasource="#datasource2#">
        SELECT * FROM Degrees where TraineeId ='#Session.SiteID#'
    </cfquery>
    
        <cfquery name="trainees" datasource="#datasource2#">
        SELECT * FROM Trainees
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
<cfif IsDefined("FORM.editSiteHDN") AND FORM.editTraineeHDN EQ "True">
  <cfquery datasource="#datasource2#">   
    UPDATE dbo.Trainees
SET Status=<cfif IsDefined("FORM.Status") AND #FORM.Status# NEQ "">
<cfqueryparam value="#FORM.Status#" cfsqltype="cf_sql_clob" maxlength="50">
<cfelse>
''
</cfif>
, LastName=<cfif IsDefined("FORM.LastName") AND #FORM.LastName# NEQ "">
<cfqueryparam value="#FORM.LastName#" cfsqltype="cf_sql_clob" maxlength="50">
<cfelse>
''
</cfif>
, FirstName=<cfif IsDefined("FORM.FirstName") AND #FORM.FirstName# NEQ "">
<cfqueryparam value="#FORM.FirstName#" cfsqltype="cf_sql_clob" maxlength="50">
<cfelse>
''
</cfif>
, MiddleName=<cfif IsDefined("FORM.MiddleName") AND #FORM.MiddleName# NEQ "">
<cfqueryparam value="#FORM.MiddleName#" cfsqltype="cf_sql_clob" maxlength="50">
<cfelse>
''
</cfif>
, MaidenName=<cfif IsDefined("FORM.MaidenName") AND #FORM.MaidenName# NEQ "">
<cfqueryparam value="#FORM.MaidenName#" cfsqltype="cf_sql_clob" maxlength="50">
<cfelse>
''
</cfif>
, EmailPreferred=<cfif IsDefined("FORM.EmailPreferred") AND #FORM.EmailPreferred# NEQ "">
<cfqueryparam value="#FORM.EmailPreferred#" cfsqltype="cf_sql_clob" maxlength="50">
<cfelse>
''
</cfif>
, EmailUniversity=<cfif IsDefined("FORM.EmailUniversity") AND #FORM.EmailUniversity# NEQ "">
<cfqueryparam value="#FORM.EmailUniversity#" cfsqltype="cf_sql_clob" maxlength="50">
<cfelse>
''
</cfif>
, EmailPermanent=<cfif IsDefined("FORM.EmailPermanent") AND #FORM.EmailPermanent# NEQ "">
<cfqueryparam value="#FORM.EmailPermanent#" cfsqltype="cf_sql_clob" maxlength="50">
<cfelse>
''
</cfif>
, Phone=<cfif IsDefined("FORM.Phone") AND #FORM.Phone# NEQ "">
<cfqueryparam value="#FORM.Phone#" cfsqltype="cf_sql_clob" maxlength="50">
<cfelse>
''
</cfif>
, EmergContactName=<cfif IsDefined("FORM.EmergContactName") AND #FORM.EmergContactName# NEQ "">
<cfqueryparam value="#FORM.EmergContactName#" cfsqltype="cf_sql_clob" maxlength="50">
<cfelse>
''
</cfif>
, EmergContactPhone=<cfif IsDefined("FORM.EmergContactPhone") AND #FORM.EmergContactPhone# NEQ "">
<cfqueryparam value="#FORM.EmergContactPhone#" cfsqltype="cf_sql_clob" maxlength="50">
<cfelse>
''
</cfif>
, InstitutionID=<cfif IsDefined("FORM.Institution") AND #FORM.Institution# NEQ "">
<cfqueryparam value="#FORM.Institution#" cfsqltype="cf_sql_numeric">
<cfelse>
NULL
</cfif>
, InstitutionLevel=<cfif IsDefined("FORM.InstitutionLevel") AND #FORM.InstitutionLevel# NEQ "">
<cfqueryparam value="#FORM.InstitutionLevel#" cfsqltype="cf_sql_clob" maxlength="50">
<cfelse>
''
</cfif>
, DisciplineID=<cfif IsDefined("FORM.Discipline") AND #FORM.Discipline# NEQ "">
<cfqueryparam value="#FORM.Discipline#" cfsqltype="cf_sql_numeric">
<cfelse>
NULL
</cfif>
, Enrollment=<cfif IsDefined("FORM.Enrollment") AND #FORM.Enrollment# NEQ "">
<cfqueryparam value="#FORM.Enrollment#" cfsqltype="cf_sql_clob" maxlength="50">
<cfelse>
''
</cfif>
, DOB=<cfif IsDefined("FORM.DOB") AND #FORM.DOB# NEQ "">
<cfqueryparam value="#FORM.DOB#" cfsqltype="cf_sql_timestamp">
<cfelse>
NULL
</cfif>
, Sex=<cfif IsDefined("FORM.Sex") AND #FORM.Sex# NEQ "">
<cfqueryparam value="#FORM.Sex#" cfsqltype="cf_sql_clob" maxlength="50">
<cfelse>
''
</cfif>
, Ethnicity=<cfif IsDefined("FORM.Ethnicity") AND #FORM.Ethnicity# NEQ "">
<cfqueryparam value="#FORM.Ethnicity#" cfsqltype="cf_sql_clob" maxlength="50">
<cfelse>
''
</cfif>
, Race=<cfif IsDefined("FORM.Race") AND #FORM.Race# NEQ "">
<cfqueryparam value="#FORM.Race#" cfsqltype="cf_sql_clob" maxlength="150">
<cfelse>
''
</cfif>
, RuralBackground=<cfif IsDefined("FORM.RuralBackground") AND #FORM.RuralBackground# NEQ "">
<cfqueryparam value="#FORM.RuralBackground#" cfsqltype="cf_sql_clob" maxlength="50">
<cfelse>
''
</cfif>
, Disadvantaged=<cfif IsDefined("FORM.Disadvantaged") AND #FORM.Disadvantaged# NEQ "">
<cfqueryparam value="#FORM.Disadvantaged#" cfsqltype="cf_sql_clob" maxlength="50">
<cfelse>
''
</cfif>
, AZbackground=<cfif IsDefined("FORM.AZbackground") AND #FORM.AZbackground# NEQ "">
<cfqueryparam value="#FORM.AZbackground#" cfsqltype="cf_sql_clob" maxlength="50">
<cfelse>
''
</cfif>
, MilitaryStatusPre=<cfif IsDefined("FORM.MilitaryStatusPre") AND #FORM.MilitaryStatusPre# NEQ "">
<cfqueryparam value="#FORM.MilitaryStatusPre#" cfsqltype="cf_sql_clob" maxlength="50">
<cfelse>
''
</cfif>
, SpecialHousing=<cfif IsDefined("FORM.SpecialHousing") AND #FORM.SpecialHousing# NEQ "">
<cfqueryparam value="#FORM.SpecialHousing#" cfsqltype="cf_sql_clob" maxlength="50">
<cfelse>
''
</cfif>
, Notes=<cfif IsDefined("FORM.Notes") AND #FORM.Notes# NEQ "">
<cfqueryparam value="#FORM.Notes#" cfsqltype="cf_sql_clob" maxlength="4000">
<cfelse>
''
</cfif>
, LastEditedBy='#SESSION.UserID#', DateUpdated=DEFAULT WHERE ID='#Session.SiteID#'
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
<div id="ua-web-branding-banner-v1" class="ua-wrapper bgDark red-grad">
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
        <div id="gmap-marker" class="thumbnail img-responsive" style="height: 240px; position: relative; overflow: hidden; -webkit-transform: translateZ(0px); background-color: rgb(229, 227, 223);"><div class="gm-style" style="position: absolute; left: 0px; top: 0px; overflow: hidden; width: 100%; height: 100%; z-index: 0;"><div style="position: absolute; left: 0px; top: 0px; overflow: hidden; width: 100%; height: 100%; z-index: 0;"><div style="position: absolute; left: 0px; top: 0px; z-index: 1; width: 100%; cursor: url(http://maps.gstatic.com/mapfiles/openhand_8_8.cur) 8 8, default; -webkit-transform-origin: 10px 84px; -webkit-transform: matrix(1, 0, 0, 1, 0, 0);"><div style="-webkit-transform: translateZ(0px); position: absolute; left: 0px; top: 0px; width: 100%; z-index: 200;"><div style="-webkit-transform: translateZ(0px); position: absolute; left: 0px; top: 0px; z-index: 101; width: 100%;"></div></div><div style="-webkit-transform: translateZ(0px); position: absolute; left: 0px; top: 0px; width: 100%; z-index: 201;"><div style="-webkit-transform: translateZ(0px); position: absolute; left: 0px; top: 0px; z-index: 102; width: 100%;"></div><div style="-webkit-transform: translateZ(0px); position: absolute; left: 0px; top: 0px; z-index: 103; width: 100%;"><div style="position: absolute; left: 0px; top: 0px; z-index: -1;"><div style="position: absolute; left: 0px; top: 0px; z-index: 1;"><div style="width: 256px; height: 256px; overflow: hidden; -webkit-transform: translateZ(0px); position: absolute; left: 31px; top: 69px;"><canvas draggable="false" height="256" width="256" style="-webkit-user-select: none; position: absolute; left: 0px; top: 0px; height: 256px; width: 256px;"></canvas></div><div style="width: 256px; height: 256px; overflow: hidden; -webkit-transform: translateZ(0px); position: absolute; left: -225px; top: 69px;"></div><div style="width: 256px; height: 256px; overflow: hidden; -webkit-transform: translateZ(0px); position: absolute; left: 31px; top: -187px;"></div><div style="width: 256px; height: 256px; overflow: hidden; -webkit-transform: translateZ(0px); position: absolute; left: 31px; top: 325px;"></div><div style="width: 256px; height: 256px; overflow: hidden; -webkit-transform: translateZ(0px); position: absolute; left: 287px; top: 69px;"></div><div style="width: 256px; height: 256px; overflow: hidden; -webkit-transform: translateZ(0px); position: absolute; left: -225px; top: -187px;"></div><div style="width: 256px; height: 256px; overflow: hidden; -webkit-transform: translateZ(0px); position: absolute; left: -225px; top: 325px;"></div><div style="width: 256px; height: 256px; overflow: hidden; -webkit-transform: translateZ(0px); position: absolute; left: 287px; top: -187px;"></div><div style="width: 256px; height: 256px; overflow: hidden; -webkit-transform: translateZ(0px); position: absolute; left: 287px; top: 325px;"></div></div></div></div></div><div style="-webkit-transform: translateZ(0px); position: absolute; left: 0px; top: 0px; width: 100%; z-index: 202;"><div style="-webkit-transform: translateZ(0px); position: absolute; left: 0px; top: 0px; z-index: 104; width: 100%;"></div><div style="-webkit-transform: translateZ(0px); position: absolute; left: 0px; top: 0px; z-index: 105; width: 100%;"></div><div style="-webkit-transform: translateZ(0px); position: absolute; left: 0px; top: 0px; z-index: 106; width: 100%;"></div></div><div style="-webkit-transform: translateZ(0px); position: absolute; left: 0px; top: 0px; z-index: 100; width: 100%;"><div style="position: absolute; left: 0px; top: 0px; z-index: 0;"><div style="position: absolute; left: 0px; top: 0px; z-index: 1;"><div style="width: 256px; height: 256px; -webkit-transform: translateZ(0px); position: absolute; left: 31px; top: 69px;"></div><div style="width: 256px; height: 256px; -webkit-transform: translateZ(0px); position: absolute; left: -225px; top: 69px;"></div><div style="width: 256px; height: 256px; -webkit-transform: translateZ(0px); position: absolute; left: 31px; top: -187px;"></div><div style="width: 256px; height: 256px; -webkit-transform: translateZ(0px); position: absolute; left: 31px; top: 325px;"></div><div style="width: 256px; height: 256px; -webkit-transform: translateZ(0px); position: absolute; left: 287px; top: 69px;"></div><div style="width: 256px; height: 256px; -webkit-transform: translateZ(0px); position: absolute; left: -225px; top: -187px;"></div><div style="width: 256px; height: 256px; -webkit-transform: translateZ(0px); position: absolute; left: -225px; top: 325px;"></div><div style="width: 256px; height: 256px; -webkit-transform: translateZ(0px); position: absolute; left: 287px; top: -187px;"></div><div style="width: 256px; height: 256px; -webkit-transform: translateZ(0px); position: absolute; left: 287px; top: 325px;"></div></div></div></div><div style="position: absolute; z-index: 0; left: 0px; top: 0px;"><div style="overflow: hidden; width: 462px; height: 300px;"><img src="http://maps.googleapis.com/maps/api/js/StaticMapService.GetMapImage?1m2&amp;1i1199585&amp;2i2238395&amp;2e1&amp;3u14&amp;4m2&amp;1u462&amp;2u300&amp;5m4&amp;1e0&amp;5sen-US&amp;6sus&amp;10b1&amp;token=2501" style="width: 462px; height: 300px;"></div></div><div style="position: absolute; left: 0px; top: 0px; z-index: 0;"><div style="position: absolute; left: 0px; top: 0px; z-index: 1;"><div style="width: 256px; height: 256px; -webkit-transform: translateZ(0px); position: absolute; left: 31px; top: 69px; opacity: 1; transition: opacity 200ms ease-out; -webkit-transition: opacity 200ms ease-out;"><img src="http://mt0.googleapis.com/vt?lyrs=m@264039338&amp;src=apiv3&amp;hl=en-US&amp;x=4686&amp;y=8744&amp;z=14&amp;style=47,37%7Csmartmaps" draggable="false" style="width: 256px; height: 256px; -webkit-user-select: none; border: 0px; padding: 0px; margin: 0px; -webkit-transform: translateZ(0px);"></div><div style="width: 256px; height: 256px; -webkit-transform: translateZ(0px); position: absolute; left: -225px; top: 69px; opacity: 1; transition: opacity 200ms ease-out; -webkit-transition: opacity 200ms ease-out;"><img src="http://mt1.googleapis.com/vt?lyrs=m@264032397&amp;src=apiv3&amp;hl=en-US&amp;x=4685&amp;y=8744&amp;z=14&amp;style=47,37%7Csmartmaps" draggable="false" style="width: 256px; height: 256px; -webkit-user-select: none; border: 0px; padding: 0px; margin: 0px; -webkit-transform: translateZ(0px);"></div><div style="width: 256px; height: 256px; -webkit-transform: translateZ(0px); position: absolute; left: 31px; top: -187px; opacity: 1; transition: opacity 200ms ease-out; -webkit-transition: opacity 200ms ease-out;"><img src="http://mt0.googleapis.com/vt?lyrs=m@264015495&amp;src=apiv3&amp;hl=en-US&amp;x=4686&amp;y=8743&amp;z=14&amp;style=47,37%7Csmartmaps" draggable="false" style="width: 256px; height: 256px; -webkit-user-select: none; border: 0px; padding: 0px; margin: 0px; -webkit-transform: translateZ(0px);"></div><div style="width: 256px; height: 256px; -webkit-transform: translateZ(0px); position: absolute; left: 287px; top: 69px; opacity: 1; transition: opacity 200ms ease-out; -webkit-transition: opacity 200ms ease-out;"><img src="http://mt1.googleapis.com/vt?lyrs=m@264034610&amp;src=apiv3&amp;hl=en-US&amp;x=4687&amp;y=8744&amp;z=14&amp;style=47,37%7Csmartmaps" draggable="false" style="width: 256px; height: 256px; -webkit-user-select: none; border: 0px; padding: 0px; margin: 0px; -webkit-transform: translateZ(0px);"></div><div style="width: 256px; height: 256px; -webkit-transform: translateZ(0px); position: absolute; left: -225px; top: -187px; opacity: 1; transition: opacity 200ms ease-out; -webkit-transition: opacity 200ms ease-out;"><img src="http://mt1.googleapis.com/vt?lyrs=m@264009958&amp;src=apiv3&amp;hl=en-US&amp;x=4685&amp;y=8743&amp;z=14&amp;style=47,37%7Csmartmaps" draggable="false" style="width: 256px; height: 256px; -webkit-user-select: none; border: 0px; padding: 0px; margin: 0px; -webkit-transform: translateZ(0px);"></div><div style="width: 256px; height: 256px; -webkit-transform: translateZ(0px); position: absolute; left: 287px; top: -187px; opacity: 1; transition: opacity 200ms ease-out; -webkit-transition: opacity 200ms ease-out;"><img src="http://mt1.googleapis.com/vt?lyrs=m@264034600&amp;src=apiv3&amp;hl=en-US&amp;x=4687&amp;y=8743&amp;z=14&amp;style=47,37%7Csmartmaps" draggable="false" style="width: 256px; height: 256px; -webkit-user-select: none; border: 0px; padding: 0px; margin: 0px; -webkit-transform: translateZ(0px);"></div><div style="width: 256px; height: 256px; -webkit-transform: translateZ(0px); position: absolute; left: 287px; top: 325px; opacity: 1; transition: opacity 200ms ease-out; -webkit-transition: opacity 200ms ease-out;"><img src="http://mt1.googleapis.com/vt?lyrs=m@264040823&amp;src=apiv3&amp;hl=en-US&amp;x=4687&amp;y=8745&amp;z=14&amp;style=47,37%7Csmartmaps" draggable="false" style="width: 256px; height: 256px; -webkit-user-select: none; border: 0px; padding: 0px; margin: 0px; -webkit-transform: translateZ(0px);"></div><div style="width: 256px; height: 256px; -webkit-transform: translateZ(0px); position: absolute; left: -225px; top: 325px; opacity: 1; transition: opacity 200ms ease-out; -webkit-transition: opacity 200ms ease-out;"><img src="http://mt1.googleapis.com/vt?lyrs=m@264039121&amp;src=apiv3&amp;hl=en-US&amp;x=4685&amp;y=8745&amp;z=14&amp;style=47,37%7Csmartmaps" draggable="false" style="width: 256px; height: 256px; -webkit-user-select: none; border: 0px; padding: 0px; margin: 0px; -webkit-transform: translateZ(0px);"></div><div style="width: 256px; height: 256px; -webkit-transform: translateZ(0px); position: absolute; left: 31px; top: 325px; opacity: 1; transition: opacity 200ms ease-out; -webkit-transition: opacity 200ms ease-out;"><img src="http://mt0.googleapis.com/vt?lyrs=m@264034610&amp;src=apiv3&amp;hl=en-US&amp;x=4686&amp;y=8745&amp;z=14&amp;style=47,37%7Csmartmaps" draggable="false" style="width: 256px; height: 256px; -webkit-user-select: none; border: 0px; padding: 0px; margin: 0px; -webkit-transform: translateZ(0px);"></div></div></div></div></div><div style="margin-left: 5px; margin-right: 5px; z-index: 1000000; position: absolute; left: 0px; bottom: 0px;"><a target="_blank" href="http://maps.google.com/maps?ll=-12.046103,-77.018999&amp;z=14&amp;t=m&amp;hl=en-US&amp;gl=US&amp;mapclient=apiv3" title="Click to see this area on Google Maps" style="position: static; overflow: visible; float: none; display: inline;"><div style="width: 62px; height: 26px; cursor: pointer;"><img src="http://maps.gstatic.com/mapfiles/api-3/images/google_white2.png" draggable="false" style="position: absolute; left: 0px; top: 0px; width: 62px; height: 26px; -webkit-user-select: none; border: 0px; padding: 0px; margin: 0px;"></div></a></div><div class="gmnoprint" style="z-index: 1000001; position: absolute; right: 280px; bottom: 0px; width: 125px;"><div draggable="false" class="gm-style-cc" style="-webkit-user-select: none;"><div style="opacity: 0.7; width: 100%; height: 100%; position: absolute;"><div style="width: 1px;"></div><div style="width: auto; height: 100%; margin-left: 1px; background-color: rgb(245, 245, 245);"></div></div><div style="position: relative; padding-right: 6px; padding-left: 6px; font-family: Roboto, Arial, sans-serif; font-size: 10px; color: rgb(68, 68, 68); white-space: nowrap; direction: ltr; text-align: right;"><a style="color: rgb(68, 68, 68); text-decoration: none; cursor: pointer; display: none;">Map Data</a><span style="">Map data ©2014 Google</span></div></div></div><div style="padding: 15px 21px; border: 1px solid rgb(171, 171, 171); font-family: Roboto, Arial, sans-serif; color: rgb(34, 34, 34); -webkit-box-shadow: rgba(0, 0, 0, 0.2) 0px 4px 16px; box-shadow: rgba(0, 0, 0, 0.2) 0px 4px 16px; z-index: 10000002; display: none; width: 256px; height: 148px; position: absolute; left: 81px; top: 60px; background-color: white;"><div style="padding: 0px 0px 10px; font-size: 16px;">Map Data</div><div style="font-size: 13px;">Map data ©2014 Google</div><div style="width: 13px; height: 13px; overflow: hidden; position: absolute; opacity: 0.7; right: 12px; top: 12px; z-index: 10000; cursor: pointer;"><img src="http://maps.gstatic.com/mapfiles/api-3/images/mapcnt3.png" draggable="false" style="position: absolute; left: -2px; top: -336px; width: 59px; height: 492px; -webkit-user-select: none; border: 0px; padding: 0px; margin: 0px;"></div></div><div class="gmnoscreen" style="position: absolute; right: 0px; bottom: 0px;"><div style="font-family: Roboto, Arial, sans-serif; font-size: 11px; color: rgb(68, 68, 68); direction: ltr; text-align: right; background-color: rgb(245, 245, 245);">Map data ©2014 Google</div></div><div class="gmnoprint gm-style-cc" draggable="false" style="z-index: 1000001; position: absolute; -webkit-user-select: none; right: 113px; bottom: 0px;"><div style="opacity: 0.7; width: 100%; height: 100%; position: absolute;"><div style="width: 1px;"></div><div style="width: auto; height: 100%; margin-left: 1px; background-color: rgb(245, 245, 245);"></div></div><div style="position: relative; padding-right: 6px; padding-left: 6px; font-family: Roboto, Arial, sans-serif; font-size: 10px; color: rgb(68, 68, 68); white-space: nowrap; direction: ltr; text-align: right;"><a href="http://www.google.com/intl/en-US_US/help/terms_maps.html" target="_blank" style="text-decoration: none; cursor: pointer; color: rgb(68, 68, 68);">Terms of Use</a></div></div><div draggable="false" class="gm-style-cc" style="-webkit-user-select: none; position: absolute; right: 18px; bottom: 0px;"><div style="opacity: 0.7; width: 100%; height: 100%; position: absolute;"><div style="width: 1px;"></div><div style="width: auto; height: 100%; margin-left: 1px; background-color: rgb(245, 245, 245);"></div></div><div style="position: relative; padding-right: 6px; padding-left: 6px; font-family: Roboto, Arial, sans-serif; font-size: 10px; color: rgb(68, 68, 68); white-space: nowrap; direction: ltr; text-align: right;"><a target="_new" title="Report errors in the road map or imagery to Google" href="http://maps.google.com/maps?ll=-12.046103,-77.018999&amp;z=14&amp;t=m&amp;hl=en-US&amp;gl=US&amp;mapclient=apiv3&amp;skstate=action:mps_dialog$apiref:1&amp;output=classic" style="font-family: Roboto, Arial, sans-serif; font-size: 10px; color: rgb(68, 68, 68); text-decoration: none; position: relative;">Report a map error</a></div></div><div class="gmnoprint" draggable="false" style="position: absolute; -webkit-user-select: none; margin-left: 5px; margin-top: 5px; width: 13px; height: 13px; right: 0px; bottom: 0px;"><div style="overflow: hidden; width: 120px; height: 120px; display: none; background-color: rgb(255, 255, 255);"><div style="position: absolute; left: 3px; top: 3px; width: 117px; height: 117px; overflow: hidden; -webkit-transform: translateZ(0px); background-color: rgb(229, 227, 223);"><div class="gm-style" style="position: absolute; left: 0px; top: 0px; overflow: hidden; width: 100%; height: 100%; z-index: 0;"><div style="position: absolute; left: 0px; top: 0px; overflow: hidden; width: 100%; height: 100%; z-index: 0;"><div style="position: absolute; left: 0px; top: 0px; z-index: 1; width: 100%; cursor: url(http://maps.gstatic.com/mapfiles/openhand_8_8.cur) 8 8, default; -webkit-transform-origin: 0px 0px; -webkit-transform: matrix(1, 0, 0, 1, 0, 0);"><div style="-webkit-transform: translateZ(0px); position: absolute; left: 0px; top: 0px; width: 100%; z-index: 200;"><div style="-webkit-transform: translateZ(0px); position: absolute; left: 0px; top: 0px; z-index: 101; width: 100%;"></div></div><div style="-webkit-transform: translateZ(0px); position: absolute; left: 0px; top: 0px; width: 100%; z-index: 201;"><div style="-webkit-transform: translateZ(0px); position: absolute; left: 0px; top: 0px; z-index: 102; width: 100%;"></div><div style="-webkit-transform: translateZ(0px); position: absolute; left: 0px; top: 0px; z-index: 103; width: 100%;"></div></div><div style="-webkit-transform: translateZ(0px); position: absolute; left: 0px; top: 0px; width: 100%; z-index: 202;"><div style="-webkit-transform: translateZ(0px); position: absolute; left: 0px; top: 0px; z-index: 104; width: 100%;"></div><div style="-webkit-transform: translateZ(0px); position: absolute; left: 0px; top: 0px; z-index: 105; width: 100%;"><div style="border: 1px solid rgb(255, 255, 255); outline: rgb(0, 0, 0) solid 1px; opacity: 0.35; position: absolute; margin-top: -19px; margin-left: -29px; width: 58px; height: 38px; left: 0px; top: 0px;"><div style="position: absolute; opacity: 0.7; width: 58px; height: 38px; background: rgb(0, 0, 0);"></div></div><div style="border: 1px solid rgb(255, 255, 255); outline: rgb(0, 0, 0) solid 1px; opacity: 0.35; position: absolute; cursor: url(http://maps.gstatic.com/mapfiles/openhand_8_8.cur) 8 8, default; margin-top: -19px; margin-left: -29px; width: 58px; height: 38px; left: 0px; top: 0px;"><div style="position: absolute; width: 58px; height: 38px;"></div></div></div><div style="-webkit-transform: translateZ(0px); position: absolute; left: 0px; top: 0px; z-index: 106; width: 100%;"></div></div><div style="-webkit-transform: translateZ(0px); position: absolute; left: 0px; top: 0px; z-index: 100; width: 100%;"><div style="position: absolute; left: 0px; top: 0px; z-index: 0;"><div style="position: absolute; left: 0px; top: 0px; z-index: 1;"><div style="width: 256px; height: 256px; -webkit-transform: translateZ(0px); position: absolute; left: -217px; top: -266px;"></div><div style="width: 256px; height: 256px; -webkit-transform: translateZ(0px); position: absolute; left: -217px; top: -10px;"></div><div style="width: 256px; height: 256px; -webkit-transform: translateZ(0px); position: absolute; left: 39px; top: -266px;"></div><div style="width: 256px; height: 256px; -webkit-transform: translateZ(0px); position: absolute; left: 39px; top: -10px;"></div></div></div></div><div style="position: absolute; z-index: 0; left: 0px; top: 0px;"><div style="overflow: hidden;"></div></div><div style="position: absolute; left: 0px; top: 0px; z-index: 0;"><div style="position: absolute; left: 0px; top: 0px; z-index: 1;"><div style="width: 256px; height: 256px; -webkit-transform: translateZ(0px); position: absolute; left: -217px; top: -266px;"><img src="http://mt1.googleapis.com/vt?lyrs=m@264000000&amp;src=apiv3&amp;hl=en-US&amp;x=585&amp;y=1092&amp;z=11&amp;style=47,37%7Csmartmaps" draggable="false" style="width: 256px; height: 256px; -webkit-user-select: none; border: 0px; padding: 0px; margin: 0px; -webkit-transform: translateZ(0px);"></div><div style="width: 256px; height: 256px; -webkit-transform: translateZ(0px); position: absolute; left: -217px; top: -10px;"><img src="http://mt1.googleapis.com/vt?lyrs=m@264000000&amp;src=apiv3&amp;hl=en-US&amp;x=585&amp;y=1093&amp;z=11&amp;style=47,37%7Csmartmaps" draggable="false" style="width: 256px; height: 256px; -webkit-user-select: none; border: 0px; padding: 0px; margin: 0px; -webkit-transform: translateZ(0px);"></div><div style="width: 256px; height: 256px; -webkit-transform: translateZ(0px); position: absolute; left: 39px; top: -266px;"><img src="http://mt0.googleapis.com/vt?lyrs=m@264000000&amp;src=apiv3&amp;hl=en-US&amp;x=586&amp;y=1092&amp;z=11&amp;style=47,37%7Csmartmaps" draggable="false" style="width: 256px; height: 256px; -webkit-user-select: none; border: 0px; padding: 0px; margin: 0px; -webkit-transform: translateZ(0px);"></div><div style="width: 256px; height: 256px; -webkit-transform: translateZ(0px); position: absolute; left: 39px; top: -10px;"><img src="http://mt0.googleapis.com/vt?lyrs=m@264000000&amp;src=apiv3&amp;hl=en-US&amp;x=586&amp;y=1093&amp;z=11&amp;style=47,37%7Csmartmaps" draggable="false" style="width: 256px; height: 256px; -webkit-user-select: none; border: 0px; padding: 0px; margin: 0px; -webkit-transform: translateZ(0px);"></div></div></div></div></div></div></div></div><div style="width: 13px; height: 13px; position: absolute; cursor: pointer; left: 0px; top: 0px;"><div title="Open the overview map" style="width: 13px; height: 13px; overflow: hidden; position: absolute;"><img src="http://maps.gstatic.com/mapfiles/api-3/images/mapcnt3.png" draggable="false" style="position: absolute; left: -2px; top: -364px; width: 59px; height: 492px; -webkit-user-select: none; border: 0px; padding: 0px; margin: 0px;"></div></div></div><div class="gmnoprint" draggable="false" controlwidth="78" controlheight="169" style="margin: 5px; -webkit-user-select: none; position: absolute; left: 0px; top: 0px;"><div class="gmnoprint" controlwidth="78" controlheight="80" style="cursor: url(http://maps.gstatic.com/mapfiles/openhand_8_8.cur) 8 8, default; width: 78px; height: 78px; position: absolute; left: 0px; top: 0px;"><div class="gmnoprint" controlwidth="78" controlheight="80" style="width: 78px; height: 78px; position: absolute; left: 0px; top: 0px;"><div style="visibility: hidden;"><svg version="1.1" overflow="hidden" width="78px" height="78px" viewBox="0 0 78 78" style="position: absolute; left: 0px; top: 0px;"><circle cx="39" cy="39" r="35" stroke-width="3" fill-opacity="0.2" fill="#f2f4f6" stroke="#f2f4f6"></circle><g transform="rotate(0 39 39)"><rect x="33" y="0" rx="4" ry="4" width="12" height="11" stroke="#a6a6a6" stroke-width="1" fill="#f2f4f6"></rect><polyline points="36.5,8.5 36.5,2.5 41.5,8.5 41.5,2.5" stroke-linejoin="bevel" stroke-width="1.5" fill="#f2f4f6" stroke="#000"></polyline></g></svg></div></div><div class="gmnoprint" controlwidth="59" controlheight="59" style="position: absolute; left: 10px; top: 11px;"><div style="width: 59px; height: 59px; overflow: hidden; position: relative;"><img src="http://maps.gstatic.com/mapfiles/api-3/images/mapcnt3.png" draggable="false" style="position: absolute; left: 0px; top: 0px; width: 59px; height: 492px; -webkit-user-select: none; border: 0px; padding: 0px; margin: 0px;"><div title="Pan left" style="position: absolute; left: 0px; top: 20px; width: 19.666666666666668px; height: 19.666666666666668px; cursor: pointer;"></div><div title="Pan right" style="position: absolute; left: 39px; top: 20px; width: 19.666666666666668px; height: 19.666666666666668px; cursor: pointer;"></div><div title="Pan up" style="position: absolute; left: 20px; top: 0px; width: 19.666666666666668px; height: 19.666666666666668px; cursor: pointer;"></div><div title="Pan down" style="position: absolute; left: 20px; top: 39px; width: 19.666666666666668px; height: 19.666666666666668px; cursor: pointer;"></div></div></div></div><div controlwidth="32" controlheight="40" style="cursor: url(http://maps.gstatic.com/mapfiles/openhand_8_8.cur) 8 8, default; position: absolute; left: 23px; top: 85px;"><div style="width: 32px; height: 40px; overflow: hidden; position: absolute; left: 0px; top: 0px;"><img src="http://maps.gstatic.com/mapfiles/api-3/images/cb_scout2.png" draggable="false" style="position: absolute; left: -9px; top: -102px; width: 1028px; height: 214px; -webkit-user-select: none; border: 0px; padding: 0px; margin: 0px;"></div><div style="width: 32px; height: 40px; overflow: hidden; position: absolute; left: 0px; top: 0px; visibility: hidden;"><img src="http://maps.gstatic.com/mapfiles/api-3/images/cb_scout2.png" draggable="false" style="position: absolute; left: -107px; top: -102px; width: 1028px; height: 214px; -webkit-user-select: none; border: 0px; padding: 0px; margin: 0px;"></div><div style="width: 32px; height: 40px; overflow: hidden; position: absolute; left: 0px; top: 0px; visibility: hidden;"><img src="http://maps.gstatic.com/mapfiles/api-3/images/cb_scout2.png" draggable="false" style="position: absolute; left: -58px; top: -102px; width: 1028px; height: 214px; -webkit-user-select: none; border: 0px; padding: 0px; margin: 0px;"></div><div style="width: 32px; height: 40px; overflow: hidden; position: absolute; left: 0px; top: 0px; visibility: hidden;"><img src="http://maps.gstatic.com/mapfiles/api-3/images/cb_scout2.png" draggable="false" style="position: absolute; left: -205px; top: -102px; width: 1028px; height: 214px; -webkit-user-select: none; border: 0px; padding: 0px; margin: 0px;"></div></div><div class="gmnoprint" controlwidth="0" controlheight="0" style="opacity: 0.6; display: none; position: absolute;"><div title="Rotate map 90 degrees" style="width: 22px; height: 22px; overflow: hidden; position: absolute; cursor: pointer;"><img src="http://maps.gstatic.com/mapfiles/api-3/images/mapcnt3.png" draggable="false" style="position: absolute; left: -38px; top: -360px; width: 59px; height: 492px; -webkit-user-select: none; border: 0px; padding: 0px; margin: 0px;"></div></div><div class="gmnoprint" controlwidth="20" controlheight="39" style="position: absolute; left: 29px; top: 130px;"><div style="width: 20px; height: 39px; overflow: hidden; position: absolute;"><img src="http://maps.gstatic.com/mapfiles/api-3/images/mapcnt3.png" draggable="false" style="position: absolute; left: -39px; top: -401px; width: 59px; height: 492px; -webkit-user-select: none; border: 0px; padding: 0px; margin: 0px;"></div><div title="Zoom in" style="position: absolute; left: 0px; top: 2px; width: 20px; height: 17px; cursor: pointer;"></div><div title="Zoom out" style="position: absolute; left: 0px; top: 19px; width: 20px; height: 17px; cursor: pointer;"></div></div></div><div class="gmnoprint" style="margin: 5px; z-index: 0; position: absolute; cursor: pointer; right: 0px; top: 0px;"><div class="gm-style-mtc" style="float: left;"><div draggable="false" title="Show street map" style="direction: ltr; overflow: hidden; text-align: center; position: relative; color: rgb(0, 0, 0); font-family: Roboto, Arial, sans-serif; -webkit-user-select: none; font-size: 11px; padding: 1px 6px; border-bottom-left-radius: 2px; border-top-left-radius: 2px; -webkit-background-clip: padding-box; border: 1px solid rgba(0, 0, 0, 0.14902); -webkit-box-shadow: rgba(0, 0, 0, 0.298039) 0px 1px 4px -1px; box-shadow: rgba(0, 0, 0, 0.298039) 0px 1px 4px -1px; min-width: 22px; font-weight: 500; background-color: rgb(255, 255, 255); background-clip: padding-box;">Map</div><div style="z-index: -1; padding-top: 2px; -webkit-background-clip: padding-box; border-width: 0px 1px 1px; border-right-style: solid; border-bottom-style: solid; border-left-style: solid; border-right-color: rgba(0, 0, 0, 0.14902); border-bottom-color: rgba(0, 0, 0, 0.14902); border-left-color: rgba(0, 0, 0, 0.14902); -webkit-box-shadow: rgba(0, 0, 0, 0.298039) 0px 1px 4px -1px; box-shadow: rgba(0, 0, 0, 0.298039) 0px 1px 4px -1px; position: absolute; left: 0px; top: 25px; text-align: left; display: none; background-color: white; background-clip: padding-box;"><div draggable="false" title="Show street map with terrain" style="color: rgb(0, 0, 0); font-family: Roboto, Arial, sans-serif; -webkit-user-select: none; font-size: 11px; padding: 3px 8px 3px 3px; direction: ltr; text-align: left; white-space: nowrap; background-color: rgb(255, 255, 255);"><span role="checkbox" style="box-sizing: border-box; position: relative; line-height: 0; font-size: 0px; margin: 0px 5px 0px 0px; display: inline-block; border: 1px solid rgb(198, 198, 198); border-top-left-radius: 1px; border-top-right-radius: 1px; border-bottom-right-radius: 1px; border-bottom-left-radius: 1px; width: 13px; height: 13px; vertical-align: middle; background-color: rgb(255, 255, 255);"><div style="position: absolute; left: 1px; top: -2px; width: 13px; height: 11px; overflow: hidden; display: none;"><img src="http://maps.gstatic.com/mapfiles/mv/imgs8.png" draggable="false" style="position: absolute; left: -52px; top: -44px; -webkit-user-select: none; border: 0px; padding: 0px; margin: 0px; width: 68px; height: 67px;"></div></span><label style="vertical-align: middle; cursor: pointer;">Terrain</label></div></div></div><div class="gm-style-mtc" style="float: left;"><div draggable="false" title="Show satellite imagery" style="direction: ltr; overflow: hidden; text-align: center; position: relative; color: rgb(86, 86, 86); font-family: Roboto, Arial, sans-serif; -webkit-user-select: none; font-size: 11px; padding: 1px 6px; border-bottom-right-radius: 2px; border-top-right-radius: 2px; -webkit-background-clip: padding-box; border-width: 1px 1px 1px 0px; border-top-style: solid; border-right-style: solid; border-bottom-style: solid; border-top-color: rgba(0, 0, 0, 0.14902); border-right-color: rgba(0, 0, 0, 0.14902); border-bottom-color: rgba(0, 0, 0, 0.14902); -webkit-box-shadow: rgba(0, 0, 0, 0.298039) 0px 1px 4px -1px; box-shadow: rgba(0, 0, 0, 0.298039) 0px 1px 4px -1px; min-width: 38px; background-color: rgb(255, 255, 255); background-clip: padding-box;">Satellite</div><div style="z-index: -1; padding-top: 2px; -webkit-background-clip: padding-box; border-width: 0px 1px 1px; border-right-style: solid; border-bottom-style: solid; border-left-style: solid; border-right-color: rgba(0, 0, 0, 0.14902); border-bottom-color: rgba(0, 0, 0, 0.14902); border-left-color: rgba(0, 0, 0, 0.14902); -webkit-box-shadow: rgba(0, 0, 0, 0.298039) 0px 1px 4px -1px; box-shadow: rgba(0, 0, 0, 0.298039) 0px 1px 4px -1px; position: absolute; right: 0px; top: 25px; text-align: left; display: none; background-color: white; background-clip: padding-box;"><div draggable="false" title="Zoom in to show 45 degree view" style="color: rgb(184, 184, 184); font-family: Roboto, Arial, sans-serif; -webkit-user-select: none; font-size: 11px; padding: 3px 8px 3px 3px; direction: ltr; text-align: left; white-space: nowrap; display: none; background-color: rgb(255, 255, 255);"><span role="checkbox" style="box-sizing: border-box; position: relative; line-height: 0; font-size: 0px; margin: 0px 5px 0px 0px; display: inline-block; border: 1px solid rgb(241, 241, 241); border-top-left-radius: 1px; border-top-right-radius: 1px; border-bottom-right-radius: 1px; border-bottom-left-radius: 1px; width: 13px; height: 13px; vertical-align: middle; background-color: rgb(255, 255, 255);"><div style="position: absolute; left: 1px; top: -2px; width: 13px; height: 11px; overflow: hidden; display: none;"><img src="http://maps.gstatic.com/mapfiles/mv/imgs8.png" draggable="false" style="position: absolute; left: -52px; top: -44px; -webkit-user-select: none; border: 0px; padding: 0px; margin: 0px; width: 68px; height: 67px;"></div></span><label style="vertical-align: middle; cursor: pointer;">45°</label></div><div draggable="false" title="Show imagery with street names" style="color: rgb(0, 0, 0); font-family: Roboto, Arial, sans-serif; -webkit-user-select: none; font-size: 11px; padding: 3px 8px 3px 3px; direction: ltr; text-align: left; white-space: nowrap; background-color: rgb(255, 255, 255);"><span role="checkbox" style="box-sizing: border-box; position: relative; line-height: 0; font-size: 0px; margin: 0px 5px 0px 0px; display: inline-block; border: 1px solid rgb(198, 198, 198); border-top-left-radius: 1px; border-top-right-radius: 1px; border-bottom-right-radius: 1px; border-bottom-left-radius: 1px; width: 13px; height: 13px; vertical-align: middle; background-color: rgb(255, 255, 255);"><div style="position: absolute; left: 1px; top: -2px; width: 13px; height: 11px; overflow: hidden;"><img src="http://maps.gstatic.com/mapfiles/mv/imgs8.png" draggable="false" style="position: absolute; left: -52px; top: -44px; -webkit-user-select: none; border: 0px; padding: 0px; margin: 0px; width: 68px; height: 67px;"></div></span><label style="vertical-align: middle; cursor: pointer;">Labels</label></div></div></div></div><div draggable="false" class="gm-style-cc" style="-webkit-user-select: none; position: absolute; right: 183px; bottom: 0px;"><div style="opacity: 0.7; width: 100%; height: 100%; position: absolute;"><div style="width: 1px;"></div><div style="width: auto; height: 100%; margin-left: 1px; background-color: rgb(245, 245, 245);"></div></div><div style="position: relative; padding-right: 6px; padding-left: 6px; font-family: Roboto, Arial, sans-serif; font-size: 10px; color: rgb(68, 68, 68); white-space: nowrap; direction: ltr; text-align: right;"><span>500 m&nbsp;</span><div style="position: relative; display: inline-block; height: 8px; bottom: -1px; width: 54px;"><div style="width: 100%; height: 4px; position: absolute; bottom: 0px; left: 0px; background-color: rgb(255, 255, 255);"></div><div style="position: absolute; left: 0px; top: 0px; width: 4px; height: 8px; background-color: rgb(255, 255, 255);"></div><div style="width: 4px; height: 8px; position: absolute; bottom: 0px; right: 0px; background-color: rgb(255, 255, 255);"></div><div style="position: absolute; height: 2px; bottom: 1px; right: 1px; left: 1px; background-color: rgb(102, 102, 102);"></div><div style="position: absolute; left: 1px; top: 1px; width: 2px; height: 6px; background-color: rgb(102, 102, 102);"></div><div style="width: 2px; height: 6px; position: absolute; bottom: 1px; right: 1px; background-color: rgb(102, 102, 102);"></div></div></div></div></div></div>
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
					<p><i class="fa fa-tags"></i> Trainee ID: <strong><cfoutput>#viewSite.ID#</cfoutput></strong></p>
                    <p><i class="fa fa-pencil-square-o"></i> Last Edited: <strong><cfoutput>#viewSite.LastEditedBy#</cfoutput> on <cfoutput>#viewSite.DateUpdated#</cfoutput></strong></p>
                    <div class="mb5"></div>
							<div class="btn-group mr10">
                                <a href="?m=e#profile" class="btn btn-primary"><i class="fa fa-pencil"></i> Edit Site</a>
                                <button class="btn btn-danger" type="button"><i class="fa fa-trash-o mr5"></i> Delete</button>
                            </div>  
							<div class="btn-group">
                                <button data-toggle="dropdown" class="btn btn-default dropdown-toggle" type="button">
                                    <i class="fa fa-plus mr5"></i> Add
                                    <span class="caret"></span>
                                </button>
                                <ul class="dropdown-menu">
                                    <li><a href="#">Add Address</a></li>
                                    <li><a href="#">Add Phone Number</a></li>
                                    <li><a href="#">Add Experience Here</a></li>
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
                                <label class="text-primary alignleft"><cfoutput>#viewSite.Address2#</cfoutput></label><br >
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
                  <option value="">Choose a Site Type...</option>
                <cfoutput query="rSiteTypes">
                   <option value="#ID#">#SiteType#</option>
                </cfoutput>
              </select>
				</cfcase>
                <cfcase value="View">
                <label class="text-primary alignleft"><cfoutput>#viewSite.SiteType#</cfoutput></label>
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
                <option value=""></option>
                <cfoutput query="rPartners">
                    <option value="#ID#">#Partner#</option>
                </cfoutput>
              </select>
              <label class="error" for="SitePartners"></label>
				</cfcase>
                <cfcase value="View">
                	<cfloop query="viewSitePartners">
                    	<cfoutput><label class="text-primary alignleft">#viewSitePartners.CurrentRow#. #viewSitePartners.Partner#</label><br /></cfoutput>
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
                <option value=""></option>
                <cfoutput query="rPopulations">
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
    			<div id="gmap-marker" style="height: 300px"></div>        
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
function initialize() {
  geocoder = new google.maps.Geocoder();
  var latlng = new google.maps.LatLng(32.20031984247428, -110.92999805822753);
  var mapOptions = {
    zoom: 7,
    center: latlng
  }
  map = new google.maps.Map(document.getElementById('map-marker'), mapOptions);
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
