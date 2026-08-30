# Собирает «до»-варианты тейпов в tapes-before/: тот же сценарий, но
# DEMO_EXTRAS пуст — на записи ванильный LazyVim с оверрайдами. Строится
# из обоих наборов (тёмного и светлого); руками эти тейпы не трогать.
import os
import re

# Без целевой экстры сценарий теряет смысл: yazi не открывается,
# темы nord в пикере нет, а showkeys — сама плашка записи.
skip = {"ui-better-explorer.tape", "colorschemes-nord.tape", "ui-showkeys.tape"}

os.makedirs("tapes-before", exist_ok=True)

count = 0
for src_dir, suffix in [("tapes", "-before"), ("tapes-light", "-before-light")]:
    for name in sorted(os.listdir(src_dir)):
        if not name.endswith(".tape") or name in skip:
            continue

        text = open(f"{src_dir}/{name}").read()
        text = re.sub(r"Output gifs/([a-z0-9-]+?)(-light)?\.gif", rf"Output gifs/\1{suffix}.gif", text)
        text = re.sub(r"DEMO_EXTRAS=[a-z0-9.,-]+ ", "DEMO_EXTRAS= ", text)

        # Штатный rename открывает поле с прежним именем — ciw там
        # вставился бы литералом; чистим поле и набираем заново.
        if name.startswith("ui-better-live-rename"):
            text = text.replace("'ciwcart_total'", "'<C-u>cart_total'")

        # Команды этих плагинов без экстры кончаются E492 на камере;
        # «до» — это сам буфер, без вызова.
        for cmd in [":DiffviewOpen", ":BaleiaColorize"]:
            text = text.replace(f'Type "{cmd}"\nEnter\n', "")

        out = name.replace(".tape", f"{suffix}.tape")
        open(f"tapes-before/{out}", "w").write(text)
        count += 1

print(f"tapes-before: {count}")
