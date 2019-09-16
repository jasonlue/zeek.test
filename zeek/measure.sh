#!/bin/bash
#echo $#
if (($# < 2)); then
	echo "$0 <pcap> <zeek> [<count>]"
	exit 1
fi
pcap=$1
bro=$2
count=12

if (($# >= 3 )); then
	count=$3
fi
sec=()
meg=()
for((i=0; i<count; i++)); do
	echo $i
	$bro -Qr ~/pcap/$pcap.pcap 2>&1 | tee o.log
	sec[i]=`awk '/total time/{print $6}' < o.log` 
	meg[i]=`awk '/total mem/{print $4}' < o.log | sed 's/[^0-9]/ /g' | awk '{print $2}'`
done
	#sort array and drop the first and last if there's at least one left
	#sort see each item by line.
	sec=(`printf "%s\n" ${sec[@]} | sort`)
	meg=(`printf "%s\n" ${meg[@]} | sort`)
	begin=0
	end=${#sec[@]}
	if ((${#sec[@]} >= 5 )); then # 5+, drop highest and lowest.
		begin=1
		((end--))
	fi

	c=0
	total_sec=0.0
	total_meg=0
	for ((i=begin; i<end; i++)); do
		((c++))
		total_sec=`bc -l <<< "$total_sec + ${sec[i]}"`
		((total_meg +=${meg[i]}))
	done
	#echo "sec: ${sec}  meg: ${meg} total_sec: $total_sec total_meg: $total_meg"

	avg_sec=`bc -l <<< "scale=2;${total_sec} / $c"`
	((avg_meg = total_meg / $c))

	printf "%30s: %5ss %4sM\n" "$bro/$pcap" "$avg_sec" "$avg_meg" | tee -a  measure.log

