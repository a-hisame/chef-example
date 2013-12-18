# chef-example

定期的にTweet情報を取得し、レポート形式で提供するアプリケーションの設定を行います。

Windows7上のvagrant(Fedora19/VirtualBox) + msysgit付属のbash上で動作確認をしています。

## 使い方(Windows向け)

```
# boxの作成と初期化
vagrant box add fedora19 https://dl.dropboxusercontent.com/u/86066173/fedora-19.box
cd {設定ファイルをおきたいディレクトリ}
vagrant init fedora19

# 設定ファイルの編集
vi Vagrantfile
# config.vm.network :private_network...のコメントを外して
# ipの内容を ip: "192.168.222.222" に設定してください。

# 仮想マシンを起動し、sshでログイン
vagrant up
vagrant ssh
```

標準のsolo-config.rbを利用する場合、以下のようにすると楽です。

```
# 初回のみ、chefとgitのインストール
curl -L http://www.opscode.com/chef/install.sh | sudo bash
sudo yum -y install git

# このリポジトリのチェックアウトとchef-soloの実行
cd /home/vagrant/
git clone https://github.com/a-hisame/chef-example.git cookbooks
cd cookbooks
sudo chef-solo -c solo-config.rb -j node.json
```

chef-soloによるcookbookの適用後、以下の手順でTomcatを立ち上げます。

```
sudo /usr/local/apache-tomcat/bin/startup.sh
```

その後、以下のURLにブラウザでアクセスしてください。
また、データが多い場合はレンダリングに時間がかかるかも知れませんので、根気良くお待ちください。

(private_ipなので、仮想マシンを立ち上げているPCからのみしかアクセスできない点に注意してください。)

http://192.168.222.222:8080/birt/frameset?__report=report.rptdesign


