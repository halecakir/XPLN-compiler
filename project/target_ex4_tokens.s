

.data

#.block-0-variables
SUM_0: .word 16
I_0: .word 24
t445_0: .word 32
t446_0: .word 40
J_0: .word 48
t447_0: .word 56
t448_0: .word 64
K_0: .word 72
t449_0: .word 80
t450_0: .word 88
t451_0: .word 96
t458_0: .word 104
t459_0: .word 112
t460_0: .word 120
t461_0: .word 128
t462_0: .word 136
t465_0: .word 144
t468_0: .word 152
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
subu $sp, $sp, 144
#converting to float
li $t0,0
mtc1 $t0,$f6
cvt.s.w $f0,$f6
#conversion done
s.s $f0,SUM_0($fp)
#converting to float
li $t0,0
mtc1 $t0,$f6
cvt.s.w $f0,$f6
#conversion done
s.s $f0,I_0($fp)
l456:
l.s $f0,I_0($fp)
#converting to float
li $t0,10
mtc1 $t0,$f6
cvt.s.w $f2,$f6
#conversion done
c.lt.s $f0, $f2
cfc1 $t0,$25
andi $t0,1
mtc1 $t0,$f6
cvt.s.w $f0,$f6
s.s $f0,t445_0($fp)
l.s $f2,t445_0($fp)
li.s $f4, 0.0
c.eq.s $f2, $f4
bc1t l457
#converting to float
li $t0,0
mtc1 $t0,$f6
cvt.s.w $f0,$f6
#conversion done
s.s $f0,J_0($fp)
l454:
l.s $f0,J_0($fp)
#converting to float
li $t0,10
mtc1 $t0,$f6
cvt.s.w $f2,$f6
#conversion done
c.lt.s $f0, $f2
cfc1 $t0,$25
andi $t0,1
mtc1 $t0,$f6
cvt.s.w $f0,$f6
s.s $f0,t447_0($fp)
l.s $f2,t447_0($fp)
li.s $f4, 0.0
c.eq.s $f2, $f4
bc1t l455
#converting to float
li $t0,0
mtc1 $t0,$f6
cvt.s.w $f0,$f6
#conversion done
s.s $f0,K_0($fp)
l452:
l.s $f0,K_0($fp)
#converting to float
li $t0,10
mtc1 $t0,$f6
cvt.s.w $f2,$f6
#conversion done
c.lt.s $f0, $f2
cfc1 $t0,$25
andi $t0,1
mtc1 $t0,$f6
cvt.s.w $f0,$f6
s.s $f0,t449_0($fp)
l.s $f2,t449_0($fp)
li.s $f4, 0.0
c.eq.s $f2, $f4
bc1t l453
l.s $f0,SUM_0($fp)
#converting to float
li $t0,1
mtc1 $t0,$f6
cvt.s.w $f2,$f6
#conversion done
add.s $f0,$f0,$f2
s.s $f0,t451_0($fp)
l.s $f0,t451_0($fp)
s.s $f0,SUM_0($fp)
l.s $f0,K_0($fp)
#converting to float
li $t0,1
mtc1 $t0,$f6
cvt.s.w $f2,$f6
#conversion done
add.s $f0,$f0,$f2
s.s $f0,t450_0($fp)
l.s $f0,t450_0($fp)
s.s $f0,K_0($fp)
j l452
l453:
l.s $f0,J_0($fp)
#converting to float
li $t0,1
mtc1 $t0,$f6
cvt.s.w $f2,$f6
#conversion done
add.s $f0,$f0,$f2
s.s $f0,t448_0($fp)
l.s $f0,t448_0($fp)
s.s $f0,J_0($fp)
j l454
l455:
l.s $f0,I_0($fp)
#converting to float
li $t0,1
mtc1 $t0,$f6
cvt.s.w $f2,$f6
#conversion done
add.s $f0,$f0,$f2
s.s $f0,t446_0($fp)
l.s $f0,t446_0($fp)
s.s $f0,I_0($fp)
j l456
l457:
#print out SUM_0
li $v0, 2
l.s $f12,SUM_0($fp)
syscall
li $v0, 4
la $a0, newline
syscall
#converting to float
li $t0,0
mtc1 $t0,$f6
cvt.s.w $f0,$f6
#conversion done
s.s $f0,SUM_0($fp)
#converting to float
li $t0,0
mtc1 $t0,$f6
cvt.s.w $f0,$f6
#conversion done
s.s $f0,I_0($fp)
l469:
l.s $f0,I_0($fp)
#converting to float
li $t0,10
mtc1 $t0,$f6
cvt.s.w $f2,$f6
#conversion done
c.lt.s $f0, $f2
cfc1 $t0,$25
andi $t0,1
mtc1 $t0,$f6
cvt.s.w $f0,$f6
s.s $f0,t458_0($fp)
l.s $f2,t458_0($fp)
li.s $f4, 0.0
c.eq.s $f2, $f4
bc1t l470
#converting to float
li $t0,0
mtc1 $t0,$f6
cvt.s.w $f0,$f6
#conversion done
s.s $f0,J_0($fp)
l466:
l.s $f0,J_0($fp)
#converting to float
li $t0,10
mtc1 $t0,$f6
cvt.s.w $f2,$f6
#conversion done
c.lt.s $f0, $f2
cfc1 $t0,$25
andi $t0,1
mtc1 $t0,$f6
cvt.s.w $f0,$f6
s.s $f0,t459_0($fp)
l.s $f2,t459_0($fp)
li.s $f4, 0.0
c.eq.s $f2, $f4
bc1t l467
#converting to float
li $t0,0
mtc1 $t0,$f6
cvt.s.w $f0,$f6
#conversion done
s.s $f0,K_0($fp)
l463:
l.s $f0,K_0($fp)
#converting to float
li $t0,10
mtc1 $t0,$f6
cvt.s.w $f2,$f6
#conversion done
c.lt.s $f0, $f2
cfc1 $t0,$25
andi $t0,1
mtc1 $t0,$f6
cvt.s.w $f0,$f6
s.s $f0,t460_0($fp)
l.s $f2,t460_0($fp)
li.s $f4, 0.0
c.eq.s $f2, $f4
bc1t l464
l.s $f0,SUM_0($fp)
#converting to float
li $t0,1
mtc1 $t0,$f6
cvt.s.w $f2,$f6
#conversion done
add.s $f0,$f0,$f2
s.s $f0,t461_0($fp)
l.s $f0,t461_0($fp)
s.s $f0,SUM_0($fp)
l.s $f0,K_0($fp)
#converting to float
li $t0,1
mtc1 $t0,$f6
cvt.s.w $f2,$f6
#conversion done
add.s $f0,$f0,$f2
s.s $f0,t462_0($fp)
l.s $f0,t462_0($fp)
s.s $f0,K_0($fp)
j l463
l464:
l.s $f0,J_0($fp)
#converting to float
li $t0,1
mtc1 $t0,$f6
cvt.s.w $f2,$f6
#conversion done
add.s $f0,$f0,$f2
s.s $f0,t465_0($fp)
l.s $f0,t465_0($fp)
s.s $f0,J_0($fp)
j l466
l467:
l.s $f0,I_0($fp)
#converting to float
li $t0,1
mtc1 $t0,$f6
cvt.s.w $f2,$f6
#conversion done
add.s $f0,$f0,$f2
s.s $f0,t468_0($fp)
l.s $f0,t468_0($fp)
s.s $f0,I_0($fp)
j l469
l470:
#print out SUM_0
li $v0, 2
l.s $f12,SUM_0($fp)
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

