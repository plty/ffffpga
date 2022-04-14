#!/bin/bash

openocd -d -f ./pynq.cfg -c "init; pld load 0 $1.bit; exit"
