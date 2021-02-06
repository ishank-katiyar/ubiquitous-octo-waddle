# /bin/python3 python3 get_brightness.py

import subprocess

#  subprocess.run ("sudo brightnessctl set +60%".split(), stdout=subprocess.PIPE)

current_brightness = int(subprocess.check_output(
    "brightnessctl get".split()).decode('utf-8'))
max_brightness = int(subprocess.check_output(
    "brightnessctl max".split()).decode('utf-8'))
#  print(current_brightness)
#  print(max_brightness)

print(str(int(current_brightness * 100 / max_brightness)) + "%")
