<cfinclude template="connection/connection.cfc">
<!--Set up Page Variables for Header include-->
	<cfset This.PageName = 'Dashboard'>
    <cfset This.Icon = 'fa fa-home'>
<!--Set up Page Variables for Navigation include-->    
    <cfset This.CurrentLevel = '0'>
    <cfset This.HostName = '#cgi.script_name#'>
    <cfset This.ActiveFolder = 'db'>
<!--Check if User has been authenticated-->
	
<cfif IsDefined("Session.UserID")>
<cfelse>
	<cflocation url="signin.cfm" addtoken="NO">
</cfif>

<cfif StructKeyExists(url,'logoff')>
	<cfset StructClear(Session)>
    <cflocation url="signin.cfm" addtoken="NO" >
</cfif>

	
<!--Set Up page level, will be used to determine Forwarding Links-->    
	<cfset This.PageLevel = '1'>
<!--Open Navigation-->
    <cfquery name="Navigation" datasource="#datasource#">
        SELECT * FROM tbl_Navigation WHERE accessType = '#Session.AccessLevel#' AND childOf = 'none' ORDER BY navOrder ASC
    </cfquery>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0">
  <meta name="description" content="">
  <meta name="author" content="Ashar Babar Concepts">
  <link rel="shortcut icon" href="images/favicon.ico" type="image/png">

  <title>AZAHEC Admin - Career Training</title>

  <link href="css/style.default.css" rel="stylesheet">
  <link href="css/jquery.datatables.css" rel="stylesheet">
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
<div id="ua-web-branding-banner-v1" class="ua-wrapper bgDark blue-grad">
  <a class="ua-home asdf" href="http://arizona.edu" title="The University of Arizona">
    <p>The University of Arizona</p>
  </a>
</div>



<section>
  <!-- leftpanel -->
  	<cfinclude template="includes/leftpanel.cfm">
  <!-- leftpanel -->
  
  <!-- mainpanel start -->
  <div class="mainpanel">
    
	  <!-- header -->
  		<cfinclude template="includes/header.cfm">
  	  <!-- header -->
    
        <!-- content dynamic -->
            <cfset This.ContentType = 'includes/contentpanel.cfm'>
            <cfinclude template="#This.ContentType#">
        <!-- content dynamic -->
    
    <!-- contentpanel -->
    
  </div>
  <!-- mainpanel end -->
  
  <div class="rightpanel">
    <!-- Nav tabs -->
    <ul class="nav nav-tabs nav-justified">
        <li class="active"><a href="#rp-alluser" data-toggle="tab"><i class="fa fa-users"></i></a></li>
        <li><a href="#rp-favorites" data-toggle="tab"><i class="fa fa-heart"></i></a></li>
        <li><a href="#rp-history" data-toggle="tab"><i class="fa fa-clock-o"></i></a></li>
        <li><a href="#rp-settings" data-toggle="tab"><i class="fa fa-gear"></i></a></li>
    </ul>
        
    <!-- Future: Right panes start -->
    <!-- Future: Right panes end -->
  </div><!-- rightpanel -->
  
  
</section>


<script src="js/jquery-1.10.2.min.js"></script>
<script src="http://redbar.arizona.edu/sites/default/files/ua-banner/ua-web-branding/js/ua-web-branding.js" type="text/javascript"></script>
<script src="js/jquery-migrate-1.2.1.min.js"></script>
<script src="js/bootstrap.min.js"></script>
<script src="js/modernizr.min.js"></script>
<script src="js/jquery.sparkline.min.js"></script>
<script src="js/toggles.min.js"></script>
<script src="js/retina.min.js"></script>
<script src="js/jquery.cookies.js"></script>

<script src="js/flot/flot.min.js"></script>
<script src="js/flot/flot.resize.min.js"></script>
<script src="js/flot/flot.symbol.min.js"></script>
<script src="js/flot/flot.crosshair.min.js"></script>
<script src="js/flot/flot.categories.min.js"></script>
<script src="js/flot/flot.pie.min.js"></script>
<script src="js/morris.min.js"></script>
<script src="js/raphael-2.1.0.min.js"></script>

<script src="js/jquery.datatables.min.js"></script>
<script src="js/chosen.jquery.min.js"></script>

<script src="js/custom.js"></script>
<script src="js/dashboard.js"></script>


</body>
</html>
