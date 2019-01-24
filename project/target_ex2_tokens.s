

.data

#.block-0-variables
A_0: .word 16
B_0: .word 24
C_0: .word 32
t456_0: .word 40
t457_0: .word 48
t458_0: .word 56
t459_0: .word 64
t460_0: .word 72
t461_0: .word 80
OUT_0: .word 88
t462_0: .word 96
#.block-1-variables
A_1: .word 16
B_1: .word 24
C_1: .word 32
D_1: .word 40
E_1: .word 48
F_1: .word 56
G_1: .word 64
t445_1: .word 72
t446_1: .word 80
t447_1: .word 88
t448_1: .word 96
t449_1: .word 104
t450_1: .word 112
SUM_1: .word 120
t451_1: .word 128
AVERAGE_1: .word 136
#.block-2-variables
A_2: .word 16
B_2: .word 24
C_2: .word 32
t453_2: .word 40
t454_2: .word 48
#helper-variables
zzeerroo: .float 0.0
newline: .asciiz "\n"
input: .asciiz "Enter input :"

.text


avg:
#push saved registers
subu $sp, $sp, 8
sw $ra, ($sp)
subu $sp, $sp, 8
sw $fp, ($sp)
addu $fp, $sp, 8
subu $sp, $sp, 128
#Arg A_1
li $t0, 8
mul $t0, $t0, 1
addu $t0, $t0, $fp
l.s $f2, ($t0)
s.s $f2, A_1($fp)
#Arg B_1
li $t0, 8
mul $t0, $t0, 2
addu $t0, $t0, $fp
l.s $f2, ($t0)
s.s $f2, B_1($fp)
#Arg C_1
li $t0, 8
mul $t0, $t0, 3
addu $t0, $t0, $fp
l.s $f2, ($t0)
s.s $f2, C_1($fp)
#Arg D_1
li $t0, 8
mul $t0, $t0, 4
addu $t0, $t0, $fp
l.s $f2, ($t0)
s.s $f2, D_1($fp)
#Arg E_1
li $t0, 8
mul $t0, $t0, 5
addu $t0, $t0, $fp
l.s $f2, ($t0)
s.s $f2, E_1($fp)
#Arg F_1
li $t0, 8
mul $t0, $t0, 6
addu $t0, $t0, $fp
l.s $f2, ($t0)
s.s $f2, F_1($fp)
#Arg G_1
li $t0, 8
mul $t0, $t0, 7
addu $t0, $t0, $fp
l.s $f2, ($t0)
s.s $f2, G_1($fp)
l.s $f0,A_1($fp)
l.s $f2,B_1($fp)
add.s $f0,$f0,$f2
s.s $f0,t445_1($fp)
l.s $f0,t445_1($fp)
l.s $f2,C_1($fp)
add.s $f0,$f0,$f2
s.s $f0,t446_1($fp)
l.s $f0,t446_1($fp)
l.s $f2,D_1($fp)
add.s $f0,$f0,$f2
s.s $f0,t447_1($fp)
l.s $f0,t447_1($fp)
l.s $f2,E_1($fp)
add.s $f0,$f0,$f2
s.s $f0,t448_1($fp)
l.s $f0,t448_1($fp)
l.s $f2,F_1($fp)
add.s $f0,$f0,$f2
s.s $f0,t449_1($fp)
l.s $f0,t449_1($fp)
l.s $f2,G_1($fp)
add.s $f0,$f0,$f2
s.s $f0,t450_1($fp)
l.s $f0,t450_1($fp)
s.s $f0,SUM_1($fp)
l.s $f0,SUM_1($fp)
#converting to float
li $t0,7
mtc1 $t0,$f6
cvt.s.w $f2,$f6
#conversion done
div.s $f0,$f0,$f2
s.s $f0,t451_1($fp)
l.s $f0,t451_1($fp)
s.s $f0,AVERAGE_1($fp)
l.s $f0,AVERAGE_1($fp)
j l452
l452:
#load saved registers and free memory
lw $ra, ($fp)
lw $fp, -8($fp)
#clean stack memory and return
addu $sp, $sp, 16
addu $sp, $sp, 128
jr $ra
.end avg


f2:
#push saved registers
subu $sp, $sp, 8
sw $ra, ($sp)
subu $sp, $sp, 8
sw $fp, ($sp)
addu $fp, $sp, 8
subu $sp, $sp, 40
#Arg A_2
li $t0, 8
mul $t0, $t0, 1
addu $t0, $t0, $fp
l.s $f2, ($t0)
s.s $f2, A_2($fp)
#Arg B_2
li $t0, 8
mul $t0, $t0, 2
addu $t0, $t0, $fp
l.s $f2, ($t0)
s.s $f2, B_2($fp)
#Arg C_2
li $t0, 8
mul $t0, $t0, 3
addu $t0, $t0, $fp
l.s $f2, ($t0)
s.s $f2, C_2($fp)
l.s $f0,B_2($fp)
l.s $f2,C_2($fp)
mul.s $f0,$f0,$f2
s.s $f0,t453_2($fp)
l.s $f0,A_2($fp)
l.s $f2,t453_2($fp)
add.s $f0,$f0,$f2
s.s $f0,t454_2($fp)
l.s $f0,t454_2($fp)
j l455
l455:
#load saved registers and free memory
lw $ra, ($fp)
lw $fp, -8($fp)
#clean stack memory and return
addu $sp, $sp, 16
addu $sp, $sp, 40
jr $ra
.end f2


