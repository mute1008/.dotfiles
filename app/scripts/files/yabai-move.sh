#!/bin/bash

# MEMO:
# ディスプレイの左上を基準に計算している.
# なので, 横に並べていたとしても, ディスプレイが少し上にずれていると, 横にカーソルが動いてしまうことがある
# そういう場合は左上を全ての液晶で揃えることで解消する

# validate args
if [ -z $1 ];then exit 1; fi
if [ $1 != east ] && [ $1 != west ] && [ $1 != north ] && [ $1 != south ]; then exit 1; fi

# move focus
yabai -m window --focus $1 2>/dev/null;if [ $? -eq 0 ]; then exit 0; fi

# vars
spaces=`yabai -m query --spaces --display`
displays=`yabai -m query --displays`
axis=`if [ $1 = east ] || [ $1 = west ]; then echo x; else echo y; fi`
current_display_id=`echo $spaces | jq 'map(select(.focused == 1)) | .[].display'`
current_pos=(`echo $displays | jq "sort_by(.index) | map(select(.index == $current_display_id)) | .[].frame.$axis"`)

# find display index
if [ $1 = east ] || [ $1 = south ];then
  display_index=`echo $displays | jq "map(select(.frame.$axis > $current_pos)) | sort_by(.frame.$axis) | .[0].index"`;
else
  display_index=`echo $displays | jq "map(select(.frame.$axis < $current_pos)) | sort_by(.frame.$axis) | reverse | .[0].index"`;
fi

# move display
if [ $display_index != null ]; then
  yabai -m display --focus $display_index;
fi
