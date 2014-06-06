<cfinclude template="../connection/connection.cfc">

    <cfquery name="Institutions" datasource="#datasource#">
        SELECT * FROM tbl_institutions ORDER BY id ASC
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
  	<cfinclude template="../includes/leftpanelnondynamic.cfm">
  <!-- leftpanel -->
  
  <div class="mainpanel">
    
    <div class="headerbar">
      
      <a class="menutoggle"><i class="fa fa-bars"></i></a>
      
      
      <div class="header-right">
        <ul class="headermenu">
          <li>
            <div class="btn-group">
              <button class="btn btn-default dropdown-toggle tp-icon" data-toggle="dropdown">
                <p><i class="glyphicon glyphicon-user"></i>
                </p>
              </button>
              <div class="dropdown-menu dropdown-menu-head pull-right">
                <h5 class="title">2 Newly Registered Users</h5>
                <ul class="dropdown-list user-list">
                  <li class="new">
                    <div class="thumb"><a href="#"><img src="../images/photos/user1.png" alt="" /></a></div>
                    <div class="desc">
                      <h5><a href="#">Ashar Babar (@asharnb)</a> <span class="badge badge-success">new</span></h5>
                    </div>
                  </li>
                  <li class="new"><a href="#">See All Connections</a></li>
                </ul>
              </div>
            </div>
          </li>
          <li>
            <div class="btn-group">
              <button class="btn btn-default dropdown-toggle tp-icon" data-toggle="dropdown">
              <i class="glyphicon glyphicon-envelope"></i></button>
              <div class="dropdown-menu dropdown-menu-head pull-right">
                <h5 class="title">You Have 1 New Message</h5>
                <ul class="dropdown-list gen-list">
                  <li class="new">
                    <a href="#">
                    <span class="thumb"><img src="../images/photos/user1.png" alt="" /></span>
                    <span class="desc">
                      <span class="name">Ashar Babar <span class="badge badge-success">new</span></span>
                      <span class="msg">New UPP report</span>
                    </span>
                    </a>
                  </li>

                  <li class="new"><a href="#">Read All Messages</a></li>
                </ul>
              </div>
            </div>
          </li>
          <li>
            <div class="btn-group">
              <button class="btn btn-default dropdown-toggle tp-icon" data-toggle="dropdown">
              <i class="glyphicon glyphicon-globe"></i></button>
              <div class="dropdown-menu dropdown-menu-head pull-right">
                <h5 class="title">You Have 5 New Notifications</h5>
                <ul class="dropdown-list gen-list">
                  <li class="new">
                    <a href="#">
                    <span class="thumb"><img src="../images/photos/user4.png" alt="" /></span>
                    <span class="desc">
                      <span class="name">Ashar Babar <span class="badge badge-success">new</span></span>
                      <span class="msg">is now following you</span>
                    </span>
                    </a>
                  </li>
                  <li class="new"><a href="#">See All Notifications</a></li>
                </ul>
              </div>
            </div>
          </li>
          <li>
            <div class="btn-group">
              <button type="button" class="btn btn-default dropdown-toggle" data-toggle="dropdown">
                <img src="../images/photos/loggeduser.png" alt="" />
                Ashar Babar
                <span class="caret"></span>
              </button>
              <ul class="dropdown-menu dropdown-menu-usermenu pull-right">
                <li><a href="#"><i class="glyphicon glyphicon-user"></i> My Profile</a></li>
                <li><a href="#"><i class="glyphicon glyphicon-cog"></i> Account Settings</a></li>
                <li><a href="#"><i class="glyphicon glyphicon-question-sign"></i> Help</a></li>
                <li><a href="../?logoff"><i class="glyphicon glyphicon-log-out"></i> Log Out</a></li>
              </ul>
            </div>
          </li>
        </ul>
      </div><!-- header-right -->
      
    </div><!-- headerbar -->
    
    <div class="pageheader">
      <h2><i class="fa fa-stethoscope"></i> Health Profession - View Institutions</h2>
      <div class="breadcrumb-wrapper">
        <span class="label">You are here:</span>
        <ol class="breadcrumb">
          <li><a href="../index.php">Health Professions</a></li>
          <li class="active">Institutions</li>
        </ol>
      </div>
    </div>
    
    <div class="contentpanel">
      <div class="row">
            <div class="panel panel-dark">
                <div class="panel-heading">
                  <ul class="pagination nomargin pull-right">
                        <a href="ae/vPreceptor.cfm" class="btn btn-primary">Add Institution</a>
                            <button id="chatview" class="btn btn-primary">
                				<i class="fa fa-search"></i>
            				</button>
                    </ul>
                    <h4 class="panel-title">Showing All Institutions</h4>
                    <p><cfoutput>#Institutions.RecordCount#</cfoutput> result (0.50 ms)</p>
                </div><!-- panel-heading -->
                <div class="panel-body">

 			<div class="table-responsive">
          <table class="table" id="table2">
              <thead>
                 <tr>
                    <th>ID</th>
                    <th>Name</th>
                    <th>City</th>
                    <th>State</th>
                    <th>Website</th>
                 </tr>
              </thead>
              <tbody>
               <cfloop query="Institutions">
                 <tr class="odd gradeX">
                    <td><cfoutput>#id#</cfoutput></td>
                    <td><cfoutput>#name#</cfoutput></td>
                    <td><cfoutput>#city#</cfoutput></td>
                    <td><cfoutput>#state#</cfoutput></td>
                    <td><a href="<cfoutput>#website#</cfoutput>" target="_blank">Visit Website</a></td>
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
