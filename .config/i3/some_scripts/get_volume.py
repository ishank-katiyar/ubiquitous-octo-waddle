#/bin/python3 get_volume.py


import subprocess

output = subprocess.Popen("pactl list sinks".split(), stdout=subprocess.PIPE)
# print (output)
output = subprocess.check_output ("grep Mute".split(), stdin=output.stdout)
# print (str(output.decode('utf-8')).split())

if str(output.decode('utf-8')).split()[1] == "yes":
    # return "MUTED"
    print ("MUTED")
    exit()

# print (str (subprocess.check_output("grep Volume".split(), stdin=subprocess.Popen("pactl list  sinks".split(), stdout=subprocess.PIPE).stdout).decode('utf-8')).split())

output = str (subprocess.check_output("grep Volume".split(), stdin=subprocess.Popen("pactl list  sinks".split(), stdout=subprocess.PIPE).stdout).decode('utf-8')).split()
left_volume = output[4]
right_volume = output[11]
# print (left_volume, right_volume)

if left_volume != right_volume:
    print (left_volume + "  " + right_volume)
    exit()

print (left_volume)
