#!/bin/sh

show_usage(){
    printf "Usage:\n\n  %s [options [parameters]]\n" "$0"
    printf "\n"
    printf "ffmpeg helper to cut, concatenate, or record video or audio,
or convert audio to cd-burnable wav.\n"
    printf "\n"
    printf "Options [parameters]:\n"
    printf "\n"
    printf "  cut_video [start time] [end time/duration] [input name] [output name]
                      Cut video without re-encoding.\n"
    printf "  cut_video_from_file [input name] Cut using a file clips.info with
                      timestamp start as column 1 and timestamp stop as
                      column 2.\n"
    printf "  all_in_dir_to_concat_txt_file Create videos.txt file to cocatenate
                      all contents of directory.\n"
    printf "  concat_all_in_txt_file  Concatenate all in videos.txt.\n"
    printf "  concat_all_in_dir  Concatenate all files in directory.\n"

    printf "  cut_audio [start time] [end time/duration] [input name] [output name]
                      Cut audio without re-encoding.\n"
    printf "  cut_audio_from_file [input name] Cut using a file tracks.info with
                      timestamp start as column 1 and timestamp stop as
                      column 2.\n"
    printf "  make_cd_audio_in_dir Create cd-wave files from all files in directory\n"
    printf "  record [options] Record 1920x1080 screen, or with options:
                      -crt  Record 1024x768 screen.
                      -crtl Record 1024x768 screen letterboxed (16:9 middle).
                      -mac  Record1280x800 screen.\n"
    printf "  record_no_audio [options] Same as above, but no audio.\n"
    printf "  -h|--help   Print this help.\n"
exit
}

[ $# -eq 0 ] && show_usage

case "$1" in
    --help|-h)
        show_usage
        ;;
esac

# Cut video without re-encoding

# Params: Start time, end time or duration, input name, output name
cut_video() {
    ffmpeg -ss "$1" -i "$3" -t "$2" -c copy "$4"
}

# Multiple cuts using a file called clips.info with timestamp start as column 1 and timestamp stop as column 2
# Param: input name
cut_video_from_file() {
    ext=$(echo "$1" | sed "s/.*\.//")
    clips_amt=$(wc --lines < clips.info)

    echo "Creating $clips_amt $ext clips"

    for i in $(seq 1 "$clips_amt")
    do
        start=$(awk -v line="$i" 'FNR == line {print $1}' < clips.info)
        end=$(awk -v line="$i" 'FNR == line {print $2}' < clips.info)
        echo "$start to $end"
        ffmpeg_cut_audio "$start" "$end" "$1" "${i}.$ext"
    done
}

# Concatenate clips using concat demuxer

all_in_dir_to_concat_txt_file() {
    for f in *; do echo "file '$f'" >> videos.txt; done
}

# Optional param: output name
concat_all_in_txt_file() {
    output=output
    [ -n "$1" ] && output="$1"
    ffmpeg -f concat -i videos.txt -c copy "$output"
}

# Optional param: output name
concat_all_in_dir() {
    ffmpeg_all_in_dir_to_txt_file
    [ -z "$1" ] && ffmpeg_concat_all_in_txt_file
    [ -n "$1" ] && ffmpeg_concat_all_in_txt_file "$1"
}

# Cut audio without re-encoding

# Params: start time, end time or duration, input name, output name
cut_audio() {
    ffmpeg -i "$3" -acodec copy -ss "$1" -to "$2" "$4"
}

# Multiple cuts using a file called tracks.info with timestamp start as column 1 and timestamp stop as column 2
# Param: input name
cut_audio_from_file() {
    ext=$(echo "$1" | sed "s/.*\.//")
    tracks_amt=$(wc --lines < tracks.info)

    echo "Creating $tracks_amt $ext tracks"

    for i in $(seq 1 "$tracks_amt")
    do
        start=$(awk -v line="$i" 'FNR == line {print $1}' < tracks.info)
        end=$(awk -v line="$i" 'FNR == line {print $2}' < tracks.info)
        echo "$start to $end"
        ffmpeg_cut_audio "$start" "$end" "$1" "${i}.$ext"
    done
}

# Convert audio to be cd-burnable ready

# Param: input extension without dot
make_cd_audio_in_dir() {
    #ffmpeg -i input-file -vn -ac 2 -ar 44100 output-file.wav

    for f in *."$1"; do ffmpeg -i "$f" -vn -ac 2 -ar 44100 "${f%."$1"}.wav"; done

    # -vn is no video
}

# Simplify creating cut files by just specifying timestamp stop times as column 1 in file called
# stoptimes.txt.
# This converts the file into cut file used by video/audio cut fns above,
# By starting with 00:00:00 and then inserting the stop times as start times for the next row.
# Param: input name
format_cut_file() {
    ext=$(echo "$1" | sed "s/.*\.//")
    tracks_amt=$(wc --lines < stoptimes.txt)

    echo "Creating cut file with $tracks_amt cuts"

    start="00:00:00"
    end=$(awk 'FNR == 1 {print $1}' < stoptimes.txt)

    echo "$start $end" >> cuts.info

    for i in $(seq 2 "$tracks_amt")
    do
        start="$end"
        end=$(awk -v line="$i" 'FNR == line {print $2}' < stoptimes.info)
        echo "$start to $end"
        echo "$start $end" > cuts.info
    done
}

# Record
# Press q to stop recording
record() {
    inres=1920x1080
    fps=30
    offset=''
    case "$1" in
        -crt)
            inres=1024x768
            ;;
        -crtl)
            inres=1024x577
            offset="+0,99"
            ;;
        -mac)
            inres=1280x800
            ;;
    esac

    ffmpeg -f x11grab -video_size "$inres" -framerate "$fps" -i :0.0"$offset" -f alsa -ac 2 -i default out.mkv

    # -f is for format
    # x11grab is for grabbing the screen on x11
    # -i :0.0 is for input of the default monitor
    # -ac is for audio channel (switch this if no sound)
    # -i default is for default for the system ?
    # arecord -l to list audio devices, then hw:<device number>

    # You can watch out.mkv with mpv while it's recording!

}
# Press q to stop recording
record_no_audio() {
    inres=1920x1080
    fps=30
    offset=''
    case "$1" in
        -crt)
            inres=1024x768
            ;;
        -crtl)
            inres=1024x577
            offset="+0,99"
            ;;
        -mac)
            inres=1280x800
            ;;
    esac

    ffmpeg -f x11grab -video_size "$inres" -framerate "$fps" -i :0.0"$offset" out.mkv

}

# call the above fns via args to script, or else show usage
"$@" || show_usage
