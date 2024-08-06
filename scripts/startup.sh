#!/bin/bash
# 开机启动clash
nohup /root/clash-for-IPFire/bin/clash-linux-amd64 -d /root/clash-for-IPFire/conf &> /root/clash-for-IPFire/logs/clash.log &