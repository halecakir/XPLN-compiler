

.data

F: .float 0.0
t368: .float 0.0
t369: .float 0.0
B: .float 0.0
zzeerroo: .float 0.0

.text

main:
li.s $f0,12.0
s.s $f0,F
l.s $f2,F
#loading dummy zero float to $f0
l.s $f0,zzeerroo
sub.s $f0,$f0,$f2
s.s $f0,t368
l.s $f0,t368
#converting to float
li $t0,5
mtc1 $t0,$f6
cvt.s.w $f2,$f6
#conversion done
div.s $f0,$f0,$f2
s.s $f0,t369
l.s $f0,t369
s.s $f0,B
#MIPs termination protocol:
li $v0,10
syscall
.end main