#!/usr/bin/env bash

set +e


echo "alias dc1-spine1='sshpass -p ansible ssh -o \"StrictHostKeyChecking no\" ansible@172.16.1.11'" >> ~/.zshrc
echo "alias dc1-spine2='sshpass -p ansible ssh -o \"StrictHostKeyChecking no\" ansible@172.16.1.12'" >> ~/.zshrc
echo "alias dc1-leaf1a='sshpass -p ansible ssh -o \"StrictHostKeyChecking no\" ansible@172.16.1.101'" >> ~/.zshrc
echo "alias dc1-leaf1b='sshpass -p ansible ssh -o \"StrictHostKeyChecking no\" ansible@172.16.1.102'" >> ~/.zshrc
echo "alias dc1-leaf2a='sshpass -p ansible ssh -o \"StrictHostKeyChecking no\" ansible@172.16.1.103'" >> ~/.zshrc
echo "alias dc1-leaf2b='sshpass -p ansible ssh -o \"StrictHostKeyChecking no\" ansible@172.16.1.104'" >> ~/.zshrc
echo "alias dc1-leaf1c='sshpass -p ansible ssh -o \"StrictHostKeyChecking no\" ansible@172.16.1.151'" >> ~/.zshrc
echo "alias dc1-leaf2c='sshpass -p ansible ssh -o \"StrictHostKeyChecking no\" ansible@172.16.1.152'" >> ~/.zshrc

echo "alias dc1-leaf1-server1='sshpass -p ansible ssh -o \"StrictHostKeyChecking no\" ansible@172.16.1.201'" >> ~/.zshrc
echo "alias dc1-leaf2-server1='sshpass -p ansible ssh -o \"StrictHostKeyChecking no\" ansible@172.16.1.202'" >> ~/.zshrc