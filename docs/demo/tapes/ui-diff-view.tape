Output gifs/ui-diff-view.gif

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
Type "cd work && DEMO_EXTRAS=ui.diff-view nvim app.lua"
Enter
Sleep 12s
Type "16G0f3cw999"
Escape
Type ":w"
Enter
Sleep 1s
Show
Sleep 1s
Type ":DiffviewOpen"
Enter
Sleep 6s
Hide
Type ":DiffviewClose"
Enter
Type ":qa!"
Enter
