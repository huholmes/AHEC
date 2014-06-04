<div class="leftpanel margined42">
    
    <div class="logopanel">
        <h1><span><img src="../images/azahecadminbeta2.png" width="240" height="50" alt="logo"></span></h1>
    </div><!-- logopanel -->
        
    <div class="leftpanelinner">    
        
        <!-- This is only visible to small devices -->
        <div class="visible-xs hidden-sm hidden-md hidden-lg">   
            <div class="media userlogged">
                <img alt="" src="images/photos/loggeduser.png" class="media-object">
                <div class="media-body">
                    <h4><?php echo $_SESSION['displayname']; ?></h4>
                    <span>AZAHEC Admin</span>
                </div>
            </div>
          
            <h5 class="sidebartitle actitle">Account</h5>
            <ul class="nav nav-pills nav-stacked nav-bracket mb30">
              <li><a href="profile.html"><i class="fa fa-user"></i> <span>Profile</span></a></li>
              <li><a href="#"><i class="fa fa-cog"></i> <span>Account Settings</span></a></li>
              <li><a href="#"><i class="fa fa-question-circle"></i> <span>Help</span></a></li>
              <li><a href="#"><i class="fa fa-sign-out"></i> <span>Sign Out</span></a></li>
            </ul>
        </div>
      
      <h5 class="sidebartitle">Navigation</h5>
      <ul class="nav nav-pills nav-stacked nav-bracket">
        <li><a href="../index.cfm"><i class="fa fa-home"></i> <span class="gold-letters">Dashboard</span></a></li>
        <li class="nav-parent nav-active active"><a href="#"><i class="fa fa-stethoscope"></i> <span>Health Professions</span></a>
          <ul class="children" style="display: block">
            <li class="active"><a href="hpstudents.cfm"><i class="fa fa-caret-right"></i> HP Students</a></li>
            <li class="active"><a href="hptrainees.cfm"><i class="fa fa-caret-right"></i> HP Trainees</a></li>
            <li><a href="hpPreceptors.cfm"><i class="fa fa-caret-right"></i> Preceptors</a></li>
            <li><a href="hpInstitutions.cfm"><i class="fa fa-caret-right"></i> Institutions</a></li>
            <li><a href="hpTS.cfm"><i class="fa fa-caret-right"></i> Training Sites</a></li>
            <li><a href="hpRotations.cfm"><i class="fa fa-caret-right"></i> Rotations</a></li>
          </ul>
        </li>
        <li class="nav-parent"><a href="#"><i class="fa fa-tasks"></i> <span class="gold-letters">Career Preperation</span></a>
          <ul class="children">
            <li><a href="#"><i class="fa fa-caret-right"></i> Programs</a></li>
            <li><a href="#"><i class="fa fa-caret-right"></i> High School Students</a></li>
            <li><a href="#"><i class="fa fa-caret-right"></i> Undergrad Students</a></li>
            <li><a href="#"><i class="fa fa-caret-right"></i> Schools</a></li>
            <li><a href="#"><i class="fa fa-caret-right"></i> Health Career Events</a></li>
            <li><a href="#"><i class="fa fa-caret-right"></i> Clubs</a></li>
          </ul>
        </li>
        <li class="nav-parent"><a href="#"><i class="fa fa-user-md"></i> <span class="gold-letters">Continuing Education</span></a>
          <ul class="children">
            <li><a href="#"><i class="fa fa-caret-right"></i> Programs</a></li>
            <li><a href="#"><i class="fa fa-caret-right"></i> Events</a></li>
            <li><a href="#"><i class="fa fa-caret-right"></i> Topics</a></li>
          </ul>
        </li>        
        <li class="nav-parent"><a href="#"><i class="fa fa-hospital-o"></i> <span class="gold-letters">Community Health</span></a>
          <ul class="children">
            <li><a href="#"><i class="fa fa-caret-right"></i> Programs</a></li>
          </ul>
        </li>        
        <li><a href="#"><i class="fa fa-laptop"></i> <span class="gold-letters">Reports</span></a></li>
      </ul><!-- infosummary -->
      
    </div><!-- leftpanelinner -->
  </div>