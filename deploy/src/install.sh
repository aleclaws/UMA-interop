#!/bin/bash


function prepareSources {
    echo "deb https://repo.gluu.org/ubuntu/ trusty-devel main" > /etc/apt/sources.list.d/gluu-repo.list
    curl https://repo.gluu.org/ubuntu/gluu-apt.key | apt-key add -
    add-apt-repository ppa:openjdk-r/ppa -y
    echo "deb http://apt.postgresql.org/pub/repos/apt/ trusty-pgdg main" > /etc/apt/sources.list.d/psql.list
    wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo apt-key add -
    curl -sL https://deb.nodesource.com/setup_8.x | sudo -E bash -
}


function installGG {
 apt update
 apt install gluu-gateway -y
}

function configureGG {
 sed -i "18ihost: '0.0.0.0'," /opt/gluu-gateway/konga/config/env/development.js
 cd /opt/gluu-gateway/setup
 python setup-gluu-gateway.py '{"oxdAuthorizationRedirectUri":"dev1.gluu.org","license":true,"ip":"104.131.18.41","hostname":"dev1.gluu.org","countryCode":"TS","state":"Test","city":"Test","orgName":"Test","admin_email":"admin@test.com","pgPwd":"test123","installOxd":true,"kongaOPHost":"ce-dev6.gluu.org","oxdServerOPDiscoveryPath":"oxauth","oxdServerLicenseId":"b9d9140e-0732-4a96-b4be-215597377a10","oxdServerPublicKey":"47SbaB5bmXBXpKWgtMGNot9CIN++xJITnqlOsCRsQA4swMFwPeSIBIyPqSPB0qBGBCvI9ER0FTYqH9z6XnRJ1txNdzc0voY/SDGw+OQe0emC3HgXax0+lR4JsYkuQ3C+cnfqyunHQgnwDVcx4fS0MvxWewu03q9ppc1UlImNe7nesm3tzP0dsvVkEMeAWyEbrsu58JzUmFDGDzl0sVKjtBs+czf1ETWd48q5a3IDq5DNSbT4E4Hr3dmLz72nEPBr9Bsoqik4wWiGl8YMa9w4BZiKZQjoIfvboxSwhJRy1kKCEzi/kJqLX6EZ/cCUw8fgn/Xu2Kaov8CI7dtOSi3DqKWQbcDdRpoZJTas+6uyux4tMzZPnblfYnlPaDJRBt9WOgL4SWBdoukw9/QXubXSEA==","public_password":"3Rczv1eJ0sDnFOGLLEkX","oxdServerPublicPassword":"3Rczv1eJ0sDnFOGLLEkX","oxdServerLicensePassword":"a7rkv7VCFOum40eFtfbL","kongaOxdWeb":"https://localhost:8443","generateClient":true}'
}

function createSwap {
    fallocate -l 4G /swapfile
    chmod 600 /swapfile
    mkswap /swapfile
    swapon /swapfile
}

createSwap
prepareSources
installGG
configureGG


