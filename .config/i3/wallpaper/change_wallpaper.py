#   !/bin/python3 python3

#  checkout :- https://mega.nz/folder/PsQGHTha#GNETlcdEbGUOoYrmENg0Pw/folder/GgwHGYjQ

import pathlib
import os
import subprocess

wallpaper_directory = "/home/ishank/Pictures/Wallpaper/"
fileName = "current_wallpaper_index.txt"

if not pathlib.Path('/home/ishank/.config/i3/wallpaper/' + fileName).exists():
    subprocess.run(("touch /home/ishank/.config/i3/wallpaper/" + fileName).split())
    open('/home/ishank/.config/i3/wallpaper/' + fileName, 'w').write('0')


next_wallpaper_index = int(open('/home/ishank/.config/i3/wallpaper/' + fileName).readline()) + 1

total_files = len(os.listdir(wallpaper_directory))
next_wallpaper_index = next_wallpaper_index % total_files
print (total_files)
print (os.listdir(wallpaper_directory))
nextWallpaper = os.listdir(wallpaper_directory)[next_wallpaper_index]
print (nextWallpaper)


print("next_wallpaper_number: ", next_wallpaper_index)


command = "feh --bg-fill " + "\"" + wallpaper_directory + nextWallpaper + "\""
print (command)
os.system (command)

open('/home/ishank/.config/i3/wallpaper/' + fileName, 'w').write(str(next_wallpaper_index))
