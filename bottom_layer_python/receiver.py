import sys
sys.path.append("lib/")
from twisted.internet.protocol import DatagramProtocol
from twisted.internet import reactor

from beanstalk import serverconn
from beanstalk import job

class Echo(DatagramProtocol):
	
	def __init__(self,server, port):
		self.connection = serverconn.ServerConn(server, port)
		self.connection.job = job.Job
	
	i = 0
	
	def datagramReceived(self, data2, (host, port)):
		self.i=self.i+1
		data1 = job.Job(data=data2, conn=self.connection)
		data1.Queue()
		self.i=self.i+1

	def ret(self):
		return self.i



def receive(server,port):
	received = Echo(server, port)
	
	try:
		reactor.listenUDP(10001, received)
		reactor.run()
	#except:
	finally:
		print 'failed'
		print received.ret()
	#while True:
		
		
