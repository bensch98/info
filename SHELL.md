## Helpful shell commands

Copy all files from one directory to another excluding specified files/folders.
```bash
rsync -av --progress --exclude="/excluded_dirfile_name" . ../dirfile_name
```

Delete all files from pwd except specified one:
```bash
find . ! -name '.git' -type f -exec rm -f {} +
```

Delete all directories from pwd except specified one:
```bash
find . ! -name '.git' -type d -exec rm -rf {} +
```

Restart sound driver:
```bash
pulseaudio -k && sudo alsa force-reload
```
