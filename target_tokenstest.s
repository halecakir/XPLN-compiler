

.data

#.block-0-variables
X_0: .word 16
t453_0: .word 24
A_0: .word 32
B_0: .word 40
t454_0: .word 48
t455_0: .word 56
t456_0: .word 64
C_0: .word 72
t457_0: .word 80
t458_0: .word 88
t461_0: .word 96
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
#.block-3-variables
N_3: .word 16
SUM_3: .word 24
I_3: .word 32
t448_3: .word 40
t449_3: .word 48
t450_3: .word 56
#helper-variables
zzeerroo: .float 0.0
newline: .asciiz "\n"
input: .asciiz "Enter input :"

.text


f1:
#push saved registers
subu $sp, $sp, 8
sw $ra, ($sp)
subu $sp, $sp, 8
sw $fp, ($sp)
addu $fp, $sp, 8
subu $sp, $sp, 56
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
#converting to float
li $t0,10
mtc1 $t0,$f6
cvt.s.w $f0,$f6
#conversion done
s.s $f0,X_1($fp)
#converting to float
li $t0,11
mtc1 $t0,$f6
cvt.s.w $f0,$f6
#conversion done
s.s $f0,Y_1($fp)
#converting to float
li $t0,13
mtc1 $t0,$f6
cvt.s.w $f0,$f6
#conversion done
s.s $f0,X_1($fp)
l.s $f0,B_1($fp)
l.s $f2,C_1($fp)
mul.s $f0,$f0,$f2
s.s $f0,t445_1($fp)
l.s $f0,A_1($fp)
l.s $f2,t445_1($fp)
add.s $f0,$f0,$f2
s.s $f0,t446_1($fp)
l.s $f0, t446_1($fp)
#load saved registers and free memory
lw $ra, ($fp)
lw $fp, -8($fp)
#clean stack memory and return
addu $sp, $sp, 16
addu $sp, $sp, 56
jr $ra
.end f1


f2:
#push saved registers
subu $sp, $sp, 8
sw $ra, ($sp)
subu $sp, $sp, 8
sw $fp, ($sp)
addu $fp, $sp, 8
subu $sp, $sp, 24
#converting to float
li $t0,10
mtc1 $t0,$f6
cvt.s.w $f0,$f6
#conversion done
s.s $f0,A_2($fp)
#converting to float
li $t0,2
mtc1 $t0,$f6
cvt.s.w $f0,$f6
#conversion done
s.s $f0,B_2($fp)
l.s $f0,A_2($fp)
l.s $f2,B_2($fp)
div.s $f0,$f0,$f2
s.s $f0,t447_2($fp)
l.s $f0, t447_2($fp)
#load saved registers and free memory
lw $ra, ($fp)
lw $fp, -8($fp)
#clean stack memory and return
addu $sp, $sp, 16
addu $sp, $sp, 24
jr $ra
.end f2


f3:
#push saved registers
subu $sp, $sp, 8
sw $ra, ($sp)
subu $sp, $sp, 8
sw $fp, ($sp)
addu $fp, $sp, 8
subu $sp, $sp, 48
#Arg N_3
li $t0, 8
mul $t0, $t0, 1
addu $t0, $t0, $fp
l.s $f2, ($t0)
s.s $f2, N_3($fp)
#converting to float
li $t0,0
mtc1 $t0,$f6
cvt.s.w $f0,$f6
#conversion done
s.s $f0,SUM_3($fp)
#converting to float
li $t0,0
mtc1 $t0,$f6
cvt.s.w $f0,$f6
#conversion done
s.s $f0,I_3($fp)
l451:
l.s $f0,I_3($fp)
l.s $f2,N_3($fp)
c.le.s $f0, $f2
cfc1 $t0,$25
andi $t0,1
mtc1 $t0,$f6
cvt.s.w $f0,$f6
s.s $f0,t448_3($fp)
l.s $f2,t448_3($fp)
li.s $f4, 0.0
c.eq.s $f2, $f4
bc1t l452
l.s $f0,SUM_3($fp)
l.s $f2,I_3($fp)
add.s $f0,$f0,$f2
s.s $f0,t450_3($fp)
l.s $f0,t450_3($fp)
s.s $f0,SUM_3($fp)
l.s $f0,I_3($fp)
#converting to float
li $t0,1
mtc1 $t0,$f6
cvt.s.w $f2,$f6
#conversion done
add.s $f0,$f0,$f2
s.s $f0,t449_3($fp)
l.s $f0,t449_3($fp)
s.s $f0,I_3($fp)
j l451
l452:
l.s $f0, SUM_3($fp)
#load saved registers and free memory
lw $ra, ($fp)
lw $fp, -8($fp)
#clean stack memory and return
addu $sp, $sp, 16
addu $sp, $sp, 48
jr $ra
.end f3


