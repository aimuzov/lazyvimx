Output gifs/motions-better-cursor-move.gif

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
Type "cd work && DEMO_EXTRAS=motions.better-cursor-move nvim config.ts"
Enter
Sleep 12s
Type "3G0w"
Sleep 1s
Show
Sleep 2s
Type "Vj>"
Sleep 2s
Type "gv>"
Sleep 2s
Type "gv<"
Sleep 2s
Type "gv<"
Escape
Sleep 2s
Hide
Type ":qa!"
Enter
