# Starts the service once the deployment is successful.

define esb::push_host ($lb_ip,$mgt_host,$wrk_host,$owner) {
 host { 'Add Mgt Host Name':
 	name   => "${mgt_host}",
   	ensure => 'present',       
    	target => '/etc/hosts', 
	comment => '<load balancer IP> <Manager Hostname>',   
    	ip => "${lb_ip}",         
  }

 host { 'Add Worker Host Name':
 	name   => "${wrk_host}",
   	ensure => 'present',       
    	target => '/etc/hosts',  
	comment => '<load balancer IP> <Worker Hostname>',  
    	ip => "${lb_ip}",     
    
  }

}


