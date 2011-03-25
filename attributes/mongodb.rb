### SOURCE PACKAGES
default[:mongodb][:server][:version]           = "1.8.0"
default[:mongodb][:server][:source]            = "http://fastdl.mongodb.org/linux/mongodb-linux-#{node[:kernel][:machine]}-#{mongodb[:version]}.tgz"

default[:mongodb][:server][:i686][:checksum]   = "bf95eb458ab7302523c402bf35265263"
default[:mongodb][:server][:x86_64][:checksum] = "ab050d8b1a89dd3a52aa93eebcb27487"

### GENERAL
default[:mongodb][:server][:dir]         = "/opt/mongodb-#{mongodb[:version]}" # For install from source
default[:mongodb][:server][:dbpath]      = "/var/lib/mongodb"
default[:mongodb][:server][:config]      = "/etc/mongodb.conf"
default[:mongodb][:server][:logfile]     = "/var/log/mongodb.log"
default[:mongodb][:server][:pidfile]     = "/var/lib/mongodb/mongod.lock"
default[:mongodb][:server][:port]        = 27017

bind_ip = \
  if node[:network][:interfaces][:eth0]
    node[:network][:interfaces][:eth0][:addresses].select{|address, values| values['family'] == 'inet'}.first.first
  else
    "0.0.0.0"
  end

default[:mongodb][:server][:bind_ip] = bind_ip

### EXTRA
default[:mongodb][:server][:cpu]         = false # log cpu and io
default[:mongodb][:server][:auth]        = false
default[:mongodb][:server][:username]    = ""
default[:mongodb][:server][:password]    = ""
default[:mongodb][:server][:verbose]     = false
default[:mongodb][:server][:objcheck]    = false
default[:mongodb][:server][:quota]       = false
default[:mongodb][:server][:diaglog]     = false
default[:mongodb][:server][:nocursors]   = false
default[:mongodb][:server][:nohints]     = false
default[:mongodb][:server][:nohttpinterface] = false
default[:mongodb][:server][:noscripting] = false
default[:mongodb][:server][:notablescan] = false
default[:mongodb][:server][:noprealloc]  = false
default[:mongodb][:server][:nssize]      = false



### STARTUP
default[:mongodb][:server][:rest]        = false
default[:mongodb][:server][:syncdelay]   = 60



### MMS
default[:mongodb][:server][:mms]            = false
default[:mongodb][:server]['mms-token']     = ""
default[:mongodb][:server]['mms-name']      = ""
default[:mongodb][:server]['mms-interval']  = ""



### REPLICATION
default[:mongodb][:server][:replication]   = false
default[:mongodb][:server][:slave]         = false
default[:mongodb][:server][:slave_source]  = ""
default[:mongodb][:server][:slave_only]    = ""

default[:mongodb][:server][:master]        = false
default[:mongodb][:server][:master_source] = ""

default[:mongodb][:server][:autoresync]    = false
default[:mongodb][:server][:oplogsize]     = 0
default[:mongodb][:server][:opidmem]       = 0

default[:mongodb][:server][:replSet]       = ""



### SHARDING
default[:mongodb][:server][:shard_server]  = false



### BACKUP
default[:mongodb][:server][:backup][:host]         = "localhost"
default[:mongodb][:server][:backup][:backupdir]    = "/var/backups/mongodb"
default[:mongodb][:server][:backup][:day]          = 6
default[:mongodb][:server][:backup][:compression]  = "bzip2"
default[:mongodb][:server][:backup][:cleanup]      = "yes"
default[:mongodb][:server][:backup][:latest]       = "yes"
default[:mongodb][:server][:backup][:mailaddress]  = false
default[:mongodb][:server][:backup][:mailcontent]  = "stdout"
default[:mongodb][:server][:backup][:maxemailsize] = 4000


### CONFIG SERVER
default[:mongodb][:config_server][:dbpath]  = "/var/lib/mongodb-config_server"
default[:mongodb][:config_server][:config]  = "/etc/mongodb-config_server.conf"
default[:mongodb][:config_server][:logfile] = "/var/log/mongodb-config_server.log"
default[:mongodb][:config_server][:pidfile] = "/var/lib/mongodb-config_server/mongod.lock"
default[:mongodb][:config_server][:bind_ip] = bind_ip
default[:mongodb][:config_server][:port]    = 27019



### MONGOS
default[:mongodb][:mongos][:config]  = "/etc/mongos.conf"
default[:mongodb][:mongos][:logfile] = "/var/log/mongos.log"
default[:mongodb][:mongos][:pidfile] = "/var/lib/mongodb/mongos.lock"
default[:mongodb][:mongos][:bind_ip] = bind_ip
default[:mongodb][:mongos][:port]    = 27017
