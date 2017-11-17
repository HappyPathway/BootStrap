import sys
import os 

pkgs=[x.strip() for x in sys.stdin.read().split(',')]
[os.system('apt-get install -y {0}'.format(pkg)) for pkg in pkgs]
