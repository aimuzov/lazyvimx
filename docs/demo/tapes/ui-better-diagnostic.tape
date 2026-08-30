# Гифка для EXTRAS: ui.better-diagnostic.
#
#   cd docs/demo && sh warmup.sh && vhs tapes/ui-better-diagnostic.tape
#
# Сценарий: дописываем вызов несуществующей функции — lua_ls ругается,
# и диагностика встаёт одной строкой прямо у курсора.

Output gifs/ui-better-diagnostic.gif

Set Shell "bash"
Set FontFamily "JBMonoNL Demo Light"
Set LineHeight 1.55
Set FontSize 15
Set Width 1200
Set Height 767
Set Padding 0
Set Theme "Catppuccin Macchiato"
Set TypingSpeed 150ms
Set Framerate 24

Hide
Type "export XDG_CONFIG_HOME=$PWD/profile/config XDG_DATA_HOME=$PWD/profile/data XDG_STATE_HOME=$PWD/profile/state XDG_CACHE_HOME=$PWD/profile/cache"
Enter
Type "cd work && DEMO_EXTRAS=ui.better-diagnostic nvim app.lua"
Enter
# lua_ls стартует не мгновенно
Sleep 20s
Show

Sleep 1500ms

# опечатка в имени функции — undefined global
Type "G"
Sleep 1s
Type "O"
Sleep 500ms
Type "print(formt_price(100))"
Escape
Sleep 6s

# правим опечатку — диагностика гаснет
Type "0fmla"
Sleep 500ms
Type "a"
Escape
Sleep 4s

Hide
Type ":qa!"
Enter
