# ServTools 
### scripts for working on servers:

this repo contains 

setup a ruby server

    install.sh

setup virtualhosts 

    lib/sites.rb


ping util:

    lib/pingproxy.rb


mysql backup dbs and upload to s3 tool:

    lib/mysql.rb


### TODO:

- partitioning script

setup partitions:

1.8T total = 450GB each

/home     
/opt
/www
/var/log


- restore mysql backups

- remove duplication by requiring and including code packaged in modules

- bandwith testing: test donwload/upload of large file ( http://london1.linode.com/100MB-london.bin )