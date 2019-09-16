set term png truecolor
set grid
set style data histograms
set style fill solid 1.00 border -1
set key autotitle columnhead

set title 'number of dictionaries of different sizes'
set xlabel 'size of dictionary'
set ylabel 'number of dictionaries'
set output "dict-stats.png"
plot "dict-stats.txt" using 2:xtic(1), '' using 3, '' using 4
