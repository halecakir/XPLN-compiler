

.data

#main-variables
X_0: .float 0.0
t448_0: .float 0.0
A_0: .float 0.0
t449_0: .float 0.0
B_0: .float 0.0
#.block-1-variables
A_1: .word 16
B_1: .word 24
C_1: .word 32
X_1: .word 40
Y_1: .word 48
t445_1: .word 56
t446_1: .word 64
#.block-2-variables
A_2: .word 16
B_2: .word 24
t447_2: .word 32
#helper-variables
zzeerroo: .float 0.0
newline: .asciiz "\n"

.text


f1:
#push saved registers
subu $sp, $sp, 8
sw $ra, ($sp)
subu $sp, $sp, 8
sw $fp, ($sp)
addu $fp, $sp, 8
#Arg A_1
li $t0, 8
mul $t0, $t0, 1
addu $t0, $t0, $fp
l.s $f2, ($t0)
s.s $f2, A_1
#Arg B_1
li $t0, 8
mul $t0, $t0, 2
addu $t0, $t0, $fp
l.s $f2, ($t0)
s.s $f2, B_1
#Arg C_1
li $t0, 8
mul $t0, $t0, 3
addu $t0, $t0, $fp
l.s $f2, ($t0)
s.s $f2, C_1
#converting to float
li $t0,10
mtc1 $t0,$f6
cvt.s.w $f0,$f6
#conversion done
s.s $f0,X_1
#converting to float
li $t0,11
mtc1 $t0,$f6
cvt.s.w $f0,$f6
#conversion done
s.s $f0,Y_1
#converting to float
li $t0,13
mtc1 $t0,$f6
cvt.s.w $f0,$f6
#conversion done
s.s $f0,X_1
l.s $f0,B_1
l.s $f2,C_1
mul.s $f0,$f0,$f2
s.s $f0,t445_1
l.s $f0,A_1
l.s $f2,t445_1
add.s $f0,$f0,$f2
s.s $f0,t446_1
l.s $f0, t446_1
#load saved registers
lw $ra, ($fp)
lw $fp, -8($fp)
addu $sp, $sp, 16
jr $ra
.end f1


f2:
#push saved registers
subu $sp, $sp, 8
sw $ra, ($sp)
subu $sp, $sp, 8
sw $fp, ($sp)
addu $fp, $sp, 8
#converting to float
li $t0,10
mtc1 $t0,$f6
cvt.s.w $f0,$f6
#conversion done
s.s $f0,A_2
#converting to float
li $t0,2
mtc1 $t0,$f6
cvt.s.w $f0,$f6
#conversion done
s.s $f0,B_2
l.s $f0,A_2
l.s $f2,B_2
div.s $f0,$f0,$f2
s.s $f0,t447_2
l.s $f0, t447_2
#load saved registers
lw $ra, ($fp)
lw $fp, -8($fp)
addu $sp, $sp, 16
jr $ra
.end f2


main:
#converting to float
li $t0,3
mtc1 $t0,$f6
cvt.s.w $f0,$f6
#conversion done
s.s $f0,X_0
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
s.s $f0, t448_0
li $t0, 8
mul $t0, $t0, 3
addu $sp, $sp, $t0
l.s $f0,t448_0
s.s $f0,A_0
#print out A_0
li $v0, 2
l.s $f12, A_0
syscall
li $v0, 4
la $a0, newline
syscall
jal f2
s.s $f0, t449_0
li $t0, 8
mul $t0, $t0, 0
addu $sp, $sp, $t0
l.s $f0,t449_0
s.s $f0,B_0
#print out B_0
li $v0, 2
l.s $f12, B_0
syscall
li $v0, 4
la $a0, newline
syscall
#MIPs termination protocol:
li $v0,10
syscall
.end main