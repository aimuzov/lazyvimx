# Гифка для EXTRAS: git.conflicts.
#
#   cd docs/demo && sh warmup.sh && vhs tapes/git-conflicts.tape
#
# Сценарий: открываем файл с мердж-конфликтом — маркеры подсвечены,
# приходит уведомление; co берёт текущую версию, ct — входящую.

Output gifs/git-conflicts.gif

Set Shell "bash"
Set FontFamily "JBMonoNL Demo Light"
Set LineHeight 1.55
Set FontSize 15
Set Width 1200
Set Height 604
Set Padding 0
Set Theme "Catppuccin Macchiato"
Set TypingSpeed 150ms
Set Framerate 24

Hide
Type "sh make-conflict.sh"
Enter
Sleep 2s
Type "export XDG_CONFIG_HOME=$PWD/profile/config XDG_DATA_HOME=$PWD/profile/data XDG_STATE_HOME=$PWD/profile/state XDG_CACHE_HOME=$PWD/profile/cache"
Enter
Type "cd sample-conflict"
Enter
Type "DEMO_EXTRAS=git.conflicts nvim greeting.txt"
Enter
Sleep 12s
# курсор на блок конфликта — тихо, до включения камеры
Type "4G"
Sleep 1s
Show

# маркеры конфликта подсвечены, всплыло уведомление
Sleep 4s

# ct — взять входящую версию (theirs)
Type "ct"
Sleep 4s

Hide
Type ":qa!"
Enter
