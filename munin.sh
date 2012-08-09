# munin install and confs



apt-get install munin munin-node

# copy config/munin/munin.conf  /etc/munin/munin.conf

# copy config/munin/munin-node.conf /etc/munin/munin-node.conf


chown -R munin /www/munin

service munin-node restart
