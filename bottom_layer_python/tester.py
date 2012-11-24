import sys
sys.path.append("lib/")

import traceback
from beanstalk import serverconn
from beanstalk import job



server = '127.0.0.1'
port = 12346

def poll(persserv, persport):
    
    connectionpers = serverconn.ServerConn(persserv, persport)
    connectionpers.job = job.Job
    i = 0
    try:
        while True:
            j = connectionpers.reserve()
            i=i+1
            j.Finish()
	
    finally:
        print "messages pulled from queue ", i        




if __name__ == "__main__":
    poll(server, port)  
