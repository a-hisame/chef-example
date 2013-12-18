# download and deploy about tomcat.

download_path = node["application"]["repository"]["path"]

directory download_path do
  action :create
end

################################################
# download and unzip files
################################################

download_list = [
  # apache-tomcat
  {
    "file" => "apache-tomcat-7.0.47.zip",
    "url" => "http://ftp.jaist.ac.jp/pub/apache/tomcat/tomcat-7/v7.0.47/bin/apache-tomcat-7.0.47.zip",
    "directory" => "apache-tomcat-7.0.47"
  },
  # birt runtime
  {
    "file" => "birt-runtime-4_3_1.zip",
    "url" => "http://ftp.yz.yamagata-u.ac.jp/pub/eclipse//birt/downloads/drops/R-R1-4_3_1-201309181142/birt-runtime-4_3_1.zip",
    "directory" => "birt-runtime-4_3_1"
  },
  # connector-j
  {
    "file" => "mysql-connector-java-5.1.27.zip",
    "url" => "http://cdn.mysql.com/Downloads/Connector-J/mysql-connector-java-5.1.27.zip",
    "directory" => "mysql-connector-java-5.1.27"
  }
]

download_list.each do |info|
  file = info['file']
  url  = info['url']
  directory = info['directory']
  
  execute "download #{file}" do
    command "curl -o #{download_path}/#{file} #{url}"
    action :run
    not_if { ::File.exists?("#{download_path}/#{file}") }
  end
  
  execute "unzip #{file}" do
    command "unzip #{download_path}/#{file} -d #{download_path}"
    action :run
    not_if { ::File.exists?("#{download_path}/#{directory}") }
  end
end

################################################
# deploy tomcat and others
################################################

install_target = node["tomcat"]["path"]

# install tomcat-server
execute "deploy tomcat" do
  command "sudo cp -rf #{download_path}/apache-tomcat-7.0.47 #{install_target}"
  action :run
  not_if { ::File.exists?("#{install_target}") }
end

execute "deploy birt runtime" do
  command "sudo cp #{download_path}/birt-runtime-4_3_1/birt.war #{install_target}/webapps/"
  action :run
  not_if { ::File.exists?("#{install_target}/webapps/birt.war") }
end

execute "deploy connect-j" do
  command "sudo cp #{download_path}/mysql-connector-java-5.1.27/mysql-connector-java-5.1.27-bin.jar #{install_target}/lib/"
  action :run
  not_if { ::File.exists?("#{install_target}/lib/mysql-connector-java-5.1.27-bin.jar") }
end

execute "setup execute-mode" do
  command "chmod 755 #{install_target}/bin/*.sh"
  action :run
end

# birt.war extraction
execute "start tomcat" do
  command <<-EOH
    sudo #{install_target}/bin/startup.sh
    sleep 10
    curl http://localhost:8080/birt/ 2&>1 > /dev/null
    sudo #{install_target}/bin/shutdown.sh
  EOH
  action :run
  not_if { ::File.exists?("#{install_target}/webapps/birt/report.rptdesign") }
end


