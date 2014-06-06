<cfinclude template="../connection/connection.cfc">
<!--Check if User has been authenticated-->
<cfset Session.RL = "#cgi.script_name#">
<cfset User = "#checkUser()#">

<cfif StructKeyExists(url,'logoff')>
  <cfset StructClear(Session)>
  <cflocation url="../signin.cfm" addtoken="NO" >
</cfif>
<!--Set up Page Variables for Header include-->
	<cfset This.PageName = 'View Field Experience Sites'>
    <cfset This.Icon = 'fa fa-building-o'>
<!--Set up Page Variables for Navigation include-->    
    <cfset This.CurrentLevel = '1'>
    <cfset This.HostName = '#cgi.script_name#'>
    <cfset This.ActiveFolder = 'hp'>
<!--Database Calls-->
    <cfquery name="rTrainees" datasource="#datasource2#" maxrows="500">
        SELECT * FROM Trainees ORDER BY id ASC
    </cfquery>

<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0">
  <meta name="description" content="">
  <meta name="author" content="Ashar Babar Concepts">
  <link rel="shortcut icon" href="../images/favicon.ico" type="image/png">

  <title>AZAHEC Admin - Health Profession Students</title>

  <link href="../css/style.default.css" rel="stylesheet">
  <link href="../css/jquery.datatables.css" rel="stylesheet">
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
    <div id="status">
        <i class="fa fa-spinner fa-spin"></i>
    </div>
    
</div>
<!--UA Web Banner -->
<div id="ua-web-branding-banner-v1" class="ua-wrapper bgDark red-grad">
  <a class="ua-home asdf" href="http://arizona.edu" title="The University of Arizona">
    <p>The University of Arizona</p>
  </a>
</div>



<section>
  <!-- leftpanel -->
  	<cfinclude template="../includes/leftpanel.cfm">
  <!-- leftpanel -->
  
  <div class="mainpanel">
    <!-- header -->
    <cfinclude template="../includes/header.cfm" >
    <!-- header -->     
    
    <div class="contentpanel">
      <div class="row">
            <div class="panel panel-dark">
                <div class="panel-heading">
                    <ul class="pagination nomargin pull-right">
                        <a href="ae/aSite.cfm" class="btn btn-primary">Add Site</a>
                            <button id="chatview" class="btn btn-primary">
                				<i class="fa fa-search"></i>
            				</button>
                    </ul>
                    <h4 class="panel-title">Showing All Sites</h4>
                    <p><cfoutput>#rTrainees.RecordCount#</cfoutput> result</p>
                </div><!-- panel-heading -->
                <div class="panel-body">

 			<div class="table-responsive">
          <table class="table" id="table2">
              <thead>
                 <tr>
                    <th>ID</th>
                    <th>Last Name</th>
                    <th>First Name</th>
                    <th>Status</th>
                    <th>Email</th>
                    <th>Actions</th>
                 </tr>
              </thead>
              <tbody>
               <cfloop query="rTrainees">
                 <tr>
                    <td><a href="ae/vTrainee.cfm?id=<cfoutput>#ID#</cfoutput>"><cfoutput>#int(ID)#</cfoutput></a></td>
                    <td><cfoutput>#lastname#</cfoutput></td>
                    <td><cfoutput>#firstname#</cfoutput></td>
                    <td><cfoutput>#status#</cfoutput></td>
                    <td><cfoutput>#emailpreferred#</cfoutput></td>
                    <td><i class="fa fa-eye"></i>  <a href="ae/vTrainee.cfm?id=<cfoutput>#ID#</cfoutput>"><i class="fa fa-pencil"></i></a>  <i class="fa fa-trash-o"></i></td>
                 </tr>
				</cfloop>

              </tbody>
           </table>
                     </div>         
        
      </div><!-- row -->
                          
                </div><!-- panel-body -->
            </div>
    </div><!-- contentpanel -->
    
  </div><!-- mainpanel -->
  
 <div class="rightpanel">
    <!-- Nav tabs -->
    <ul class="nav nav-tabs nav-justified">
        <li class="active"><a href="#rp-search" data-toggle="tab"><i class="fa fa-search"></i></a></li>
    </ul>
        
    <!-- Tab panes -->
    <div class="tab-content">
        <div class="tab-pane active" id="rp-search">
            
            <h5 class="sidebartitle">Advanced Search</h5>
            <ul class="chatuserlist">
                <li>
                    <div class="media">
            <h4 class="subtitle-light mb5">Name</h4>
            <input type="text" value="Search Term" class="form-control" />
            
            <div class="mb20"></div>
            
            <h4 class="subtitle-light mb5">Profession</h4>
            <select class="form-control chosen-select" data-placeholder="Choose a Profession...">
                  <option value=""></option>
                  <option value="United States">Doctor</option>
                  <option value="United Kingdom">Burse</option>
                  <option value="Afghanistan">General Practioti...</option>
                  <option value="Aland Islands">Big Doctor</option>
                  <option value="Albania">Small Doctor</option>
                </select>
            
            <div class="mb20"></div>
            
            <h4 class="subtitle-light mb5">Region</h4>
            <select class="form-control chosen-select" data-placeholder="Choose a Region...">
                  <option value=""></option>
                  <option value="SEAHEC">South East AHEC</option>
                  <option value="GVAHEC">Greater Valley AHEC</option>
                  <option value="NAHEC">Northern AHEC</option>
                  <option value="EAHEC">Eastern AHEC</option>
                  <option value="WAHEC">Western AHEC</option>
                </select>
            
            <div class="mb20"></div>
            
            <h4 class="subtitle-light mb5">Email</h4>
            <input type="text" value="Email Address" class="form-control" />
                    </div><!-- media -->
                </li>

            </ul>
        </div>

        
    </div><!-- tab-content -->
  </div>
  
  
