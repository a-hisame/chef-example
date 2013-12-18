################################################
# install mysql-server
################################################

package "mysql-server" do
  action :install
end

cookbook_file "/etc/my.cnf" do
  mode 00644
end

service "mysqld" do
  supports :status => true, :restart => true, :reload => true
  action [ :enable, :start ]
end

# create user and tables.
template "initialize.sql" do
  source "initialize.sql.erb"
  path "#{node["application"]["repository"]["path"]}/initialize.sql"
  mode 00644
  action :create
  variables({
    :mysql => node["mysql"]
  })
  notifies :run, 'execute[initconfig-mysql-server]'
end

execute "initconfig-mysql-server" do
  command "mysql -u #{node["mysql"]["root"]["user"]} -p#{node["mysql"]["root"]["password"]} < "#{node["application"]["repository"]["path"]}/initialize.sql"
  # only execute notifies.
  action :nothing
end
