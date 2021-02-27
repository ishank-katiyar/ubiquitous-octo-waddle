#   !/bin/python3 python3

#  checkout :- https://mega.nz/folder/PsQGHTha#GNETlcdEbGUOoYrmENg0Pw/folder/GgwHGYjQ
import pathlib
import os
import subprocess
import sys


if "toggleperm" in sys.argv:
    file = open('/home/ishank/.config/i3/wallpaper/wallpaper_persistant', 'r')
    S = "True" if file.readline() == "False" else "False"
    file.close()
    file = open('/home/ishank/.config/i3/wallpaper/wallpaper_persistant', 'w')
    file.write(S)
    file.close()
    sys.exit()

#  if "perm" in sys.argv:
#      file = open('/home/ishank/.config/i3/wallpaper/wallpaper_persistant', 'w')
#      file.write(str ("True"))
#      file.close()

#  print ((open('/home/ishank/.config/i3/wallpaper/wallpaper_persistant').readline()))
if str (open('/home/ishank/.config/i3/wallpaper/wallpaper_persistant').readline()) == "True":
    sys.exit("wallpaper is permanent")

wallpaper_directory = "/home/ishank/Pictures/Wallpaper/"
fileName = "current_wallpaper_index.txt"

if not pathlib.Path('/home/ishank/.config/i3/wallpaper/' + fileName).exists():
    subprocess.run(("touch /home/ishank/.config/i3/wallpaper/" + fileName).split())
    open('/home/ishank/.config/i3/wallpaper/' + fileName, 'w').write('0')


total_files = len(os.listdir(wallpaper_directory))

if len (sys.argv) > 1 and (sys.argv[1] == "reverse"):
    next_wallpaper_index = int(open('/home/ishank/.config/i3/wallpaper/' + fileName).readline()) - 1
    next_wallpaper_index += total_files
    next_wallpaper_index = next_wallpaper_index % total_files
else:
    next_wallpaper_index = (int(open('/home/ishank/.config/i3/wallpaper/' + fileName).readline()) + 1) % total_files


#  next_wallpaper_index = next_wallpaper_index % total_files
#  print (total_files)
#  print (os.listdir(wallpaper_directory))
nextWallpaper = os.listdir(wallpaper_directory)[next_wallpaper_index]
#  print (nextWallpaper)


#  print("next_wallpaper_number: ", next_wallpaper_index)


command = "feh --bg-fill " + "\"" + wallpaper_directory + nextWallpaper + "\""
#  print (command)
os.system (command)

open('/home/ishank/.config/i3/wallpaper/' + fileName, 'w').write(str(next_wallpaper_index))
