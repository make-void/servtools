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


