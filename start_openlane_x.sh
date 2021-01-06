#/bin/bash
docker run -it -v $(pwd):/openLANE_flow -v $PDK_ROOT:$PDK_ROOT \
               -e PDK_ROOT=$PDK_ROOT \
               -e PDKPATH=$PDK_ROOT/sky130A \
               --net=host \
               --env="DISPLAY" \
               --volume="$HOME/.Xauthority:/home/$(id -un)/.Xauthority:rw" \
               --volume="$HOME/.xschem:/home/$(id -un)/.xschem:rw" \
               --volume="$HOME/.gaw:$HOME/.gaw:rw" \
               --volume="$(pwd):$HOME/project:rw" \
               openlane:rc6