# ssd
ssd=/dev/$ssd/sda4;
sudo mkfs.ext4 $ssd;
dir=/users/tianyige/mnt;
sudo mkdir -p $dir;
sudo mount $ssd $dir;
sudo chown -R tianyige $dir;
echo $ssd' '$dir' ext4 defaults 0 0' | sudo tee -a /etc/fstab;

# python
sudo apt update;
sudo apt install -y python3.7 python3-pip;
sudo apt install -y libcurl4-openssl-dev python3.7-dev libssl-dev;
python3 -m pip install pip virtualenv;
sudo apt install -y python3-venv;
sudo apt install -y python3.7-venv;
python3.7 -m pip install pip virtualenv;
mkdir -p ~/.pyenv;
python3 -m venv ~/.pyenv/3.6;
python3.7 -m venv ~/.pyenv/3.7;
. ~/.pyenv/3.7/bin/activate;

# gcc
sudo add-apt-repository ppa:ubuntu-toolchain-r/test;
sudo apt update;
sudo apt install -y gcc-9 g++-9 liblzma-dev;
cd /usr/bin;
sudo mv gcc gcc.back;
sudo mv g++ g++.back;
sudo ln -s gcc-9 gcc;
sudo ln -s g++-9 g++;

# isa-l
sudo apt update;
sudo apt install -y nasm dh-autoreconf;
cd ~/mnt;
wget https://github.com/intel/isa-l/archive/v2.29.0.zip && unzip *.zip;
cd isa-l-2.29.0;
./autogen.sh;
./configure --prefix=/usr --libdir=/usr/lib;
make;
sudo make install;

# mongo-git
cd /users/tianyige/mnt;
git clone --depth 1 https://40c404c90c0f9f515afc10a0d8ee8169dcb0379d@github.com/tianyi-ge/mongo.git -b v4.4-ec;
cd mongo;

echo 'alias buildd="python3 buildscripts/scons.py install-mongod --disable-warnings-as-errors --quiet MONGO_VERSION=4.4.0"' >> ~/.bashrc;
echo '. ~/.pyenv/3.7/bin/activate' >> ~/.bashrc;
. ~/.bashrc;
python3 -m pip install -r etc/pip/compile-requirements.txt;

# mongo
wget -qO - https://www.mongodb.org/static/pgp/server-4.4.asc | sudo apt-key add -;
echo "deb [ arch=amd64,arm64 ] https://repo.mongodb.org/apt/ubuntu bionic/mongodb-org/4.4 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-4.4.list;
sudo apt-get update;
sudo apt-get install -y mongodb-org=4.4.0 mongodb-org-server=4.4.0 mongodb-org-shell=4.4.0 mongodb-org-mongos=4.4.0 mongodb-org-tools=4.4.0;

# java
sudo apt install -y openjdk-8-jdk rsync;

# maven
sudo apt install -y maven;
echo 'export M2_HOME=/usr/share/maven' | sudo tee -a /etc/profile.d/maven.sh;
echo 'export PATH=${M2_HOME}/bin:${PATH}' | sudo tee -a /etc/profile.d/maven.sh;

# ycsb
cd ~/mnt
wget https://github.com/brianfrankcooper/YCSB/releases/download/0.17.0/ycsb-mongodb-binding-0.17.0.tar.gz;
tar xvf ycsb-mongodb-binding-0.17.0.tar.gz;
mv ycsb-mongodb-binding-0.17.0 ycsb;
rm *.tar.gz *.zip

# copy
cd ~/mnt/mongo/build/install/bin;
strip -sg mongod -o mongodec;
for id in 2 3 4 5
do
    scp ./mongodec tianyige@10.10.1.$id:~/mnt/mongodec;
    ssh -p 22 10.10.1.$id "sudo ln -s ~/mnt/mongodec /usr/bin/mongodec";
done
