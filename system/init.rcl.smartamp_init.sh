#!/system/bin/sh

for COUNT in 1 2 3 4 5 6 7 8 9 10;
do
    flag=($(cat /proc/asound/cards | grep -n msm8998tashas));

    if [ "$flag" = "1:" ];then
        break
    else
        sleep 1
    fi
done

sleep 5
main_sound_card=`cat /proc/asound/cards |grep "msm8998tashas"|sed 's/ /\t/g'|cut -f 2`
tinymix -D ${main_sound_card} 'QUAT_MI2S_RX Audio Mixer MultiMedia1' 1  > /dev/null 2>&1
tinyplay  /system/etc/audio/silence_48k.wav -D ${main_sound_card}   > /dev/null 2>&1 &
TINYPLAY_PID=$!> /dev/null 2>&1
sleep 1
kill $TINYPLAY_PID > /dev/null 2>&1
sleep 0.1
tinymix -D ${main_sound_card} 'QUAT_MI2S_RX Audio Mixer MultiMedia1' 0  > /dev/null 2>&1
