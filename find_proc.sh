#!/bin/bash
# Find top 15 process by top
top -b -o +RES | head -n 22 > sort_mem.sh && tail -n 16 sort_mem.sh > sort_mem_final.sh
awk '{print $1,$2,$6/1024 "MB"}' sort_mem_final.sh