# tweet-collect default attributes

default["application"]["path"]               = "/home/vagrant/tweet-collect"
default["application"]["repository"]["path"] = default["application"]["path"] + "/tmp"

default["tomcat"]["path"] = "/usr/local/apache-tomcat"
default["tomcat"]["webapps"]["path"] = "/usr/local/apache-tomcat/webapps"
default["tomcat"]["birt"]["path"] = "/usr/local/apache-tomcat/webapps/birt"

default["mysql"]["root"]["name"] = "root"
default["mysql"]["root"]["password"] = "rootroot"

default["mysql"]["user"]["name"] = "tweetuser"
default["mysql"]["user"]["password"] = "tweetuser_password"

default["tweet-collect"]["keyword"] = "mail"

