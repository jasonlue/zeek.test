set term png truecolor
set output "app-space.png"
set grid
set style data histograms
set style fill solid 1.00 border -1
set key autotitle columnhead
set title 'memory consumed by zeek with different input pcap packets'
set xlabel 'input pcap packets'
set ylabel "malloc'd memory"
plot "app-space.txt" using 2:xtic(1), '' using 3
