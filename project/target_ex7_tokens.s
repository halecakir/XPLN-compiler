

.data

#.block-0-variables
HEIGHT_0: .word 16
MASS_0: .word 24
t447_0: .word 32
t448_0: .word 40
t450_0: .word 48
t451_0: .word 56
t452_0: .word 64
t453_0: .word 72
t454_0: .word 80
t456_0: .word 88
t457_0: .word 96
t458_0: .word 104
t459_0: .word 112
t460_0: .word 120
t462_0: .word 128
t463_0: .word 136
t465_0: .word 144
t466_0: .word 152
#.block-1-variables
BODY_1: .word 16
MASS_1: .word 24
t445_1: .word 32
#helper-variables
zzeerroo: .float 0.0
newline: .asciiz "\n"
input: .asciiz "Enter input :"

.text


bmi:
#push saved registers
subu $sp, $sp, 8
sw $ra, ($sp)
subu $sp, $sp, 8
sw $fp, ($sp)
addu $fp, $sp, 8
subu $sp, $sp, 24
#Arg BODY_1
li $t0, 8
mul $t0, $t0, 1
addu $t0, $t0, $fp
l.s $f2, ($t0)
s.s $f2, BODY_1($fp)
#Arg MASS_1
li $t0, 8
mul $t0, $t0, 2
addu $t0, $t0, $fp
l.s $f2, ($t0)
s.s $f2, MASS_1($fp)
l.s $f0,BODY_1($fp)
l.s $f2,MASS_1($fp)
div.s $f0,$f0,$f2
s.s $f0,t445_1($fp)
l.s $f0,t445_1($fp)
j l446
l446:
#load saved registers and free memory
lw $ra, ($fp)
lw $fp, -8($fp)
#clean stack memory and return
addu $sp, $sp, 16
addu $sp, $sp, 24
jr $ra
.end bmi


