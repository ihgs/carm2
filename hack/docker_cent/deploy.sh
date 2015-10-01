#!/bin/bash
pushd $(dirname $0)
vagrant ssh -- ./deploy.sh
popd

