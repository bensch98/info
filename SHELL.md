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

## ffmpeg

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

Cut .mp4 files:
```bash
ffmpeg -i input.mp4 -ss 00:00:00 -to 00:00:30 -c:v copy -c:a copy output.mp4
```

Convert .mp4 to .mp3 file:
```bash
ffmpeg -i input.mp4 -vn -acodec libmp3lame -ac 2 -ab 160k -ar 48000 output.mp3
```

Overlay two .mp3 files:
```
ffmpeg -i input0.mp3 -i input1.mp3 -filter_complex amix=inputs=2:duration=longest output.mp3
```

Record .mp3 files:
```bash
# sudo apt-get install sox libsox-fmt-all
rec input.mp3
```

Play .mp3 files:
```bash
play input.mp3
```

Adjust volume of .mp3 files:
```bash
# sudo apt-get install lame sox
lame --scale 20 input.mp3 output.mp3
# or
sox input.mp3 normalized.mp3 gain -n -3
```

Cropping .mp4 files:
```bash
# get resolution
ffprobe -v error -select_streams v:0 -show_entries stream=width,height -of csv=p=0 advanced-cropped.mp4

# crop video (60px at top and 60px at bottom) -> results here in 1920x1080
ffmpeg -i input.mp4 -vf "crop=1920:1080:0:60" -c:a copy output.mp4
```

