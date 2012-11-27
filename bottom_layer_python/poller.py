
import sys
sys.path.append("lib/")

import traceback
from beanstalk import serverconn
from beanstalk import job


server = '127.0.0.1'
port = 11300

rt_bs_con = 0

def poll(memserv, memport, persserv, persport, rt_port):
    global rt_bs_con
    rt_bs_con = serverconn.ServerConn(memserv, rt_port)
    connection = serverconn.ServerConn(memserv, memport)
    connection.job = job.Job
    connectionpers = serverconn.ServerConn(persserv, persport)
    connectionpers.job = job.Job
    i = 0
    try:
        while True:
            j = connection.reserve()
            j.conn = connectionpers
            rt_process(j)
            j.Queue()
            i=i+1
            j.Finish()
	
    finally:
        print "messages pulled from queue ", i        



def rt_process(data):
		j.conn = rt_bs_con
		j.Queue
