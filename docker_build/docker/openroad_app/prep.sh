OPENLANE_DIR=$1

cd $OPENLANE_DIR/docker_build/docker/openroad_app/OpenROAD
git submodule update --init --recursive
cd ..
cp rails.patch OpenROAD/
cp pdngen_export_subst.patch OpenROAD/
cp ignore_obs_outside.patch OpenROAD/
cp setup_local.patch OpenROAD/src/OpenDB/src/swig/python

cd OpenROAD
git apply rails.patch
git apply pdngen_export_subst.patch
git apply ignore_obs_outside.patch
cd src/OpenDB/src/swig/python 
git apply setup_local.patch

# modify the needed scripts
cp $OPENLANE_DIR/docker_build/docker/openroad_app/or_write_verilog.tcl $OPENLANE_DIR/scripts/openroad/or_write_verilog.tcl
cp $OPENLANE_DIR/docker_build/docker/openroad_app/or_ioplacer.tcl $OPENLANE_DIR/scripts/openroad/or_ioplacer.tcl

echo "Done preparing OpenROAD"
