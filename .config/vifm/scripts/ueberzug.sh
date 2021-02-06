# process substitution example:
ueberzug layer --parser bash 0< <(
    declare -Ap add_command=([action]="add" [identifier]="example0" [x]="0" [y]="0" [path]="/home/ishank/Pictures/Wallpaper/file-1.jpg")
    declare -Ap add_command=([action]="add" [identifier]="example1" [x]="10" [y]="0" [path]="/home/ishank/Pictures/Wallpaper/file-2.jpg")
    sleep 1
    declare -Ap remove_command=([action]="remove" [identifier]="example0")
    sleep 1
)

# group commands example:
# {
#     declare -Ap add_command=([action]="add" [identifier]="example0" [x]="0" [y]="0" [path]="/home/ishank/Pictures/Wallpaper/file-1.jpg")
#     declare -Ap add_command=([action]="add" [identifier]="example1" [x]="10" [y]="0" [path]="/home/ishank/Pictures/Wallpaper/file-1.jpg")
#     read
#     declare -Ap remove_command=([action]="remove" [identifier]="example0")
#     read
# } | ueberzug layer --parser bash
