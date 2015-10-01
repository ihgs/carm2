#!/bin/bash
pushd $(dirname $0)
cat <<EOS | vagrant ssh -- 
cd /opt/cram
docker-compose -f docker-compose_dev.yml up -d
EOS
popd

