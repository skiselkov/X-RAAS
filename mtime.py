#!/usr/bin/python

import os, sys, time

for i in range(1, len(sys.argv)):
	(mode, ino, dev, nlink, uid, gid, size, atime, mtime, ctime) = (
	    os.stat(sys.argv[i]))
	print mtime
#for 
