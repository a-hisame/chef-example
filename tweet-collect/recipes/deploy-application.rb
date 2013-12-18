################################################
# deploy application
################################################

# shells
template "deploy get-tweet.sh" do
  source "get-tweet.sh.erb"
  path "#{node["application"]["path"]}/get-tweet.sh"
  mode 00644
  action :create
  variables({
    :keyword => node["tweet-collect"]["keyword"],
    :mysql_user => node["mysql"]["user"]["name"],
    :mysql_password => node["mysql"]["user"]["password"]
  })
end

# birt applications
template "deploy report.rptdesign" do
  source "report.rptdesign.erb"
  path "#{node["tomcat"]["birt"]["path"]}/report.rptdesign"
  mode 00644
  action :create
  variables({
    :database => {
      "host" => "localhost",
      "port" => "3306",
      "scheme" => "tweet_collect",
      "username" => node["mysql"]["user"]["name"],
      "base64password" => node["mysql"]["user"]["base64password"],
    }
  })
end

cookbook_file "deploy report.rptconfig" do
  path "#{node["tomcat"]["birt"]["path"]}/report.rptconfig"
  source "report.rptconfig"
  mode 00644
end
