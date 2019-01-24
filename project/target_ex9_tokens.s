

.data

#.block-0-variables
I_0: .word 16
t455_0: .word 24
FIBRESULT_0: .word 32
#.block-1-variables
N_1: .word 16
t445_1: .word 24
t448_1: .word 32
t450_1: .word 40
t451_1: .word 48
t452_1: .word 56
t453_1: .word 64
t454_1: .word 72
#helper-variables
zzeerroo: .float 0.0
newline: .asciiz "\n"
input: .asciiz "Enter input :"

.text


fibonacci:
#push saved registers
subu $sp, $sp, 8
sw $ra, ($sp)
subu $sp, $sp, 8
sw $fp, ($sp)
addu $fp, $sp, 8
subu $sp, $sp, 64
#Arg N_1
li $t0, 8
mul $t0, $t0, 1
addu $t0, $t0, $fp
l.s $f2, ($t0)
s.s $f2, N_1($fp)
l.s $f0,N_1($fp)
#converting to float
li $t0,0
mtc1 $t0,$f6
cvt.s.w $f2,$f6
#conversion done
c.eq.s $f0, $f2
cfc1 $t0,$25
andi $t0,1
mtc1 $t0,$f6
cvt.s.w $f0,$f6
s.s $f0,t445_1($fp)
l.s $f2,t445_1($fp)
li.s $f4, 0.0
c.eq.s $f2, $f4
bc1t l447
#converting to float
li $t0,0
mtc1 $t0,$f6
cvt.s.w $f0,$f6
#conversion done
j l446
l447:
l.s $f0,N_1($fp)
#converting to float
li $t0,1
mtc1 $t0,$f6
cvt.s.w $f2,$f6
#conversion done
c.eq.s $f0, $f2
cfc1 $t0,$25
andi $t0,1
mtc1 $t0,$f6
cvt.s.w $f0,$f6
s.s $f0,t448_1($fp)
l.s $f2,t448_1($fp)
li.s $f4, 0.0
c.eq.s $f2, $f4
bc1t l449
#converting to float
li $t0,1
mtc1 $t0,$f6
cvt.s.w $f0,$f6
#conversion done
j l446
l449:
l.s $f0,N_1($fp)
#converting to float
li $t0,1
mtc1 $t0,$f6
cvt.s.w $f2,$f6
#conversion done
sub.s $f0,$f0,$f2
s.s $f0,t450_1($fp)
#push actual argument t450_1
subu $sp, $sp, 8
l.s $f0,t450_1($fp)
s.s $f0, ($sp)
jal fibonacci
s.s $f0, t451_1($fp)
li $t0, 8
mul $t0, $t0, 1
addu $sp, $sp, $t0
l.s $f0,N_1($fp)
#converting to float
li $t0,2
mtc1 $t0,$f6
cvt.s.w $f2,$f6
#conversion done
sub.s $f0,$f0,$f2
s.s $f0,t452_1($fp)
#push actual argument t452_1
subu $sp, $sp, 8
l.s $f0,t452_1($fp)
s.s $f0, ($sp)
jal fibonacci
s.s $f0, t453_1($fp)
li $t0, 8
mul $t0, $t0, 1
addu $sp, $sp, $t0
l.s $f0,t451_1($fp)
l.s $f2,t453_1($fp)
add.s $f0,$f0,$f2
s.s $f0,t454_1($fp)
l.s $f0,t454_1($fp)
j l446
l446:
#load saved registers and free memory
lw $ra, ($fp)
lw $fp, -8($fp)
#clean stack memory and return
addu $sp, $sp, 16
addu $sp, $sp, 64
jr $ra
.end fibonacci


main:
#push saved registers
subu $sp, $sp, 8
sw $ra, ($sp)
subu $sp, $sp, 8
sw $fp, ($sp)
addu $fp, $sp, 8
subu $sp, $sp, 24
#read float I_0
li $v0, 4
la $a0, input
syscall
li $v0, 6
syscall
s.s $f0, I_0($fp)
#push actual argument I_0
subu $sp, $sp, 8
l.s $f0,I_0($fp)
s.s $f0, ($sp)
jal fibonacci
s.s $f0, t455_0($fp)
li $t0, 8
mul $t0, $t0, 1
addu $sp, $sp, $t0
l.s $f0,t455_0($fp)
s.s $f0,FIBRESULT_0($fp)
#print out FIBRESULT_0
li $v0, 2
l.s $f12,FIBRESULT_0($fp)
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