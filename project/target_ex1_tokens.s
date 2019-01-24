

.data

#.block-0-variables
FN_0: .word 16
t453_0: .word 24
RESULT_0: .word 32
#.block-1-variables
NUM_1: .word 16
t445_1: .word 24
t446_1: .word 32
t447_1: .word 40
t450_1: .word 48
t451_1: .word 56
t452_1: .word 64
#helper-variables
zzeerroo: .float 0.0
newline: .asciiz "\n"
input: .asciiz "Enter input :"

.text


factorialrecursive:
#push saved registers
subu $sp, $sp, 8
sw $ra, ($sp)
subu $sp, $sp, 8
sw $fp, ($sp)
addu $fp, $sp, 8
subu $sp, $sp, 56
#Arg NUM_1
li $t0, 8
mul $t0, $t0, 1
addu $t0, $t0, $fp
l.s $f2, ($t0)
s.s $f2, NUM_1($fp)
l.s $f0,NUM_1($fp)
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
l.s $f0,NUM_1($fp)
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
s.s $f0,t446_1($fp)
l.s $f0,t445_1($fp)
l.s $f2,t446_1($fp)
li.s $f4, 0.0
c.eq.s $f0, $f4
cfc1 $t0,$25
not $t0,$t0
andi $t0,1
c.eq.s $f2, $f4
cfc1 $t1,$25
not $t1,$t1
andi $t1,1
or $t2,$t0,$t1
mtc1 $t2,$f6
cvt.s.w $f0,$f6
s.s $f0,t447_1($fp)
l.s $f2,t447_1($fp)
li.s $f4, 0.0
c.eq.s $f2, $f4
bc1t l449
#converting to float
li $t0,1
mtc1 $t0,$f6
cvt.s.w $f0,$f6
#conversion done
j l448
l449:
l.s $f0,NUM_1($fp)
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
jal factorialrecursive
s.s $f0, t451_1($fp)
li $t0, 8
mul $t0, $t0, 1
addu $sp, $sp, $t0
l.s $f0,NUM_1($fp)
l.s $f2,t451_1($fp)
mul.s $f0,$f0,$f2
s.s $f0,t452_1($fp)
l.s $f0,t452_1($fp)
j l448
l448:
#load saved registers and free memory
lw $ra, ($fp)
lw $fp, -8($fp)
#clean stack memory and return
addu $sp, $sp, 16
addu $sp, $sp, 56
jr $ra
.end factorialrecursive


main:
#push saved registers
subu $sp, $sp, 8
sw $ra, ($sp)
subu $sp, $sp, 8
sw $fp, ($sp)
addu $fp, $sp, 8
subu $sp, $sp, 24
#read float FN_0
li $v0, 4
la $a0, input
syscall
li $v0, 6
syscall
s.s $f0, FN_0($fp)
#push actual argument FN_0
subu $sp, $sp, 8
l.s $f0,FN_0($fp)
s.s $f0, ($sp)
jal factorialrecursive
s.s $f0, t453_0($fp)
li $t0, 8
mul $t0, $t0, 1
addu $sp, $sp, $t0
l.s $f0,t453_0($fp)
s.s $f0,RESULT_0($fp)
#print out RESULT_0
li $v0, 2
l.s $f12,RESULT_0($fp)
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