.data

#.block-0-variables
SUM_0: .word 16
I_0: .word 24
t448_0: .word 32
t449_0: .word 40
J_0: .word 48
t450_0: .word 56
t451_0: .word 64
K_0: .word 72
t452_0: .word 80
t453_0: .word 88
t454_0: .word 96
t461_0: .word 104
t462_0: .word 112
t463_0: .word 120
t464_0: .word 128
t465_0: .word 136
t468_0: .word 144
t471_0: .word 152
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
subu $sp, $sp, 144
#converting to float
li $t0,0
mtc1 $t0,$f6
cvt.s.w $f0,$f6
#conversion done
s.s $f0,SUM_0($fp)
#converting to float
li $t0,0
mtc1 $t0,$f6
cvt.s.w $f0,$f6
#conversion done
s.s $f0,I_0($fp)
l459:
l.s $f0,I_0($fp)
#converting to float
li $t0,10
mtc1 $t0,$f6
cvt.s.w $f2,$f6
#conversion done
c.lt.s $f0, $f2
cfc1 $t0,$25
andi $t0,1
mtc1 $t0,$f6
cvt.s.w $f0,$f6
s.s $f0,t448_0($fp)
l.s $f2,t448_0($fp)
li.s $f4, 0.0
c.eq.s $f2, $f4
bc1t l460
#converting to float
li $t0,0
mtc1 $t0,$f6
cvt.s.w $f0,$f6
#conversion done
s.s $f0,J_0($fp)
l457:
l.s $f0,J_0($fp)
#converting to float
li $t0,10
mtc1 $t0,$f6
cvt.s.w $f2,$f6
#conversion done
c.lt.s $f0, $f2
cfc1 $t0,$25
andi $t0,1
mtc1 $t0,$f6
cvt.s.w $f0,$f6
s.s $f0,t450_0($fp)
l.s $f2,t450_0($fp)
li.s $f4, 0.0
c.eq.s $f2, $f4
bc1t l458
#converting to float
li $t0,0
mtc1 $t0,$f6
cvt.s.w $f0,$f6
#conversion done
s.s $f0,K_0($fp)
l455:
l.s $f0,K_0($fp)
#converting to float
li $t0,10
mtc1 $t0,$f6
cvt.s.w $f2,$f6
#conversion done
c.lt.s $f0, $f2
cfc1 $t0,$25
andi $t0,1
mtc1 $t0,$f6
cvt.s.w $f0,$f6
s.s $f0,t452_0($fp)
l.s $f2,t452_0($fp)
li.s $f4, 0.0
c.eq.s $f2, $f4
bc1t l456
l.s $f0,SUM_0($fp)
#converting to float
li $t0,1
mtc1 $t0,$f6
cvt.s.w $f2,$f6
#conversion done
add.s $f0,$f0,$f2
s.s $f0,t454_0($fp)
l.s $f0,t454_0($fp)
s.s $f0,SUM_0($fp)
l.s $f0,K_0($fp)
#converting to float
li $t0,1
mtc1 $t0,$f6
cvt.s.w $f2,$f6
#conversion done
add.s $f0,$f0,$f2
s.s $f0,t453_0($fp)
l.s $f0,t453_0($fp)
s.s $f0,K_0($fp)
j l455
l456:
l.s $f0,J_0($fp)
#converting to float
li $t0,1
mtc1 $t0,$f6
cvt.s.w $f2,$f6
#conversion done
add.s $f0,$f0,$f2
s.s $f0,t451_0($fp)
l.s $f0,t451_0($fp)
s.s $f0,J_0($fp)
j l457
l458:
l.s $f0,I_0($fp)
#converting to float
li $t0,1
mtc1 $t0,$f6
cvt.s.w $f2,$f6
#conversion done
add.s $f0,$f0,$f2
s.s $f0,t449_0($fp)
l.s $f0,t449_0($fp)
s.s $f0,I_0($fp)
j l459
l460:
#print out SUM_0
li $v0, 2
l.s $f12,SUM_0($fp)
syscall
li $v0, 4
la $a0, newline
syscall
#converting to float
li $t0,0
mtc1 $t0,$f6
cvt.s.w $f0,$f6
#conversion done
s.s $f0,SUM_0($fp)
#converting to float
li $t0,0
mtc1 $t0,$f6
cvt.s.w $f0,$f6
#conversion done
s.s $f0,I_0($fp)
l472:
l.s $f0,I_0($fp)
#converting to float
li $t0,10
mtc1 $t0,$f6
cvt.s.w $f2,$f6
#conversion done
c.lt.s $f0, $f2
cfc1 $t0,$25
andi $t0,1
mtc1 $t0,$f6
cvt.s.w $f0,$f6
s.s $f0,t461_0($fp)
l.s $f2,t461_0($fp)
li.s $f4, 0.0
c.eq.s $f2, $f4
bc1t l473
#converting to float
li $t0,0
mtc1 $t0,$f6
cvt.s.w $f0,$f6
#conversion done
s.s $f0,J_0($fp)
l469:
l.s $f0,J_0($fp)
#converting to float
li $t0,10
mtc1 $t0,$f6
cvt.s.w $f2,$f6
#conversion done
c.lt.s $f0, $f2
cfc1 $t0,$25
andi $t0,1
mtc1 $t0,$f6
cvt.s.w $f0,$f6
s.s $f0,t462_0($fp)
l.s $f2,t462_0($fp)
li.s $f4, 0.0
c.eq.s $f2, $f4
bc1t l470
#converting to float
li $t0,0
mtc1 $t0,$f6
cvt.s.w $f0,$f6
#conversion done
s.s $f0,K_0($fp)
l466:
l.s $f0,K_0($fp)
#converting to float
li $t0,10
mtc1 $t0,$f6
cvt.s.w $f2,$f6
#conversion done
c.lt.s $f0, $f2
cfc1 $t0,$25
andi $t0,1
mtc1 $t0,$f6
cvt.s.w $f0,$f6
s.s $f0,t463_0($fp)
l.s $f2,t463_0($fp)
li.s $f4, 0.0
c.eq.s $f2, $f4
bc1t l467
l.s $f0,SUM_0($fp)
#converting to float
li $t0,1
mtc1 $t0,$f6
cvt.s.w $f2,$f6
#conversion done
add.s $f0,$f0,$f2
s.s $f0,t464_0($fp)
l.s $f0,t464_0($fp)
s.s $f0,SUM_0($fp)
l.s $f0,K_0($fp)
#converting to float
li $t0,1
mtc1 $t0,$f6
cvt.s.w $f2,$f6
#conversion done
add.s $f0,$f0,$f2
s.s $f0,t465_0($fp)
l.s $f0,t465_0($fp)
s.s $f0,K_0($fp)
j l466
l467:
l.s $f0,J_0($fp)
#converting to float
li $t0,1
mtc1 $t0,$f6
cvt.s.w $f2,$f6
#conversion done
add.s $f0,$f0,$f2
s.s $f0,t468_0($fp)
l.s $f0,t468_0($fp)
s.s $f0,J_0($fp)
j l469
l470:
l.s $f0,I_0($fp)
#converting to float
li $t0,1
mtc1 $t0,$f6
cvt.s.w $f2,$f6
#conversion done
add.s $f0,$f0,$f2
s.s $f0,t471_0($fp)
l.s $f0,t471_0($fp)
s.s $f0,I_0($fp)
j l472
l473:
#print out SUM_0
li $v0, 2
l.s $f12,SUM_0($fp)
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