main:
#push saved registers
subu $sp, $sp, 8
sw $ra, ($sp)
subu $sp, $sp, 8
sw $fp, ($sp)
addu $fp, $sp, 8
subu $sp, $sp, 88
#converting to float
li $t0,0
mtc1 $t0,$f6
cvt.s.w $f0,$f6
#conversion done
s.s $f0,A_0($fp)
#converting to float
li $t0,1
mtc1 $t0,$f6
cvt.s.w $f0,$f6
#conversion done
s.s $f0,B_0($fp)
#converting to float
li $t0,2
mtc1 $t0,$f6
cvt.s.w $f0,$f6
#conversion done
s.s $f0,C_0($fp)
#push actual argument 7
subu $sp, $sp, 8
#converting to float
li $t0,7
mtc1 $t0,$f6
cvt.s.w $f0,$f6
#conversion done
s.s $f0, ($sp)
#push actual argument 6
subu $sp, $sp, 8
#converting to float
li $t0,6
mtc1 $t0,$f6
cvt.s.w $f0,$f6
#conversion done
s.s $f0, ($sp)
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
#push actual argument C_0
subu $sp, $sp, 8
l.s $f0,C_0($fp)
s.s $f0, ($sp)
#push actual argument B_0
subu $sp, $sp, 8
l.s $f0,B_0($fp)
s.s $f0, ($sp)
#push actual argument A_0
subu $sp, $sp, 8
l.s $f0,A_0($fp)
s.s $f0, ($sp)
jal f2
s.s $f0, t459_0($fp)
li $t0, 8
mul $t0, $t0, 3
addu $sp, $sp, $t0
#push actual argument t459_0
subu $sp, $sp, 8
l.s $f0,t459_0($fp)
s.s $f0, ($sp)
#push actual argument C_0
subu $sp, $sp, 8
l.s $f0,C_0($fp)
s.s $f0, ($sp)
#push actual argument B_0
subu $sp, $sp, 8
l.s $f0,B_0($fp)
s.s $f0, ($sp)
#push actual argument A_0
subu $sp, $sp, 8
l.s $f0,A_0($fp)
s.s $f0, ($sp)
jal f2
s.s $f0, t458_0($fp)
li $t0, 8
mul $t0, $t0, 3
addu $sp, $sp, $t0
#push actual argument t458_0
subu $sp, $sp, 8
l.s $f0,t458_0($fp)
s.s $f0, ($sp)
#push actual argument C_0
subu $sp, $sp, 8
l.s $f0,C_0($fp)
s.s $f0, ($sp)
#push actual argument B_0
subu $sp, $sp, 8
l.s $f0,B_0($fp)
s.s $f0, ($sp)
#push actual argument A_0
subu $sp, $sp, 8
l.s $f0,A_0($fp)
s.s $f0, ($sp)
jal f2
s.s $f0, t457_0($fp)
li $t0, 8
mul $t0, $t0, 3
addu $sp, $sp, $t0
#push actual argument t457_0
subu $sp, $sp, 8
l.s $f0,t457_0($fp)
s.s $f0, ($sp)
jal f2
s.s $f0, t460_0($fp)
li $t0, 8
mul $t0, $t0, 3
addu $sp, $sp, $t0
#push actual argument t460_0
subu $sp, $sp, 8
l.s $f0,t460_0($fp)
s.s $f0, ($sp)
#push actual argument C_0
subu $sp, $sp, 8
l.s $f0,C_0($fp)
s.s $f0, ($sp)
#push actual argument B_0
subu $sp, $sp, 8
l.s $f0,B_0($fp)
s.s $f0, ($sp)
#push actual argument A_0
subu $sp, $sp, 8
l.s $f0,A_0($fp)
s.s $f0, ($sp)
jal f2
s.s $f0, t456_0($fp)
li $t0, 8
mul $t0, $t0, 3
addu $sp, $sp, $t0
#push actual argument t456_0
subu $sp, $sp, 8
l.s $f0,t456_0($fp)
s.s $f0, ($sp)
jal avg
s.s $f0, t461_0($fp)
li $t0, 8
mul $t0, $t0, 7
addu $sp, $sp, $t0
l.s $f0,t461_0($fp)
s.s $f0,OUT_0($fp)
#converting to float
li $t0,2
mtc1 $t0,$f6
cvt.s.w $f0,$f6
#conversion done
l.s $f2,OUT_0($fp)
mul.s $f0,$f0,$f2
s.s $f0,t462_0($fp)
#print out t462_0
li $v0, 2
l.s $f12,t462_0($fp)
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