OPENLANE_DIR=$1

cd $OPENLANE_DIR/docker_build/docker/openroad_flow/OpenROAD
git submodule update --init --recursive
cd ..
cp rails.patch OpenROAD/
cp pdn_export_pin.patch OpenROAD/
cp setup_local.patch OpenROAD/src/OpenDB/src/swig/python

cd OpenROAD
git apply rails.patch
git apply pdn_export_pin.patch
cd src/OpenDB/src/swig/python 
git apply setup_local.patch

# temp or_route.tcl move step
cp $OPENLANE_DIR/docker_build/docker/openroad_flow/or_route.tcl $OPENLANE_DIR/scripts/openroad/or_route.tcl
# temp routing.tcl move step
cp $OPENLANE_DIR/docker_build/docker/openroad_flow/routing.tcl $OPENLANE_DIR/scripts/tcl_commands/routing.tcl
# temp or_ioplacer.tcl move step
cp $OPENLANE_DIR/docker_build/docker/openroad_flow/or_ioplacer.tcl $OPENLANE_DIR/scripts/openroad/or_ioplacer.tcl


echo "Done preparing OpenROAD"

