<!--Usable Code-->
<!--cfif StructKeyExists(url,'response') and url.response eq 'forgotpassword'-->

<!--Include Connection-->
<cfinclude template="connection/connection.cfc">
<!--Check if Login was initiated-->
<cfif IsDefined("isLogin")>

	<cfset authUser = #form.username#>
  	<cfobject component="procedures.authUser" name="Session.authUser" >

	<cfinvoke 
			component="#Session.authUser#" 
			method="getUser" 
			authUser = "#authUser#" >
     
	
	<cfset Session.UserID = '#session.authUser.name#'>
    <cfset Session.AccessLevel = '#session.authUser.role#'>
    
	<cfif IsDefined("Session.RL")>
    	<cflocation url="#Session.RL#" addtoken="NO" >
    <cfelse>
    	<cflocation url="index.cfm" addtoken="NO" >
    </cfif>    
<cfelse>
</cfif>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <meta name="description" content="AZAHEC Login Page">
  <meta name="author" content="Ashar Babar">
  <link rel="shortcut icon" href="images/favicon.ico" type="image/png">

  <title>AZAHEC Admin - Login</title>

  <link href="css/style.default.css" rel="stylesheet">

  <!-- HTML5 shim and Respond.js IE8 support of HTML5 elements and media queries -->
  <!--[if lt IE 9]>
  <script src="js/html5shiv.js"></script>
  <script src="js/respond.min.js"></script>
  <![endif]-->
</head>

<body class="signin">

<!-- Preloader -->
<div id="preloader">
    <div id="status"><i class="fa fa-spinner fa-spin"></i></div>
</div>

<section>
  
    <div class="signinpanel">
        
        <div class="row">
            
            <div class="col-md-7">
                
                <div class="signin-info">
                    <div class="logopanel">
                        <h1><span><img src="images/AZAHEC.png" width="297" height="78" alt="logo"></h1>
                    </div><!-- logopanel -->
                
                    <div class="mb20"></div>
                
                    <h5><strong>Welcome to AZ AHEC Admin Beta</strong></h5>
                    <ul>
                        <li><i class="fa fa-arrow-circle-o-right mr5"></i> Beta Testing Phase 1</li>
                    </ul>
                    <div class="mb20"></div>
                    <strong>No Username? <a href="#">Request Access</a></strong>
                </div><!-- signin0-info -->
            
            </div><!-- col-sm-7 -->
            
            <div class="col-md-5">
                
                <form id="login" action="signin.cfm?isLogin" method="POST">
                    <h4 class="nomargin">Sign In</h4>
                    <p class="mt5 mb20">Login to access your account.</p>
                        <div class="error"></div>
                    <input type="text" name="username" id="username" title="Your username is required" class="form-control uname" placeholder="Username" required/>
                    <input type="password" name="password" id="password" title="Your password is required" class="form-control pword" placeholder="Password" required/>
                    <a href="#"><small>Forgot Your Password?</small></a>
                    <input type="submit" class="btn btn-success btn-block" value="Sign In" />
                </form>
            </div><!-- col-sm-5 -->
            
        </div><!-- row -->
        
        <div class="signup-footer">
            <div class="pull-left">
                &copy; 2014. All Rights Reserved. Arizona AHEC.
            </div>
            <div class="pull-right">
                <a href="#" target="_blank">AZAHEC Main</a>
            </div>
        </div>
        
    </div><!-- signin -->
  
</section>


<script src="js/jquery-1.10.2.min.js"></script>
<script src="js/jquery-migrate-1.2.1.min.js"></script>
<script src="js/bootstrap.min.js"></script>
<script src="js/modernizr.min.js"></script>
<script src="js/jquery.sparkline.min.js"></script>
<script src="js/toggles.min.js"></script>
<script src="js/retina.min.js"></script>
<script src="js/jquery.cookies.js"></script>

<script src="js/jquery.validate.min.js"></script>

<script src="js/custom.js"></script>


<script>
jQuery(document).ready(function(){

  jQuery("#login").validate({
	 errorLabelContainer: jQuery("#login div.error")
  });
  
  
});
</script>
</body>
</html>
