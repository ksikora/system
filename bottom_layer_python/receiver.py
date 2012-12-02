import sys
sys.path.append("lib/")
from twisted.internet.protocol import DatagramProtocol
from twisted.internet import reactor
from multiprocessing import Process, Queue, Array, Value
from beanstalk import serverconn
from beanstalk import job
import time

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
		global rt_bs_con
		data2 = job.Job(data=msg[0], conn=rt_bs_con)
		global rtDevices
		global index
		pid = data2.data.split(":")[0]
		tmp = False
		for i in range(0,index.value):
			if rtDevices[i] == int(pid):
				tmp = True
				break
		if tmp == True:
			data2.Queue()
		data1.Queue()
		

rt_bs_con = None
rtDevices = None
index = None

def receive(server,port, rt_port):
	queue = Queue()
	global rtDevices
	global index
	rtDevices = Array('i',range(100))
	index = Value('i',0)
	rtUpdaterProcess = Process(target=updateRTList, args=(rtDevices, index,))
	rtUpdaterProcess.start()
	global rt_bs_con
	rt_bs_con = serverconn.ServerConn(server, rt_port)
	rt_bs_con.job = job.Job
	received = Echo(queue)
	receiver_process = Process(target=receiveFromProcessQueue, args=(queue, server, port,))
	receiver_process.start()
	try:
		reactor.listenUDP(10001, received)
		reactor.run()
	#except:
	finally:
		receiver_process.terminate()
		rtUpdaterProcess.terminate()
	#while True:

	
	
#def checkIfRt(data):



def updateRTList(rtDevs, ind):
	while(True):
		line = open("../plik.tmp","r").readline().split(" ")
		try:
			for i in range(0,len(line)):
				rtDevs[i] = int(line[i])
		except:
			continue
		ind.value = len(line)
		time.sleep(2)
