.data


F: .float 5.0
B: .float 5.0

.text

main:
l.s $f2,F
#loading dummy zero float to $f0
l.s $f0,B
c.eq.s $f0 $f2

cfc1   $t0, $25  # load FCCR into t0
andi   $t0, 1    # mask the bit 0 only

#MIPs termination protocol:
li $v0,10
syscall
.end main
