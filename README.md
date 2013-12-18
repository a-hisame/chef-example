chef-example
============

example cookbook for study

Windows7上のvagrant(Fedora19)で動作確認をしています。

標準のsolo-config.rbを利用する場合、以下のようにすると楽です。

1. ```cd /home/vagrant/```
2. ```git clone https://github.com/a-hisame/chef-example.git cookbooks```
3. ```chef-solo -c solo-config.rb -j node.json```


