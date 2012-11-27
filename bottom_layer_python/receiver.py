import sys
sys.path.append("lib/")
from twisted.internet.protocol import DatagramProtocol
from twisted.internet import reactor
from multiprocessing import Process, Queue
from beanstalk import serverconn
from beanstalk import job

class Echo(DatagramProtocol):
	
	def __init__(self,queue):
		self.queue = queue
	
	i = 0
	
	def datagramReceived(self, data2, (host, port)):
		self.i=self.i+1
		self.queue.put([data2])

	def ret(self):
		return self.i



def receiveFromProcessQueue(queue, server, port):
	connection = serverconn.ServerConn(server, port)
	connection.job = job.Job
	
	while(True):
		msg = queue.get()
		data1 = job.Job(data=msg[0], conn=connection)
		data1.Queue()
		rt_process(data1)

rt_bs_con = None

def receive(server,port, rt_port):
	queue = Queue()
	global rt_bs_con
	rt_bs_con = serverconn.ServerConn(server, rt_port)
	received = Echo(queue)
	receiver_process = Process(target=receiveFromProcessQueue, args=(queue, server, port,))
	receiver_process.start()
	try:
		reactor.listenUDP(10001, received)
		reactor.run()
	#except:
	finally:
		receiver_process.terminate()
	#while True:

def rt_process(data):
	data.conn = rt_bs_con
	data.Queue
		