main:
#push saved registers
subu $sp, $sp, 8
sw $ra, ($sp)
subu $sp, $sp, 8
sw $fp, ($sp)
addu $fp, $sp, 8
subu $sp, $sp, 144
#read float HEIGHT_0
li $v0, 4
la $a0, input
syscall
li $v0, 6
syscall
s.s $f0, HEIGHT_0($fp)
#read float MASS_0
li $v0, 4
la $a0, input
syscall
li $v0, 6
syscall
s.s $f0, MASS_0($fp)
#push actual argument MASS_0
subu $sp, $sp, 8
l.s $f0,MASS_0($fp)
s.s $f0, ($sp)
#push actual argument HEIGHT_0
subu $sp, $sp, 8
l.s $f0,HEIGHT_0($fp)
s.s $f0, ($sp)
jal bmi
s.s $f0, t447_0($fp)
li $t0, 8
mul $t0, $t0, 2
addu $sp, $sp, $t0
l.s $f0,t447_0($fp)
#converting to float
li $t0,18
mtc1 $t0,$f6
cvt.s.w $f2,$f6
#conversion done
c.le.s $f0, $f2
cfc1 $t0,$25
andi $t0,1
mtc1 $t0,$f6
cvt.s.w $f0,$f6
s.s $f0,t448_0($fp)
l.s $f2,t448_0($fp)
li.s $f4, 0.0
c.eq.s $f2, $f4
bc1t l449
#print out 1
li $v0, 2
#converting to float
li $t0,1
mtc1 $t0,$f6
cvt.s.w $f12,$f6
#conversion done
syscall
li $v0, 4
la $a0, newline
syscall
l449:
#push actual argument MASS_0
subu $sp, $sp, 8
l.s $f0,MASS_0($fp)
s.s $f0, ($sp)
#push actual argument HEIGHT_0
subu $sp, $sp, 8
l.s $f0,HEIGHT_0($fp)
s.s $f0, ($sp)
jal bmi
s.s $f0, t450_0($fp)
li $t0, 8
mul $t0, $t0, 2
addu $sp, $sp, $t0
l.s $f0,t450_0($fp)
#converting to float
li $t0,18
mtc1 $t0,$f6
cvt.s.w $f2,$f6
#conversion done
c.lt.s $f2, $f0
cfc1 $t0,$25
andi $t0,1
mtc1 $t0,$f6
cvt.s.w $f0,$f6
s.s $f0,t451_0($fp)
#push actual argument MASS_0
subu $sp, $sp, 8
l.s $f0,MASS_0($fp)
s.s $f0, ($sp)
#push actual argument HEIGHT_0
subu $sp, $sp, 8
l.s $f0,HEIGHT_0($fp)
s.s $f0, ($sp)
jal bmi
s.s $f0, t452_0($fp)
li $t0, 8
mul $t0, $t0, 2
addu $sp, $sp, $t0
l.s $f0,t452_0($fp)
#converting to float
li $t0,25
mtc1 $t0,$f6
cvt.s.w $f2,$f6
#conversion done
c.le.s $f0, $f2
cfc1 $t0,$25
andi $t0,1
mtc1 $t0,$f6
cvt.s.w $f0,$f6
s.s $f0,t453_0($fp)
l.s $f0,t451_0($fp)
l.s $f2,t453_0($fp)
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
s.s $f0,t454_0($fp)
l.s $f2,t454_0($fp)
li.s $f4, 0.0
c.eq.s $f2, $f4
bc1t l455
#print out 2
li $v0, 2
#converting to float
li $t0,2
mtc1 $t0,$f6
cvt.s.w $f12,$f6
#conversion done
syscall
li $v0, 4
la $a0, newline
syscall
l455:
#push actual argument MASS_0
subu $sp, $sp, 8
l.s $f0,MASS_0($fp)
s.s $f0, ($sp)
#push actual argument HEIGHT_0
subu $sp, $sp, 8
l.s $f0,HEIGHT_0($fp)
s.s $f0, ($sp)
jal bmi
s.s $f0, t456_0($fp)
li $t0, 8
mul $t0, $t0, 2
addu $sp, $sp, $t0
l.s $f0,t456_0($fp)
#converting to float
li $t0,25
mtc1 $t0,$f6
cvt.s.w $f2,$f6
#conversion done
c.lt.s $f2, $f0
cfc1 $t0,$25
andi $t0,1
mtc1 $t0,$f6
cvt.s.w $f0,$f6
s.s $f0,t457_0($fp)
#push actual argument MASS_0
subu $sp, $sp, 8
l.s $f0,MASS_0($fp)
s.s $f0, ($sp)
#push actual argument HEIGHT_0
subu $sp, $sp, 8
l.s $f0,HEIGHT_0($fp)
s.s $f0, ($sp)
jal bmi
s.s $f0, t458_0($fp)
li $t0, 8
mul $t0, $t0, 2
addu $sp, $sp, $t0
l.s $f0,t458_0($fp)
#converting to float
li $t0,30
mtc1 $t0,$f6
cvt.s.w $f2,$f6
#conversion done
c.le.s $f0, $f2
cfc1 $t0,$25
andi $t0,1
mtc1 $t0,$f6
cvt.s.w $f0,$f6
s.s $f0,t459_0($fp)
l.s $f0,t457_0($fp)
l.s $f2,t459_0($fp)
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
s.s $f0,t460_0($fp)
l.s $f2,t460_0($fp)
li.s $f4, 0.0
c.eq.s $f2, $f4
bc1t l461
#print out 3
li $v0, 2
#converting to float
li $t0,3
mtc1 $t0,$f6
cvt.s.w $f12,$f6
#conversion done
syscall
li $v0, 4
la $a0, newline
syscall
l461:
#push actual argument MASS_0
subu $sp, $sp, 8
l.s $f0,MASS_0($fp)
s.s $f0, ($sp)
#push actual argument HEIGHT_0
subu $sp, $sp, 8
l.s $f0,HEIGHT_0($fp)
s.s $f0, ($sp)
jal bmi
s.s $f0, t462_0($fp)
li $t0, 8
mul $t0, $t0, 2
addu $sp, $sp, $t0
l.s $f0,t462_0($fp)
#converting to float
li $t0,30
mtc1 $t0,$f6
cvt.s.w $f2,$f6
#conversion done
c.lt.s $f2, $f0
cfc1 $t0,$25
andi $t0,1
mtc1 $t0,$f6
cvt.s.w $f0,$f6
s.s $f0,t463_0($fp)
l.s $f2,t463_0($fp)
li.s $f4, 0.0
c.eq.s $f2, $f4
bc1t l464
#print out 4
li $v0, 2
#converting to float
li $t0,4
mtc1 $t0,$f6
cvt.s.w $f12,$f6
#conversion done
syscall
li $v0, 4
la $a0, newline
syscall
l464:
#push actual argument MASS_0
subu $sp, $sp, 8
l.s $f0,MASS_0($fp)
s.s $f0, ($sp)
#push actual argument HEIGHT_0
subu $sp, $sp, 8
l.s $f0,HEIGHT_0($fp)
s.s $f0, ($sp)
jal bmi
s.s $f0, t465_0($fp)
li $t0, 8
mul $t0, $t0, 2
addu $sp, $sp, $t0
l.s $f0,t465_0($fp)
#converting to float
li $t0,18
mtc1 $t0,$f6
cvt.s.w $f2,$f6
#conversion done
c.le.s $f0, $f2
cfc1 $t0,$25
andi $t0,1
mtc1 $t0,$f6
cvt.s.w $f0,$f6
s.s $f0,t466_0($fp)
l.s $f2,t466_0($fp)
li.s $f4, 0.0
c.eq.s $f2, $f4
bc1t l467
#print out 1
li $v0, 2
#converting to float
li $t0,1
mtc1 $t0,$f6
cvt.s.w $f12,$f6
#conversion done
syscall
li $v0, 4
la $a0, newline
syscall
j l468
l467:
#print out 5
li $v0, 2
#converting to float
li $t0,5
mtc1 $t0,$f6
cvt.s.w $f12,$f6
#conversion done
syscall
li $v0, 4
la $a0, newline
syscall
l468:
#load saved registers and free memory
lw $ra, ($fp)
lw $fp, -8($fp)
#MIPs termination protocol:
li $v0,10
syscall
.end main