.data

F: .float 10.0
t445: .float 0.0
.data

F: .float 10.0
t445: .float 0.0
B: .float 0.0
zzeerroo: .float 0.0

.text

main:
l.s $f0,F
#converting to float
li $t0,5
mtc1 $t0,$f6
cvt.s.w $f2,$f6
#conversion done
c.lt.s $f0,$f2
cfc1 $t0,$25
andi $t0,1
mtc1 $t0,$f6
cvt.s.w $f0,$f6
s.s $f0,t445
l.s $f0,t445
s.s $f0,B

#MIPs termination protocol:
mov.s $f12, $f0
li $v0,2
syscall

li $v0,10
syscall
.end main
B: .float 0.0
zzeerroo: .float 0.0

.text

main:
l.s $f0,F
#converting to float
li $t0,5
mtc1 $t0,$f6
cvt.s.w $f2,$f6
#conversion done
c.lt.s $f0,$f2
cfc1 $t0,$25
andi $t0,1
sw $t0,t445
l.s $f0,t445
s.s $f0,B
#MIPs termination protocol:
li $v0,10
syscall
.end main