main:
#push saved registers
subu $sp, $sp, 8
sw $ra, ($sp)
subu $sp, $sp, 8
sw $fp, ($sp)
addu $fp, $sp, 8
subu $sp, $sp, 88
#converting to float
li $t0,3
mtc1 $t0,$f6
cvt.s.w $f0,$f6
#conversion done
s.s $f0,X_0($fp)
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
s.s $f0, t453_0($fp)
li $t0, 8
mul $t0, $t0, 3
addu $sp, $sp, $t0
l.s $f0,t453_0($fp)
s.s $f0,A_0($fp)
#print out A_0
li $v0, 2
l.s $f12,A_0($fp)
syscall
li $v0, 4
la $a0, newline
syscall
#converting to float
li $t0,3
mtc1 $t0,$f6
cvt.s.w $f0,$f6
#conversion done
s.s $f0,A_0($fp)
#converting to float
li $t0,8
mtc1 $t0,$f6
cvt.s.w $f0,$f6
#conversion done
s.s $f0,B_0($fp)
l.s $f0,A_0($fp)
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
s.s $f0,t454_0($fp)
l.s $f0,B_0($fp)
#converting to float
li $t0,5
mtc1 $t0,$f6
cvt.s.w $f2,$f6
#conversion done
c.eq.s $f0, $f2
cfc1 $t0,$25
andi $t0,1
mtc1 $t0,$f6
cvt.s.w $f0,$f6
s.s $f0,t455_0($fp)
l.s $f0,t454_0($fp)
l.s $f2,t455_0($fp)
li.s $f4, 0.0
c.eq.s $f0, $f4
cfc1 $t0,$25
not $t0,$t0
andi $t0,1
c.eq.s $f2, $f4
cfc1 $t1,$25
not $t1,$t1
andi $t1,1
and $t2,$t0,$t1
mtc1 $t2,$f6
cvt.s.w $f0,$f6
s.s $f0,t456_0($fp)
l.s $f2,t456_0($fp)
li.s $f4, 0.0
c.eq.s $f2, $f4
bc1t l459
#converting to float
li $t0,12
mtc1 $t0,$f6
cvt.s.w $f0,$f6
#conversion done
s.s $f0,C_0($fp)
l.s $f0,A_0($fp)
l.s $f2,B_0($fp)
mul.s $f0,$f0,$f2
s.s $f0,t457_0($fp)
#print out t457_0
li $v0, 2
l.s $f12,t457_0($fp)
syscall
li $v0, 4
la $a0, newline
syscall
l.s $f0,A_0($fp)
l.s $f2,B_0($fp)
sub.s $f0,$f0,$f2
s.s $f0,t458_0($fp)
#print out t458_0
li $v0, 2
l.s $f12,t458_0($fp)
syscall
li $v0, 4
la $a0, newline
syscall
j l460
l459:
#print out 12
li $v0, 2
#converting to float
li $t0,12
mtc1 $t0,$f6
cvt.s.w $f12,$f6
#conversion done
syscall
li $v0, 4
la $a0, newline
syscall
l460:
#converting to float
li $t0,3
mtc1 $t0,$f6
cvt.s.w $f2,$f6
#conversion done
li.s $f4, 0.0
c.eq.s $f2, $f4
cfc1 $t0,$25
andi $t0,1
mtc1 $t0,$f6
cvt.s.w $f0,$f6
s.s $f0,t461_0($fp)
l.s $f2,t461_0($fp)
li.s $f4, 0.0
c.eq.s $f2, $f4
bc1t l462
#print out 22
li $v0, 2
#converting to float
li $t0,22
mtc1 $t0,$f6
cvt.s.w $f12,$f6
#conversion done
syscall
li $v0, 4
la $a0, newline
syscall
l462:
l.s $f2,A_0($fp)
li.s $f4, 0.0
c.eq.s $f2, $f4
bc1t l463
#print out A_0
li $v0, 2
l.s $f12,A_0($fp)
syscall
li $v0, 4
la $a0, newline
syscall
l463:
#load saved registers and free memory
lw $ra, ($fp)
lw $fp, -8($fp)
#MIPs termination protocol:
li $v0,10
syscall
.end main