

.data

X: .float 0.0
A: .float 0.0
B: .float 0.0
C: .float 0.0
t445: .float 0.0
t446: .float 0.0
F1: .float 0.0
t447: .float 0.0
zzeerroo: .float 0.0
newline: .asciiz "\n"

.text


f1:
#push saved registers
subu $sp, $sp, 8
sw $ra, ($sp)
subu $sp, $sp, 8
sw $fp, ($sp)
addu $fp, $sp, 16
#Arg A
li $t0, 8
mul $t0, $t0, 0
addu $t0, $t0, $fp
l.s $f2, ($t0)
s.s $f2, A
#Arg B
li $t0, 8
mul $t0, $t0, 1
addu $t0, $t0, $fp
l.s $f2, ($t0)
s.s $f2, B
#Arg C
li $t0, 8
mul $t0, $t0, 2
addu $t0, $t0, $fp
l.s $f2, ($t0)
s.s $f2, C
l.s $f0,B
l.s $f2,C
mul.s $f0,$f0,$f2
s.s $f0,t445
l.s $f0,A
l.s $f2,t445
add.s $f0,$f0,$f2
s.s $f0,t446
l.s $f0, t446
#load saved registers
lw $ra, ($fp)
lw $fp, 8($fp)
addi $sp, $sp, 16
jr $ra
.end f1


main:
#converting to float
li $t0,3
mtc1 $t0,$f6
cvt.s.w $f0,$f6
#conversion done
s.s $f0,X
#push actual argument 5
subu $sp, $sp, 8
#converting to float
li $t0,5
mtc1 $t0,$f6
cvt.s.w $f0,$f6
#conversion done
s.s $f0, ($sp)
#push actual argument 4
subu $sp, $sp, 8
#converting to float
li $t0,4
mtc1 $t0,$f6
cvt.s.w $f0,$f6
#conversion done
s.s $f0, ($sp)
#push actual argument 3
subu $sp, $sp, 8
#converting to float
li $t0,3
mtc1 $t0,$f6
cvt.s.w $f0,$f6
#conversion done
s.s $f0, ($sp)
jal f1
s.s $f0, t447
li $t0, 8
mul $t0, $t0, 3
addu $sp, $sp, $t0
l.s $f0,t447
s.s $f0,A
#print out A
li $v0, 2
l.s $f12, A
syscall
li $v0, 4
la $a0, newline
syscall
#MIPs termination protocol:
li $v0,10
syscall
.end main