################################################
# install cron and collector
################################################

template "create-crontab-config" do
  source "cronconf.txt.erb"
  path "/tmp/cronconf.txt"
  mode 00644
  action :create
  variables({
    :schedule => "0-59/5 * * * *",
    :application_path => node["application"]["path"],
  })
end

execute "set-cronconfig" do
  command "crontab /tmp/cronconf.txt"
  user "vagrant"
  action :run
end

service "crond" do
  supports :status => true, :restart => true, :reload => true
  action [ :enable, :restart ]
end
