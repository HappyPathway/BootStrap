#!/usr/bin/env python
import sys
from boto import ec2
e_conn = ec2.connect_to_region('us-east-1')
print "cleaing AWS for {0}".format(sys.argv[1])
for x in e_conn.get_only_instances(filters={"tag:env": sys.argv[1]}):
    x.terminate()
