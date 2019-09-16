set term png truecolor
set grid
set style data histograms
set style fill solid 1.00 border -1
set key autotitle columnhead
set yrange[0:*]

set title 'time cost of zeek per packet'
set xlabel 'packets'
set ylabel 'microseconds'
set output "app-time.png"
plot "app-time.txt" using 2:xtic(1), '' using 3