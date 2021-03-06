# ----------------------------------------------------------------------------
#  Copyright 2005-2013 WSO2, Inc. http://www.wso2.org
#
#  Licensed under the Apache License, Version 2.0 (the "License");
#  you may not use this file except in compliance with the License.
#  You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
#  Unless required by applicable law or agreed to in writing, software
#  distributed under the License is distributed on an "AS IS" BASIS,
#  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#  See the License for the specific language governing permissions and
#  limitations under the License.
# ----------------------------------------------------------------------------
#

# ESB cartridge node
node /[0-9]{1,12}.manager.esb/ inherits base {
  $docroot = "/mnt/${server_ip}/wso2esb-4.8.1"
  require java
  class {'python_agent':}
  class {'esb':

        version            => '4.8.1',
        sub_cluster_domain => 'mgt',
        members            => undef,
	port_mapping       => { 80 => 9763, 443 => 9443, 8280 => 8280, 8243 => 8243},
        offset             => 0,
        hazelcast_port     => 4000,
        config_db          => 'ESB_CONFIG_DB',
	config_target_path => 'ESB_CONFIG_PATH',
        maintenance_mode   => 'zero',
        depsync            => false,
        clustering         => 'true',
        cloud              => true,
        owner              => 'root',
        group              => 'root',
        target             => "/mnt/${server_ip}",
        stratos_instance_data_deployment => 'manager'
	

  }

  Class['stratos_base'] -> Class['java'] -> Class['esb'] ~> Class['python_agent']
}

node /[0-9]{1,12}.worker.esb/ inherits base {
  $docroot = "/mnt/${server_ip}/wso2esb-4.8.1"
  require java
  class {'python_agent':}
  class {'esb':

        version            => '4.8.1',
        sub_cluster_domain => 'worker',
        members            => undef,
        port_mapping       => { 80 => 9763, 443 => 9443, 8280 => 8280, 8243 => 8243},
        offset             => 0,
        hazelcast_port     => 4000,
        config_db          => 'ESB_CONFIG_DB',
        config_target_path => 'ESB_CONFIG_PATH',
        maintenance_mode   => 'zero',
        depsync            => false,
        clustering         =>'true',
        cloud              => true,
        owner              => 'root',
        group              => 'root',
        target             => "/mnt/${server_ip}",
	stratos_instance_data_deployment => 'worker'

  }

  Class['stratos_base'] -> Class['java'] -> Class['esb'] ~> Class['python_agent']
}


