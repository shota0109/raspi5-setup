# Raspberry Pi セットアップ手順書

## 初期セットアップ
```bash
sudo apt update  
sudo apt install -y raspi-config openssh-server git
```

## SSHに権限を与える
```bash
sudo raspi-config
#interface→ssh→enableで有効

#再起動
sudo reboot
```

## ホストPCからSSH接続
```bash
#raspi5側での操作
ip a
#IPアドレスが表示される

#再インストールされた物なら、ホストPCの設定のリセットを行う
ssh-keygen -R {IPアドレス}

#ホストPCでの操作
ssh {swarmXX}@{IPアドレス}
```

## SSH鍵設定
```bash
ssh-keygen -t ed25519 -C "YOUR-EMAIL"
cat ~/.ssh/id_ed25519.pub
#出力された公開鍵をGitHubに登録(ssh～から始まる文章)
#github→右上のアイコン→setting→SSH and GPG keys→New SSH keys
```

## Dockerのaptリポジトリのセットアップ
```bash
sudo apt-get update
sudo apt-get install -y ca-certificates curl
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update
```

## Dockerパッケージをインストール
```bash
sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
docker -v
```

## Docker Groupへの追加
```bash
cat /etc/group | grep docker

#グループがない場合
sudo groupadd docker

#ユーザをDockerグループに追加
sudo usermod -aG docker {ユーザ名}
sudo reboot

#再接続
ssh {swarmXX}@{IPアドレス}

```
## Dockerサービスの自動起動
```bash
sudo systemctl start docker
sudo systemctl enable docker
```
<<<<<<< HEAD
=======

## ROS2humbleのイメージを取得
```bash
docker pull ros:humble
```

## Dockerコンテナの起動
```bash
docker run -it ros:humble bash
```

### ここからはコンテナ内での操作
## SSHクライアントをインストールする
```bash
cd root

apt update
apt install -y openssh-client

#SSH鍵設定
ssh-keygen -t ed25519 -C "YOUR-EMAIL"
cat ~/.ssh/id_ed25519.pub
#出力された公開鍵をGitHubに登録(ssh～から始まる文章)
#github→右上のアイコン→setting→SSH and GPG keys→New SSH keys
```
## リポジトリクローン
```bash
git clone git@github.com:ProjectArgos/raspi5_setup.git
cd raspi5_setup
```

## セットアップスクリプト実行
```bash
#ファイルに権限を与える
chmod +x ./raspi5_setup.sh
chmod +x update.sh

./raspi5_setup.sh
```
## ワークスペースの更新
```bash
cd raspi5_setup
./update.sh
```