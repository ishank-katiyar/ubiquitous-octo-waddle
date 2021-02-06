# /bin/python3 get_battery_level.py

import subprocess

output = int(subprocess.run("cat /sys/class/power_supply/BAT0/capacity".split(), stdout=subprocess.PIPE).stdout.decode('utf-8'))
print (output, flush=True)
#  battery_level = ""
#  for x in output:
#      if x >= "0" and x <= "9":
#          battery_level += x
#  print (battery_level + "%")

def curBattery():
    return int(subprocess.run("cat /sys/class/power_supply/BAT0/capacity".split(), stdout=subprocess.PIPE).stdout.decode('utf-8'))

prev = curBattery()
print ("ok", flush=True)

#  command1 = 'notify-send \"BATTERY LOW. PLUG IN\"'
command1 = 'notify-send BATTERY_LOW'
command2 = 'notify-send BATTERY_FULL'
print (command1, flush=True)
print (command1.split(), flush=True)
#  subprocess.check_output (command1.split())
#  if (prev == 23):
#      print ("yes")
while True:
    print (prev, flush=True)
    curB = curBattery()
    #  if (prev != curB):
    #      subprocess.run ('notify-send BATCH'.split(), stdout=subprocess.PIPE)
    if (prev != curB and curB == 20 and prev > 20):
        subprocess.run (command1.split(), stdout=subprocess.PIPE)
    if (prev != curB and curB == 95 and prev < 95):
        subprocess.run (command2.split(), stdout=subprocess.PIPE)
    prev = curB
