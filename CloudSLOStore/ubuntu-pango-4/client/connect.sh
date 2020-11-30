#!/bin/sh

url='mongodb://10.10.1.2:27017/ycsb?replicaSet=rs0&w=majority&journal=true'
mongo $url

