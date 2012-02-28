mkdir -p /root/tmp
cd /root/tmp


# vim /etc/ssh/sshd_config 
# edit PermitRootLogin to yes

# in bashrc
export PATH="/usr/local/bin:$PATH"


wget http://download.fedora.redhat.com/pub/epel/5/x86_64/libyaml-0.1.2-3.el5.i386.rpm

yum localinstall libyaml-0.1.2-3.el5.i386.rpm --nogpgcheck -y

wget http://download.fedora.redhat.com/pub/epel/5/x86_64/libyaml-devel-0.1.2-3.el5.i386.rpm

yum localinstall libyaml-devel-0.1.2-3.el5.i386.rpm --nogpgcheck -y



rpm -Uvh http://repo.webtatic.com/yum/centos/5/latest.rpm
yum install --enablerepo=webtatic git-all -y

yum install gcc-c++ -y
yum install curl-devel -y
yum install zlib-devel -y
yum install pcre pcre-devel -y


# install ruby from install.sh

gem i passenger
passenger-install-nginx-module

# passenger_root /usr/local/lib/ruby/gems/1.9.1/gems/passenger-3.0.11;
# passenger_ruby /usr/local/bin/ruby;


# activate repos, set enable to 1
vim /etc/yum.repos.d/webtatic.repo 
vim /etc/yum.repos.d/rhel-source.repo 


# install epel repos
rpm -Uvh http://download.fedora.redhat.com/pub/epel/5/i386/epel-release-5-4.noarch.rpm
# check http://download.fedora.redhat.com/pub/epel/5/i386/ for updates

# mysql rhel: 
# http://adityo.blog.binusian.org/?p=428
# http://php-fpm.org/wiki/Documentation

yum install mysql55 mysql55-devel mysql55-server mysql55-libs -y
yum install libxml2 libxslt -y
