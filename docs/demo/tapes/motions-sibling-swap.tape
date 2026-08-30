Output gifs/motions-sibling-swap.gif

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
Type "rm -f /tmp/vhs-demo.sock; (sh drive.sh 3 4 '<C-.>' 3 'b' 2 '<C-.>' >/dev/null 2>&1 &)"
Enter
Type "cd work && DEMO_EXTRAS=motions.sibling-swap nvim --listen /tmp/vhs-demo.sock config.ts"
Enter
Sleep 12s
Type "3G04w"
Sleep 1s
Show
Sleep 13s
Hide
Type ":qa!"
Enter
