Output gifs/ui-showkeys.gif
Output videos/ui-showkeys.mp4

Set Shell "bash"
Set FontFamily "JBMonoNL Demo Light"
Set LineHeight 1.55
Set FontSize 15
Set Width 1200
Set Height 604
Set Padding 0
Set Theme "Catppuccin Macchiato"
Set TypingSpeed 250ms
Set Framerate 24

Hide
Type "export XDG_CONFIG_HOME=$PWD/profile/config XDG_DATA_HOME=$PWD/profile/data XDG_STATE_HOME=$PWD/profile/state XDG_CACHE_HOME=$PWD/profile/cache"
Enter
Type "cd work && DEMO_EXTRAS=ui.showkeys nvim app.lua"
Enter
Sleep 12s
Show
Sleep 2s
Type "jjww"
Sleep 1500ms
Type "ciw"
Sleep 1s
Type "items"
Escape
Sleep 1500ms
Type "u"
Sleep 2500ms
Hide
Type ":qa!"
Enter
