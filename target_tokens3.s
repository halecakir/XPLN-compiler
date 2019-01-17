

.data

B: .float 0.0
C: .float 0.0
t376: .float 0.0
t377: .float 0.0
t378: .float 0.0
E: .float 0.0
F: .float 0.0
t379: .float 0.0
t380: .float 0.0
t381: .float 0.0
A: .float 0.0
zzeerroo: .float 0.0

.text

main:
l.s $f0,C
li.s $f2,78.45
mul.s $f0,$f0,$f2
s.s $f0,t376
l.s $f0,B
l.s $f2,t376
add.s $f0,$f0,$f2
s.s $f0,t377
l.s $f2,E
#loading dummy zero float to $f0
l.s $f0,zzeerroo
sub.s $f0,$f0,$f2
s.s $f0,t378
l.s $f0,t378
l.s $f2,F
add.s $f0,$f0,$f2
s.s $f0,t379
l.s $f0,t379
li.s $f2,12.5
div.s $f0,$f0,$f2
s.s $f0,t380
l.s $f0,t377
l.s $f2,t380
sub.s $f0,$f0,$f2
s.s $f0,t381
l.s $f0,t381
s.s $f0,A
#MIPs termination protocol:
li $v0,10
syscall
.end main