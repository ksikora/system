import commands
import os
from multiprocessing import Process
from time import sleep
from receiver import receive
from poller import poll



def init_beanstalk(bs_ports):
    print "Starting memory based beanstalkd on port " + bs_ports[0],
    try:
        os.system("beanstalkd -p "+ bs_ports[0]+" &")
    except:
        print "\t\tFailed."    
    print "\t\tDone."
    sleep(1)
    ps_aux = commands.getoutput('ps aux|grep "beanstalkd -p ' + bs_ports[0] + '"')
    mem_pid = ps_aux.split("\n")[0].split()[1]
    tmp = []
    tmp.append(mem_pid)
    print "Starting persistent beanstalkd on port " + bs_ports[1],
    os.system("beanstalkd -p "+ bs_ports[1]+" -b /home/ksikora/bslog &")
    print "\t\tDone."
    sleep(1)
    ps_aux = commands.getoutput('ps aux|grep "beanstalkd -p ' + bs_ports[1] + '"')
    pers_pid = ps_aux.split("\n")[0].split()[1]
    tmp.append(pers_pid)
    return tmp

def load_beanstalk_ports():
    f = open("conf.ig")
    mem_bs = f.readline().split()[1]
    pers_bs = f.readline().split()[1]
    tmp= []
    tmp.append(mem_bs)
    tmp.append(pers_bs)
    return tmp 

if __name__ == '__main__':
    
    bs_ports = load_beanstalk_ports()
    bs_pids = []
    
    
    try:
        bs_pids = init_beanstalk(bs_ports)
        print "Starting UDP receiver process...",
        receiver_process = Process(target=receive, args=('127.0.0.1', int(bs_ports[0]),))
        receiver_process.start()
        print "\t\t\tDone."
        print "Starting MQ transporter process...",
        poller_process = Process(target=poll, args=('127.0.0.1', int(bs_ports[0]),'127.0.0.1', int(bs_ports[1]),))
        poller_process.start()
        print "\t\t\tDone."
        print "\n\ntype exit to ... surpirise surprise: exit"
        while(True):
            tmp = raw_input("")
            if tmp == 'exit':
                break
            continue
    finally:
        print "\n\nKilling UDP receiver process...",
        receiver_process.terminate()
        print "\t\t\tDone."
        print "Killing MQ transporting process...",
        poller_process.terminate()
        print "\t\t\tDone."
        print 'Killing memory based beanstalkd...',
        os.system("kill -kill " + bs_pids[0])
        print "\t\t\tDone."
        print 'Killing persistent beanstalkd...',
        os.system("kill -kill " + bs_pids[1])
        print "\t\t\tDone."
        
