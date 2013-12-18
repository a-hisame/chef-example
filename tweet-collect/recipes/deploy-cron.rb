################################################
# install cron and collector
################################################

template "create-crontab-config" do
  source "cronconf.txt.erb"
  path "/tmp/cronconf.txt"
  mode 00644
  action :create
  variables({
    :schedule => node["tweet-collect"]["keyword"],
    :application_path => node["application"]["path"],
  })
  notifies :run, 'execute[initconfig-mysql-server]'
end

execute "set-cronconfig" do
  command "crontab /tmp/cronconf.txt"
  user "vagrant"
  action :run
end

