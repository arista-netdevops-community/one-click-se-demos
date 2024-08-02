#!/usr/bin/env bash

set +e


echo "alias s01='sshpass -p arista ssh -o \"StrictHostKeyChecking no\" arista@10.0.1.1'" >> ~/.zshrc
echo "alias s02='sshpass -p arista ssh -o \"StrictHostKeyChecking no\" arista@10.0.1.2'" >> ~/.zshrc
echo "alias l01='sshpass -p arista ssh -o \"StrictHostKeyChecking no\" arista@10.0.2.1'" >> ~/.zshrc
echo "alias l02='sshpass -p arista ssh -o \"StrictHostKeyChecking no\" arista@10.0.2.2'" >> ~/.zshrc

echo "alias h01='sshpass -p arista ssh -o \"StrictHostKeyChecking no\" arista@10.0.3.1'" >> ~/.zshrc