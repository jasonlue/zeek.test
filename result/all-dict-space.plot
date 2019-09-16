set term png truecolor
set grid
set style data histograms
set style fill solid 1.00 border -1
set key autotitle columnhead

set title 'memory consumed by all dictionaries in zeek with different input pcap packets'
set xlabel 'input pcap packets'
set ylabel 'megabytes of memory consumed by all dictionaries'
set output "all-dict-space.png"
plot "all-dict-space.txt" using 2:xtic(1), '' using 3
