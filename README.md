# Quick Server Setup 

See also: [https://github.com/jeffrafter/howto/blob/master/server-security.md](https://github.com/jeffrafter/howto/blob/master/server-security.md)

Grab the latest

    apt-get install git-core
    cd ${HOME}
    git clone git://github.com/jeffrafter/server.git server

Configure your environment variables

    cd ${HOME}/server
    cp script/env.sh.example script/env.sh
    nano script/env.sh
    
The env allows you to configure the necessary vars:

    #!/bin/sh

    $ROOT_PASSWORD="SOME_PASSWORD"
    $DEPLOY_PASSWORD="SOME_PASSWORD"
    $ROOT_EMAIL="root@example.com"
    $OPS_EMAIL="forward@example.com"
    $VIRTUAL_EMAIL="youremail@gmail.com"
    $DOMAIN="example.com"
    $WILDCARD_DOMAIN="*.example.com"
    
    
Run the script:
    
    script/setup.sh

