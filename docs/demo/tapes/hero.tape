# Гифка для шапки сайта: фон под заголовком лендинга.
#
#   cd docs/demo && sh warmup.sh && vhs tapes/hero.tape
#
# Сценарий: живая работа в буфере — скролл, движения по подсловам,
# переименование с превью, разбор блока, дописывание строки. Ни
# статуслайна, ни вкладок: на записи только код (DEMO_HERO).

Output gifs/hero.gif
Output videos/hero.mp4

Set Shell "bash"
Set FontFamily "JBMonoNL Demo Light"
Set LineHeight 1.55
Set FontSize 15
Set Width 1200
Set Height 604
Set Padding 0
Set Theme "Catppuccin Macchiato"
Set TypingSpeed 120ms
Set Framerate 24

Hide
Type "export XDG_CONFIG_HOME=$PWD/profile/config XDG_DATA_HOME=$PWD/profile/data XDG_STATE_HOME=$PWD/profile/state XDG_CACHE_HOME=$PWD/profile/cache"
Enter
Type "cd work && DEMO_HERO=1 DEMO_EXTRAS=ui.better-diagnostic,ui.better-cursorline,ui.better-linenumbers,ui.symbol-usage,ui.scrollbar,ui.better-live-rename,motions.better-move-between-words,motions.splitting-joining-blocks nvim hero.lua"
Enter
Sleep 20s
Type "gg"
Sleep 1s
Show

Sleep 2s

# пролистать файл вниз и обратно
Ctrl+D
Sleep 1500ms
Ctrl+D
Sleep 1500ms
Ctrl+U
Sleep 2s

# движения по подсловам внутри имени
Type "24G"
Sleep 800ms
Type "0www"
Sleep 1500ms

# переименование с живым превью во всех вхождениях
Space
Type "cr"
Sleep 2s
Type "ciwsum_items"
Sleep 2500ms
Enter
Sleep 2s

# собрать блок в строку и разобрать обратно. Таблица корзины для этого
# слишком длинная: TreeSJ не сшивает узлы длиннее 120 символов.
Type "3G"
Sleep 800ms
Type "0f{"
Sleep 800ms
Space
Type "ct"
Sleep 2500ms
Space
Type "ct"
Sleep 2s

# дописать позицию: копия строки, новое имя и цена. Набирать литерал
# целиком нельзя — автопары закрывают кавычку и скобку сами.
Type "60G"
Sleep 800ms
Type "yyp"
Sleep 1500ms
Type `ci"latte`
Escape
Sleep 1500ms
Type "f2"
Sleep 500ms
Type "ciw310"
Escape
Sleep 1500ms

Type "gg"
Sleep 2500ms

Hide
Type ":qa!"
Enter
