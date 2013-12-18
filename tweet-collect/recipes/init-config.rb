# configuration Fedora Linux

execute "yum-update" do
  command "sudo yum -y update"
  action :run
end

# initialized configuration
execute "locale-to-ja" do
  command "sudo cp /usr/share/zoneinfo/Japan /etc/localtime"
  action :run
end

package "unzip" do
  action :install
end

package "git" do
  action :install
end

package "java" do
  version "1.7.0"
  action :install
end

# open firewall-port 8080
execute "open-firewall-port" do
  command "sudo firewall-cmd --permanent --add-port=8080/tcp"
  action :run
  
  # execute "service firewalld restart" after this command finished.
  notifies :restart, 'service[firewalld]'
end

service "firewalld" do
  
  # firewalld service has options status, restart and reload.
  supports :status => true, :restart => true, :reload => true
  
  # enable service when machine launchs and start service.
  action [ :enable, :start ]
  
end
