apt-get remove imagemagick

apt-get install libperl-dev gcc libjpeg62-dev libbz2-dev libtiff4-dev libwmf-dev libz-dev libpng12-dev libx11-dev libxt-dev libxext-dev libxml2-dev libfreetype6-dev liblcms1-dev libexif-dev perl libjasper-dev libltdl3-dev graphviz gs-gpl pkg-config -y


mkdir -p ~/tmp
cd ~/tmp


wget ftp://gd.tuwien.ac.at//graphics/ImageMagick/ImageMagick-6.7.3-4.tar.gz
tar xvfz ImageMagick-6.7.3-4.tar.gz

cd ImageMagick-6.7.3-4
./configure
make
sudo make install