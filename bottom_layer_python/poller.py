
import sys
sys.path.append("lib/")

import traceback
from beanstalk import serverconn
from beanstalk import job


server = '127.0.0.1'
port = 11300

def poll(memserv, memport, persserv, persport, rt_port):
    connection = serverconn.ServerConn(memserv, memport)
    connection.job = job.Job
    connectionpers = serverconn.ServerConn(persserv, persport)
    connectionpers.job = job.Job
    i = 0
    try:
        while True:
            try:
                j = connection.reserve()
            except:
                print 'i chuj'
                continue
            j.conn = connectionpers
            j.Queue()
            i=i+1
            j.Finish()
	
    finally:
        print "messages pulled from queue ", i , "assssssssssssssssssssssssssss"
