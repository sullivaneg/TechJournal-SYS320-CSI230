#!/bin/bash

ip addr | grep 'inet ' | awk '/brd / {print$2}' | cut -d'/' -f1

 
