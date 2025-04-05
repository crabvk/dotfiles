function ffmpeg-mp3
    set filepath $argv[1]
    set filename (basename -- $filepath)
    set parts (string split -r -m1 '.' $filename)
    ffmpeg -i $filepath -codec:a libmp3lame -b:a 320k ~/downloads/$parts[1].mp3
end
