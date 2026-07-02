import os
import subprocess
import sys
import time
import threading

class ParcessThread(threading.Thread):

    def __init__(self,maxtime):
        super(ParcessThread,self).__init__()
        self.runtime=0
        self.count = 0
        self.lasttime = time.time();
        self.maxtime = maxtime;

    def run(self):


        arg1ops= ['read','toggle']


        if len(sys.argv) != 2 or sys.argv[1] not in arg1ops:
            print(f'Usage: {sys.argv[0]} [read|toggle]')
            sys.exit(-1)


        activeStatus = ""
        outline = subprocess.getoutput("systemctl status bluetooth.service")
         #check_ou(['systemctl','status','bluetooth.service'])
        #print(outline)
        outlines = outline.splitlines()
        for i in outlines:

            for k in i.split(" "):
                #print(k)
                           if k == "Active:":
                               #print(k)
                               activeStatus= i.split(":")[1].split(" ")[1]






        if sys.argv[1]=='read':

            if activeStatus== 'active':
                print("〈 b  t〉") 
            else:

                print("［B＼T］")
            
            #while(self.runtime*1000<self.maxtime):
             #       temptime = time.time();
              #      diff= (temptime - self.lasttime)

               #     self.runtime = self.runtime + diff
                #    self.lasttime = temptime;
                    

            time.sleep(2)
           # self.runtime = self.runtime + diff
        else:
            if activeStatus == 'active':
                subprocess.getoutput("sudo systemctl stop bluetooth.service")
            else:
                subprocess.getoutput("sudo systemctl start bluetooth.service")



if __name__ == '__main__':

    while sys.argv[1]=='read':
        thread = ParcessThread(1000);
        thread.start();
        thread.join();

    thread2 = ParcessThread(1000);
    thread2.start();
    thread2.join();
