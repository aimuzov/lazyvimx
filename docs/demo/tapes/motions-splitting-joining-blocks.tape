# Гифка для EXTRAS: motions.splitting-joining-blocks.
#
#   cd docs/demo && sh warmup.sh && vhs tapes/motions-splitting-joining-blocks.tape
#
# Сценарий: курсор на однострочном объекте, <leader>ct разбивает его
# на строки, повторное нажатие собирает обратно.

Output gifs/motions-splitting-joining-blocks.gif

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
Type "export XDG_CONFIG_HOME=$PWD/profile/config XDG_DATA_HOME=$PWD/profile/data XDG_STATE_HOME=$PWD/profile/state XDG_CACHE_HOME=$PWD/profile/cache"
Enter
Type "cd work && DEMO_EXTRAS=motions.splitting-joining-blocks nvim config.ts"
Enter
Sleep 18s
# курсор внутрь объекта: f прыгает на первую строчную h — hostName
Type "ggfh"
Sleep 1s
Show

Sleep 2s

# разбить блок
Space
Type "ct"
Sleep 3500ms

# и собрать обратно
Space
Type "ct"
Sleep 3500ms

Hide
Type ":qa!"
Enter
