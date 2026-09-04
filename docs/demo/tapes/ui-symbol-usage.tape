# Гифка для EXTRAS: ui.symbol-usage.
#
#   cd docs/demo && sh warmup.sh && vhs tapes/ui-symbol-usage.tape
#
# Сценарий: над функциями видны счётчики использований; дописываем ещё
# один вызов — счётчик обновляется.

Output gifs/ui-symbol-usage.gif
Output videos/ui-symbol-usage.mp4

Set Shell "bash"
Set FontFamily "JBMonoNL Demo Light"
Set LineHeight 1.55
Set FontSize 15
Set Width 1200
Set Height 766
Set Padding 0
Set Theme "Catppuccin Macchiato"
Set TypingSpeed 150ms
Set Framerate 24

Hide
Type "export XDG_CONFIG_HOME=$PWD/profile/config XDG_DATA_HOME=$PWD/profile/data XDG_STATE_HOME=$PWD/profile/state XDG_CACHE_HOME=$PWD/profile/cache"
Enter
Type "cd work && DEMO_EXTRAS=ui.symbol-usage nvim app.lua"
Enter
# lua_ls плюс первый запрос symbol-usage
Sleep 22s
Show

Sleep 4s

# ещё одно использование calculate_total — счётчик подрастёт
Type "G"
Sleep 1s
Type "O"
Sleep 500ms
Type "print(calculate_total(cart))"
Escape
Type ":w"
Enter
Sleep 7s

Hide
Type ":qa!"
Enter
