

.data

A: .float 0.0
B: .float 0.0
t450: .float 0.0
t451: .float 0.0
t452: .float 0.0
C: .float 0.0
zzeerroo: .float 0.0

.text

main:
#converting to float
li $t0,0
mtc1 $t0,$f6
cvt.s.w $f0,$f6
#conversion done
s.s $f0,A
#converting to float
li $t0,10
mtc1 $t0,$f6
cvt.s.w $f0,$f6
#conversion done
s.s $f0,B
l453:
l.s $f0,A
l.s $f2,B
add.s $f0,$f0,$f2
s.s $f0,t450
l.s $f0,t450
s.s $f0,A
l.s $f0,B
#converting to float
li $t0,1
mtc1 $t0,$f6
cvt.s.w $f2,$f6
#conversion done
sub.s $f0,$f0,$f2
s.s $f0,t451
l.s $f0,t451
s.s $f0,B
l.s $f0,B
#converting to float
li $t0,0
mtc1 $t0,$f6
cvt.s.w $f2,$f6
#conversion done
c.lt.s $f2, $f0
cfc1 $t0,$25
andi $t0,1
mtc1 $t0,$f6
cvt.s.w $f0,$f6
s.s $f0,t452
l.s $f2,t452
li.s $f4, 0.0
c.eq.s $f2, $f4
bc1t l454
j l453
l454:
l.s $f0,A
s.s $f0,C
#MIPs termination protocol:
li $v0,10
syscall
.end main