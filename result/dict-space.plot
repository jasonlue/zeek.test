set term png truecolor
set grid
set style data histograms
set style fill solid 1.00 border -1
set key autotitle columnhead

set title 'memory consumed per key in dictionary'
set xlabel 'dictionary size'
set ylabel 'bytes per key'
set output "dict-space.png"
plot "dict-space.txt" using 2:xtic(1), '' using 3
