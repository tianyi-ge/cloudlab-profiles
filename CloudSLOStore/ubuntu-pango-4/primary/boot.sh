# ssd
ssd=/dev/$ssd/sda4;
sudo mkfs.ext4 $ssd;
dir=/users/tianyige/mnt;
sudo mkdir -p $dir;
sudo mount $ssd $dir;
sudo chown -R tianyige $dir;
echo $ssd' '$dir' ext4 defaults 0 0' | sudo tee -a /etc/fstab;

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

# mongo
wget -qO - https://www.mongodb.org/static/pgp/server-4.4.asc | sudo apt-key add -;
echo "deb [ arch=amd64,arm64 ] https://repo.mongodb.org/apt/ubuntu bionic/mongodb-org/4.4 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-4.4.list;
sudo apt update;
sudo apt install -y mongodb-org=4.4.0 mongodb-org-server=4.4.0 mongodb-org-shell=4.4.0 mongodb-org-mongos=4.4.0 mongodb-org-tools=4.4.0;

