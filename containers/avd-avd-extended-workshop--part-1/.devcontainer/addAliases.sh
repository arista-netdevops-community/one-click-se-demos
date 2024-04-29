#!/usr/bin/env bash

set +e


echo "alias dc1-leaf1-server1='sshpass -p arista ssh -o \"StrictHostKeyChecking no\" arista@172.16.1.201'" >> ~/.zshrc
echo "alias dc1-leaf2-server1='sshpass -p arista ssh -o \"StrictHostKeyChecking no\" arista@172.16.1.202'" >> ~/.zshrc