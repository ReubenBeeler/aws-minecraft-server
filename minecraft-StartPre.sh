#!/bin/bash

cp -r $EBS/minecraft $MC_PATH

if [[ ! -p $MC_FIFO ]]; then
    mkfifo -m 660 $MC_FIFO
fi
