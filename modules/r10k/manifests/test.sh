#!/bin/bash
export git='/usr/local/Cellar/git/2.1.3/bin/git'
for c in $($git --no-pager log -L 5,5:params.pp); do
   echo $c
    #git --no-pager grep  -e '$version.*' $c -- params.pp
done
