chef-example
============

example cookbook for study

Windows7上のvagrant(Fedora19)で動作確認をしています。

標準のsolo-config.rbを利用する場合、以下のようにすると楽です。

1. ```curl -L http://www.opscode.com/chef/install.sh | sudo bash```
2. ```sudo yum install git```
3. ``cd /home/vagrant/```
4. ```git clone https://github.com/a-hisame/chef-example.git cookbooks```
5. ```chef-solo -c solo-config.rb -j node.json```


