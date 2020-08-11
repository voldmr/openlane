OPENLANE_DIR=$1
cd $OPENLANE_DIR/docker_build/docker/openroad_flow/OpenROAD
git submodule update --init --recursive
cd ..
cp rails.patch OpenROAD/
cp pdn_export_pin.patch OpenROAD/
cp pdn_gen_core_ring_fix.patch OpenROAD/
cp setup_local.patch OpenROAD/src/OpenDB/src/swig/python

cd OpenROAD
git apply rails.patch
git apply pdn_export_pin.patch
git apply pdn_gen_core_ring_fix.patch
cd src/OpenDB/src/swig/python 
git apply setup_local.patch
echo "Done preparing OpenROAD"