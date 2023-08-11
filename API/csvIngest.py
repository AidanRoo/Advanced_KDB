import pykx as kx
from numpy import genfromtxt
import numpy
import time

def read_csv(filename):
        data = genfromtxt(filename, delimiter=',', dtype=("|S10", float,int))
        return data

conn=kx.QConnection('localhost', 5010)

for row in read_csv('/home/arooney1_kx_com/Advanced_KDB/API/pytrade.csv'): 
    tick = [numpy.string_(row[0]).decode('utf-8'),
            numpy.float_(row[1]),
            numpy.int_(row[2])] 
    print('Publishing record...')
    print(tick)
    conn('.u.upd', 'trade', tick)
    time.sleep(1)
