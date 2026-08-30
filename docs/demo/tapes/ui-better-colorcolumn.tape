Output gifs/ui-better-colorcolumn.gif

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
Type "cd work && DEMO_EXTRAS=ui.better-colorcolumn nvim LICENSE"
Enter
Sleep 12s
# на камере линию двигаем ближе к тексту, иначе её не разглядеть
Type ":set colorcolumn=80"
Enter
Sleep 1s
Show
Sleep 2s
Type "jjjj"
Sleep 2s
Ctrl+D
Sleep 3s
Hide
Type ":qa!"
Enter
