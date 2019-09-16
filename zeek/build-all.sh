#!/bin/bash
# build-all <zeek dir> <target dir>

#O2_targets=("zeek.O2" "zeek.open.O2")
#O2_params=( "" "-DUSE_OPEN_DICT")

#O3_targets=("zeek.O3" "zeek.memory.O3" "zeek.distance.O3" "zeek.open.O3" "zeek.open.memory.O3" "zeek.open.distance.O3")
#O3_params=(
O2_targets=("zeek" "zeek.memory" "zeek.distance" "zeek.open" "zeek.open.memory" "zeek.open.distance")
O2_params=(
	""
	"-DUSE_DICT_STATS -DDICT_STATS_TOP=10" 
	"-DUSE_DICT_STATS -DDICT_STATS_SORT_BY_DISTANCE -DDICT_STATS_TOP=10"
	"-DUSE_OPEN_DICT"
	"-DUSE_OPEN_DICT -DUSE_DICT_STATS -DDICT_STATS_TOP=10" 
	"-DUSE_OPEN_DICT -DUSE_DICT_STATS -DDICT_STATS_SORT_BY_DISTANCE -DDICT_STATS_TOP=10"
)

function setup_O2(){ #cmakelists
	local cmakelists=$1
	sed -i 's/O3/O2/g' $cmakelists
}

function setup_O3(){
	local cmakelists=$1
	sed -i 's/O2/O3/g' $cmakelists
}

function build(){
	local target=$1
	local params=$2
	rm -rf build
	CXXFLAGS="$params" ./configure --generator=Ninja --enable-perftools
	pushd build
	echo building $target with $params
	ninja
	#sleep 10
	popd
	cp build/src/zeek $2/"$target"
}

function main(){
	pushd $1
	setup_O2 "CMakeLists.txt" 
	for ((i=0; i<${#O2_targets[@]};i++)); do
		local f="run/${O2_targets[i]}"
		if [ ! -e $f ]; then
			build "$f" "${O2_params[i]}" $(realpath $2)
		fi
	done

	setup_O3 "CMakeLists.txt" 
	for ((i=0; i<${#O3_targets[@]}; i++)); do
		local f="run/${O3_targets[i]}"
		if [ ! -e $f ]; then
			build "$f" "${O3_params[i]}" $(realpath $2)
		fi 
	done
	popd
}

if (($# < 2)); then 
	echo $0 <zeek dir> <target dir>
	exit 1
fi
main $1 $2
