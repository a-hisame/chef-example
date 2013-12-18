chef-example
============

example cookbook for study

Windows7上のvagrant(Fedora19)で動作確認をしています。

標準のsolo-config.rbを利用する場合、以下のようにすると楽です。

```
curl -L http://www.opscode.com/chef/install.sh | sudo bash
sudo yum install git
cd /home/vagrant/
git clone https://github.com/a-hisame/chef-example.git cookbooks
cd cookbooks
sudo chef-solo -c solo-config.rb -j node.json
```
