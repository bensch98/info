# Shell Commands

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

Delete all stuff (files/directories) from pwd except specified one:
```bash
find . ! -name "*.md" -print0 | xargs -0 rm -rf
```

Restart sound driver:
```bash
pulseaudio -k && sudo alsa force-reload
```

Cut .mp3 files:
```bash
# sudo apt-get install ffmpeg

# start time to end time:
ffmpeg -i input.mp3 -vn -acodec copy -ss 00:00:00 -to 00:00:30 output.mp3

# start time + duration time:
ffmpeg -i input.mp3 -vn -acodec copy -ss 00:00:00 -t 00:00:30 output.mp3

# start of record till end time:
ffmpeg -i input.mp3 -vn -acodec copy -to 00:00:30 output.mp3

# start time till end of record:
ffmpeg -i input.mp3 -vn -acodec copy -ss 00:00:30 output.mp3
```

Record .mp3 files:
```bash
# sudo apt-get install sox libsox-fmt-all
rec input.mp3
```

Play .mp3 files:
```bash
play intput.mp3
```

Adjust volume of .mp3 files:
```bash
# sudo apt-get install lame sox
lame --scale 20 input.mp3 output.mp3
# or
sox input.mp3 normalized.mp3 gain -n -3
```
