

.data

#.block-0-variables
X_0: .word 16
Y_0: .word 24
Z_0: .word 32
T_0: .word 40
t445_0: .word 48
t446_0: .word 56
t447_0: .word 64
ASSOCIVITYTEST_0: .word 72
t448_0: .word 80
t449_0: .word 88
t450_0: .word 96
#helper-variables
zzeerroo: .float 0.0
newline: .asciiz "\n"
input: .asciiz "Enter input :"

.text


main:
#push saved registers
subu $sp, $sp, 8
sw $ra, ($sp)
subu $sp, $sp, 8
sw $fp, ($sp)
addu $fp, $sp, 8
subu $sp, $sp, 88
#converting to float
li $t0,1
mtc1 $t0,$f6
cvt.s.w $f0,$f6
#conversion done
s.s $f0,X_0($fp)
#converting to float
li $t0,2
mtc1 $t0,$f6
cvt.s.w $f0,$f6
#conversion done
s.s $f0,Y_0($fp)
#converting to float
li $t0,3
mtc1 $t0,$f6
cvt.s.w $f0,$f6
#conversion done
s.s $f0,Z_0($fp)
#converting to float
li $t0,2
mtc1 $t0,$f6
cvt.s.w $f0,$f6
#conversion done
s.s $f0,T_0($fp)
l.s $f0,Y_0($fp)
l.s $f2,Z_0($fp)
mul.s $f0,$f0,$f2
s.s $f0,t445_0($fp)
l.s $f0,t445_0($fp)
l.s $f2,T_0($fp)
div.s $f0,$f0,$f2
s.s $f0,t446_0($fp)
l.s $f0,X_0($fp)
l.s $f2,t446_0($fp)
add.s $f0,$f0,$f2
s.s $f0,t447_0($fp)
l.s $f0,t447_0($fp)
s.s $f0,ASSOCIVITYTEST_0($fp)
#print out ASSOCIVITYTEST_0
li $v0, 2
l.s $f12,ASSOCIVITYTEST_0($fp)
syscall
li $v0, 4
la $a0, newline
syscall
l.s $f0,X_0($fp)
l.s $f2,Y_0($fp)
add.s $f0,$f0,$f2
s.s $f0,t448_0($fp)
l.s $f0,t448_0($fp)
l.s $f2,Z_0($fp)
mul.s $f0,$f0,$f2
s.s $f0,t449_0($fp)
l.s $f0,t449_0($fp)
l.s $f2,T_0($fp)
div.s $f0,$f0,$f2
s.s $f0,t450_0($fp)
l.s $f0,t450_0($fp)
s.s $f0,ASSOCIVITYTEST_0($fp)
#print out ASSOCIVITYTEST_0
li $v0, 2
l.s $f12,ASSOCIVITYTEST_0($fp)
syscall
li $v0, 4
la $a0, newline
syscall
#load saved registers and free memory
lw $ra, ($fp)
lw $fp, -8($fp)
#MIPs termination protocol:
li $v0,10
syscall
.end main