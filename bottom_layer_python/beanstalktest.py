from beanstalk import serverconn
from beanstalk import job

server = '127.0.0.1'
port = 11300

if __name__=="__main__":
	connection = serverconn.ServerConn(server, port)
	connection.job = job.Job
	data = job.Job(data="test", conn=connection)
	data.Queue()
