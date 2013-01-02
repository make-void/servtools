# ServTools 
### ruby scripts for managing app servers:

this repo contains multiple scripts, here's a list with some:

- **install.sh:** setups a ruby server

the following scripts are in `lib` directory

- **sites:** setups nginx virtualhost (supported configs: static html, rack, php, fiveserv, ...)
- **checker:** checks if the remote page is served correctly by matching a given string
- **pingproxy:** pings domain from multiple locations (use it to test your hosting providers / CDN)
- **mysql:**  backup dbs an upload them to S3
- **mysqlr:** restore mysql backups from S3
- **update_libs:** checks if all the JS libraries of your projects are updated (es. latest jquery, underscore, ...) [unfinished]
- **utils:** ruby helpers to execute and log local and remote commands (ssh)

and more!
all the scripts are in lib!

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
