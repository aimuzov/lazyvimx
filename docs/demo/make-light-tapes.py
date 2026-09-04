# Собирает светлые варианты тейпов в tapes-light/: та же сценарная часть,
# но палитра latte у терминала и у nvim, а записи получают суффикс -light.
# Правится только генератором — руками эти тейпы не трогать.
import os
import re

os.makedirs("tapes-light", exist_ok=True)

for name in sorted(os.listdir("tapes")):
    if not name.endswith(".tape"):
        continue

    text = open(f"tapes/{name}").read()
    text = text.replace('Set Theme "Catppuccin Macchiato"', 'Set Theme "Catppuccin Latte"')
    text = re.sub(r"Output (gifs|videos)/([a-z0-9-]+)\.(gif|mp4)", r"Output \1/\2-light.\3", text)
    text = text.replace("DEMO_EXTRAS=", "DEMO_COLORSCHEME=catppuccin-latte DEMO_EXTRAS=")

    # В светлой версии из пикера тем выбираем nord-light, а не nord.
    if name == "colorschemes-nord.tape":
        text = text.replace('Type "nord"\nSleep 2s\nEnter', 'Type "nord"\nSleep 2s\nDown\nSleep 1s\nEnter')

    open(f"tapes-light/{name}", "w").write(text)
    print(f"tapes-light/{name}")