</section>
<div class="modal fade in" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
        <h4 class="modal-title" id="myModalLabel">Advanced Search</h4>
      </div>
      <div class="modal-body">
            
            <h4 class="subtitle mb5">Name</h4>
            <input type="text" value="Search Term" class="form-control" />
            
            <div class="mb20"></div>
            
            <h4 class="subtitle mb5">Profession</h4>
            <select class="form-control chosen-select" data-placeholder="Choose a Profession...">
                  <option value=""></option>
                  <option value="United States">Doctor</option>
                  <option value="United Kingdom">Burse</option>
                  <option value="Afghanistan">General Practioti...</option>
                  <option value="Aland Islands">Big Doctor</option>
                  <option value="Albania">Small Doctor</option>
                </select>
            
            <div class="mb20"></div>
            
            <h4 class="subtitle mb5">Region</h4>
            <select class="form-control chosen-select" data-placeholder="Choose a Region...">
                  <option value=""></option>
                  <option value="SEAHEC">South East AHEC</option>
                  <option value="GVAHEC">Greater Valley AHEC</option>
                  <option value="NAHEC">Northern AHEC</option>
                  <option value="EAHEC">Eastern AHEC</option>
                  <option value="WAHEC">Western AHEC</option>
                </select>
            
            <div class="mb20"></div>
            
            <h4 class="subtitle mb5">Email</h4>
            <input type="text" value="Email Address" class="form-control" />
                          
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-primary">Search</button>
      </div>
    </div><!-- modal-content -->
  </div><!-- modal-dialog -->
</div>

<script src="../js/jquery-1.10.2.min.js"></script>
<script src="../js/jquery-migrate-1.2.1.min.js"></script>
<script src="../js/bootstrap.min.js"></script>
<script src="../js/modernizr.min.js"></script>
<script src="../js/jquery.sparkline.min.js"></script>
<script src="../js/toggles.min.js"></script>
<script src="../js/retina.min.js"></script>
<script src="../js/jquery.cookies.js"></script>

<script src="../js/jquery.datatables.min.js"></script>

<script src="../js/jquery-ui-1.10.3.min.js"></script>
<script src="../js/chosen.jquery.min.js"></script>

<script src="../js/custom.js"></script>
<script>
    jQuery(document).ready(function() {
        
        // Chosen Select
        jQuery(".chosen-select").chosen({'width':'100%','white-space':'nowrap'});
        
    });
</script>
<script>
  jQuery(document).ready(function() {
    
    
    jQuery('#table2').dataTable({
      "sPaginationType": "full_numbers"
    });
    

  
  
  });
</script>
</body>
</html>
