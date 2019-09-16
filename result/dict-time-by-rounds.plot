set term png truecolor
set grid
set style data histograms
set style fill solid 1.00 border -1
set key autotitle columnhead
set xlabel 'rounds'
set ylabel 'nanoseconds'

set title 'time spent on dictionary inserts per key'
set output "inserts-time_by-rounds.png"
plot "dict-time-by-rounds.txt" using 2:xtic(1), '' using 3

set title 'time spent on dictionary successful lookups per key'
set output "lookups-time-by-rounds.png"
plot "dict-time-by-rounds.txt" using 4:xtic(1), '' using 5

set title 'time spent on dictionary failed lookups per key'
set output "failed-lookups-time-by-rounds.png"
plot "dict-time-by-rounds.txt" using 6:xtic(1), '' using 7

set title 'time spent on dictionary removes per key'
set output "removes-time-by-rounds.png"
plot "dict-time-by-rounds" using 8:xtic(1), '' using 9