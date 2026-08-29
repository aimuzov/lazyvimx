# Гифка для EXTRAS: motions.better-move-between-words.
#
#   cd docs/demo && sh warmup.sh && vhs tapes/motions-better-move-between-words.tape
#
# Сценарий: w шагает по подсловам внутри camelCase-имён — обычный w
# перепрыгнул бы всё имя целиком.

Output gifs/motions-better-move-between-words.gif

Set Shell "bash"
Set FontFamily "JBMonoNL Demo Light"
Set LineHeight 1.55
Set FontSize 15
Set Width 1200
Set Height 604
Set Padding 0
Set Theme "Catppuccin Macchiato"
Set TypingSpeed 350ms
Set Framerate 24

Hide
Type "export XDG_CONFIG_HOME=$PWD/profile/config XDG_DATA_HOME=$PWD/profile/data XDG_STATE_HOME=$PWD/profile/state XDG_CACHE_HOME=$PWD/profile/cache"
Enter
Type "cd work && DEMO_EXTRAS=motions.better-move-between-words nvim config.ts"
Enter
Sleep 12s
Type "gg0"
Sleep 1s
Show

Sleep 2s

# w останавливается на каждом подслове
Type "wwwwww"
Sleep 2s

# b — назад по подсловам
Type "bbb"
Sleep 2s

# ce меняет ровно одно подслово
Type "ce"
Sleep 800ms
Type "public"
Escape
Sleep 3s

Hide
Type ":qa!"
Enter
