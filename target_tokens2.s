

.data

t382: .float 0.0
F: .float 0.0
t383: .float 0.0
B: .float 0.0
zzeerroo: .float 0.0

.text

main:
l.s $f2,F
#loading dummy zero float to $f0
l.s $f0,zzeerroo
sub.s $f0,$f0,$f2
s.s $f0,t382
l.s $f0,t382
#converting to float
li $t0,5
mtc1 $t0,$f6
cvt.s.w $f2,$f6
#conversion done
div.s $f0,$f0,$f2
s.s $f0,t383
l.s $f0,t383
s.s $f0,B
#MIPs termination protocol:
li $v0,10
syscall
.end main

.data

t451: .float 0.0
F: .float 0.0
t452: .float 0.0
B: .float 0.0
zzeerroo: .float 0.0

.text

main:
l.s $f2,F
#loading dummy zero float to $f0
l.s $f0,zzeerroo
sub.s $f0,$f0,$f2
s.s $f0,t451
l.s $f0,t451
#converting to float
li $t0,5
mtc1 $t0,$f6
cvt.s.w $f2,$f6
#conversion done
div.s $f0,$f0,$f2
s.s $f0,t452
l.s $f0,t452
s.s $f0,B
#MIPs termination protocol:
li $v0,10
syscall
.end main

.data

t445: .float 0.0
F: .float 0.0
t446: .float 0.0
B: .float 0.0
zzeerroo: .float 0.0

.text

main:
l.s $f2,F
#loading dummy zero float to $f0
l.s $f0,zzeerroo
sub.s $f0,$f0,$f2
s.s $f0,t445
l.s $f0,t445
#converting to float
li $t0,5
mtc1 $t0,$f6
cvt.s.w $f2,$f6
#conversion done
div.s $f0,$f0,$f2
s.s $f0,t446
l.s $f0,t446
s.s $f0,B
#MIPs termination protocol:
li $v0,10
syscall
.end main

.data

t445: .float 0.0
F: .float 0.0
t446: .float 0.0
B: .float 0.0
zzeerroo: .float 0.0

.text

main:
l.s $f2,F
#loading dummy zero float to $f0
l.s $f0,zzeerroo
sub.s $f0,$f0,$f2
s.s $f0,t445
l.s $f0,t445
#converting to float
li $t0,5
mtc1 $t0,$f6
cvt.s.w $f2,$f6
#conversion done
div.s $f0,$f0,$f2
s.s $f0,t446
l.s $f0,t446
s.s $f0,B
#MIPs termination protocol:
li $v0,10
syscall
.end main

.data

t445: .float 0.0
F: .float 0.0
t446: .float 0.0
B: .float 0.0
zzeerroo: .float 0.0

.text

main:
l.s $f2,F
#loading dummy zero float to $f0
l.s $f0,zzeerroo
sub.s $f0,$f0,$f2
s.s $f0,t445
l.s $f0,t445
#converting to float
li $t0,5
mtc1 $t0,$f6
cvt.s.w $f2,$f6
#conversion done
div.s $f0,$f0,$f2
s.s $f0,t446
l.s $f0,t446
s.s $f0,B
#MIPs termination protocol:
li $v0,10
syscall
.end main