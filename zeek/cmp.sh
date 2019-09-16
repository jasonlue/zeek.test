if (($# < 3)); then
	echo "$0 <count> <pcap> <zeek> ..."
	exit 1
fi
count=$1
pcap=$2
#first param is pcap, the rest are bros to be compared.
shift
shift

echo =================================================== >> measure.log
echo "$count $pcap" >> measure.log
echo =================================================== >> measure.log
for bro in $@; do
	measure.sh $pcap $bro $count  
done
cat measure.log
