chef-example
============

example cookbook for study

Windows7上のvagrant(Fedora19)で動作確認をしています。

msysgit付属のbash上で動作を確認しています。

```
# boxの作成と初期化
vagrant box add fedora19 https://dl.dropboxusercontent.com/u/86066173/fedora-19.box
cd {設定ファイルをおきたいディレクトリ}
vagrant init fedora19

# 設定ファイルの編集
vi Vagrantfile

# 仮想マシンを起動し、sshでログイン
vagrant up
vagrant ssh
```

標準のsolo-config.rbを利用する場合、以下のようにすると楽です。

```
# 初回のみ、chefとgitのインストール
curl -L http://www.opscode.com/chef/install.sh | sudo bash
sudo yum install git

# このリポジトリのチェックアウトとchef-soloの実行
cd /home/vagrant/
git clone https://github.com/a-hisame/chef-example.git cookbooks
cd cookbooks
sudo chef-solo -c solo-config.rb -j node.json
```
