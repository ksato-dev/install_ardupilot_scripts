#!/usr/bin/bash
# input user name on console
echo -n INPUT_YOUR_NAME: 
read your_name

# apt-get update & upgrade 
sudo apt-get update -y
sudo apt-get upgrade -y

# prepare ardupilot (for Copter-4.0) install
# sudo apt-get install git -y
sudo apt-get install python3-dev python3-opencv python3-pip python3-matplotlib python3-lxml python3-yaml -y
sudo apt-get install python-wxgtk3.0 python-pygame -y
pip install MAVProxy	
sudo apt-get install gcc-arm-none-eabi -y
echo "export PATH=$PATH:$HOME/.local/bin" >> ~/.bashrc
sudo adduser $your_name dialout 

# install ardupilot
git clone https://github.com/ksato-dev/ardupilot.git   # clone
cd ardupilot   # ディレクトリ（フォルダ）変更
git submodule update --init --recursive   # サブモジュールのアップデート
git checkout -b create_new_flight_mode origin/create_new_flight_mode   # 開発用ブランチにチェックアウト
sudo ./Tools/enviroment_install/install-prereqs-ubuntu.sh   # Ubuntu 用インストールスクリプト実行
./waf configure
./Tools/autotest/sim_vehicle.py -v ArduCopter --console --map   # SITL 実行 & MAVProxy 実行（コンソール＋ map オプション）

