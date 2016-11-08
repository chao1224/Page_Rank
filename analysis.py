import re
import sys
from math import *

if __name__ == "__main__":
    network = {}
    disk = {}
    is_start = False
    curr_machine = ""
    curr_job = ""
    file_path = sys.argv[1]
    with open(file_path) as f:
        for line in f:
            if re.search("##", line):
                continue
            if re.search("#", line):
                curr_machine = line.split(" ")[1]
                if not is_start:
                    print curr_machine
                continue
            if re.search("@", line):
                curr_job = line.split(" ")[1]
                print curr_job
                network = {}
                disk = {}
                curr_machine = ""
                curr_job = ""
                continue
            if re.search("Start*", line):
                is_start = True
            if re.search("End*", line):
                is_start = False
            if re.search("eth0:.+", line):
                nets = re.split("\s+", line.strip())
                if is_start:
                    network[curr_machine] = [int(nets[1]), int(nets[9])]
                else:
                    print "total_net_receive:",  abs(network[curr_machine][0] - int(nets[1]))
                    print "total_net_transmit:",  abs(network[curr_machine][1] - int(nets[9]))
                    network[curr_machine][0] -= int(nets[1])
                    network[curr_machine][1] -= int(nets[9])
            if re.search(".+vda1.+", line):
                disks = re.split("\s+", line.strip())
                if is_start:
                    disk[curr_machine] = [int(disks[5]), int(disks[9])]
                else:
                    print "total_disk_read:",  abs(disk[curr_machine][0] - int(disks[5]))
                    print "total_disk_write:",  abs(disk[curr_machine][1] - int(disks[9]))
                    disk[curr_machine][0] -= int(disks[5])
                    disk[curr_machine][1] -= int(disks[9])
    print(network)
    print(disk)

    network_i = 0
    network_o = 0
    disk_i = 0
    disk_o = 0
    for i in range(5):
        key = "VM{}\n".format(i+1)
        network_i -= network[key][0]
        network_o -= network[key][1]
        disk_i -= disk[key][0]
        disk_o -= disk[key][1]
    print(network_i/1024/1024)

    print(network_o/1024/1024)

    print(disk_i/2/1024)

    print(disk_o/2/1024)



