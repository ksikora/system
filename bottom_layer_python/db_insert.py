import time
from bsddb3 import db
        
if __name__=="__main__":        
    cnt = 0
    
    try:
        while True:
            
            try:
                berkdb = db.DB()
                berkdb.open('clickstream', None, db.DB_QUEUE, db.DB_DIRTY_READ)
            except:
                print 'error connecting'
                time.sleep(0.1)
                continue
            print len(berkdb)
            if len(berkdb)>0:
                print "item pulled from bsddb"
                cursor = berkdb.cursor()
                rec = cursor.consume()
                cursor.close()
                print rec
                #TODO WSADZANIE DO DB NORMALNEJ
                cnt = cnt + 1
                
            else:
                time.sleep(0.1)
                continue
            
            berkdb.sync()
            berkdb.close()
    finally:    
        print "item pulled from bdb: ",cnt
    
    
        
        
