;;;; this example compiles arithmetic expressions and their assignment to 
;;;; Three address code (TAC) then to register-only ops the  to MIPS target code
;;;; -cem bozsahin

;; I added a sequencing rule make assignments one after another.

;; Examples in tac and zac directories generate IC code with IC temporaries.

;; This version generates TAC with IC temporaries, then creates MIPS-style .data and .text segments
;; which refer to these temporaries, and implements the TAC as register operations.
;; This is because in MIPS all ops are done in registers; no op refers to memory locations.
;; For example (3ac mult a b c) meaning a := b * c in IC code is translated into
;;  l.s $f0,b
;;  l.s $f2,c
;;  mul.s $f0,$f0,$f2
;;  s.s $f0,a

;; NOTE:
;; We do not use conversion commands like cvt.s.w because we map all source integers to float 
;; at the IC level.
;; 
;; Because MIPS does not allows mixed arithmetic, we map integer constants to integer registers and make them float
;;
;; where l.s is load word from memory to register
;; and s.s means save the register's value in a word in memory.
;; $fi are temporary floating-point value registers of MIPS-like architectures. All we need is 2 for TAC codes.
;; We can think of this version as a register-based TAC, rather than true target code.

;; Here is the algorithm: 1) Generate TAC with relative addresses with IC temporaries. 2) Map that result to a 
;;  register-based TAC with data and code segments. 

;; A Symbol table keeps names (variables and constants) and type info. Its format is
;; hash key: (name blockno)  hash value: (type value)
;;   type is NUM or VAR.  Value is relevant for numbers to choose 'li' MIPS command later. Each type takes a fixed amount of 
;;   space (in MIPS generation i assume one word).

(defun mk-symtab (size)
  (make-hash-table :test #'equal :size size :rehash-threshold 0.8))  ; we need equal function to match a LIST of values as key

(defparameter *symtab* (mk-symtab 200)) ; this is a global variable, referred to in the grammar's semantic actions

(defparameter *blockno* 0)  ;; increment this everytime a new code block (procedure etc.) is entered.

(defparameter *saved-blockno* 0)  ;; increment this everytime a new code block (procedure etc.) is entered. 


(defparameter *outstream* nil) ;; to control output to file or standard output

(defun target-code-mips (input &optional (outp nil))
  "if outp is t, will send it to std out"
  (clrhash *symtab*) ; we need to reset the symbol table for every code gen
  (setf *blockno* 0)
  (if (or (listp input) (not outp))
    (setf *outstream* nil)
    (setf *outstream* (concatenate 'string "target_" input ".s")))
  (format t "~%Lexical analyzer feed to parser as seen by Lisp reader:~2%~A" 
	  (with-open-file (s input :direction :input :if-does-not-exist :error)(read s)))
  (target-code input))

(defun mk-sym-entry (name)
  "NB: Lisp hash is collision-free, duplicates just replace the older value."
  (cond ((floatp name) (setf (gethash (list name *blockno*) *symtab*) (list 'float name)))
	((integerp name) (setf (gethash (list name *blockno*) *symtab*) (list 'int name)))
	((symbolp name) (setf (gethash (list name *blockno*) *symtab*) (list 'var name)))
	(t (setf (gethash (list name *blockno*) *symtab*) (list 'unknown name)))))

(defun sym-get-type (val)
  (first val))

(defun sym-get-value (val)
  (second val))

;; SDD section
;;
;; advice: never use a constant on the RHS of rules, put them in the lexicon and 
;;         symbolize them in lexforms

;;; TAC Templates:
;;  (3ac op p1 p2 p3)
;;  (2ac op p1 p2)
;;  (2copy p1 p1)

(defparameter *tac-to-mips* '((MULT "mul.s") 
                              (DIV "div.s")
                              (ADD "add.s")
                              (SUB "sub.s")
                              (UMINUS "sub.s")
                              (GREATER "c.lt.s")
                              (LESSER "c.lt.s")
                              (GREATEREQ "c.lt.s")
                              (LESSEREQ "c.le.s")
                              (EQEQ "c.eq.s")
                              (NOTEQ "c.eq.s")
                              (AND "and")
                              (IF "if")
                              (LABEL "label")
                              (JUMP "j")
                              (NOP "nop")
                              (PRINT "print")
                              (CALL "jal")
                              (GETRETURN "getreturn")
                              (PRESERVE "preserve")
                              (GETPARAM "getparam")
                              (END "end")
                              (RETURN  "return")
                              (LOAD "load")
                              (OUTPUT "output"))) ; intstruction set corr.

 ;; MIPS is case-sensitive, so we use strings to map TAC code to MIPS
 ;; it also needs to know whether we use floating point or integer op (.s means float)

;; two functions to get type and value of tokens

;; in LALR parser, every token is a list whose first element is its type and second element its value.

;;; NOTE: the reason why i did not write any of these as macros is so that you can trace them if you feel like it

(defun t-get-type (x)
  "token type"
  (first x))

(defun t-get-val (x)
  "token value"
  (second x))

(defun wrap (x)
  "to wrap code in parentheses"
  (list x))

(defun pprint-code (code)
  (dolist (instruction (second code))
    (pprint instruction))
  t)

(defun mk-imm (register p)
  "MIPS does not allow mix arithmetic"
  (if (integerp p)
    (progn
      (format t "~%#converting to float")
      (format t "~%li $t0,~A" p)
      (format t "~%mtc1 $t0,$f6") ; using $f6 is temp value converter
      (format t "~%cvt.s.w ~A,$f6" register); MIPS internal conversion to float
      (format t "~%#conversion done"))
    (format t "~%li.s ~A,~A" register p)))  ; if your MIPS assembler has load immediate float command

(defun mk-mips (p register)
  "create li if constant or l.s if not"
  (if (numberp p)
    (mk-imm register p)  
    (format t "~%l.s ~A,~A" register p)))

(defun tac-get-mips (op)
  (second (assoc op *tac-to-mips*)))

(defun mk-mips-3ac (i)
  (let ((op (tac-get-mips (first i)))
	(p1 (second i))
	(p2 (third i))
	(p3 (fourth i)))
    (mk-mips p2 "$f0")
    (mk-mips p3 "$f2")
    (format t "~%~A $f0,$f0,$f2" op)
    (format t "~%s.s $f0,~A" p1)))
    


(defun mk-mips-3ac-condi (i)
  (let ((op (tac-get-mips (first i)))
  (op-var (first i))
	(p1 (second i))
	(p2 (third i))
	(p3 (fourth i)))
    (mk-mips p2 "$f0")
    (mk-mips p3 "$f2")
    (cond ((equal op-var 'GREATER) (format t "~%~A $f2, $f0" op))
          ((equal op-var 'LESSER) (format t "~%~A $f0, $f2" op))
          ((equal op-var 'GREATEREQ) (format t "~%~A $f2, $f0" op))
          ((equal op-var 'LESSEREQ) (format t "~%~A $f0, $f2" op))
          ((equal op-var 'EQEQ) (format t "~%~A $f0, $f2" op))
          ((equal op-var 'NOTEQ) 
            (format t "~%~A $f0, $f2" op)
            (format t "~%cfc1 $t0,$25")
            (format t "~%andi $t0,1")
            (format t "~%mtc1 $t0,$f6") 
            (format t "~%cvt.s.w $f0,$f6")
            (format t "~%li.s $f2,0.0")
            (format t "~%~A $f2, $f6" op)))
    (format t "~%cfc1 $t0,$25")
    (format t "~%andi $t0,1")
    (format t "~%mtc1 $t0,$f6") ; using $f6 is temp value converter
    (format t "~%cvt.s.w $f0,$f6"); MIPS internal conversion to float
    (format t "~%s.s $f0,~A" p1)))

(defun mk-mips-3ac-condx (i)
  (let ((op (tac-get-mips (first i)))
  (op-var (first i))
	(p1 (second i))
	(p2 (third i))
	(p3 (fourth i)))
    (mk-mips p2 "$f0")
    (mk-mips p3 "$f2")
    (format t "~%li.s $f4, 0.0")
    (format t "~%c.eq.s $f0, $f4")
    (format t "~%cfc1 $t0,$25")
    (format t "~%not $t0,$t0")
    (format t "~%andi $t0,1")
    (format t "~%c.eq.s $f2, $f4")
    (format t "~%cfc1 $t1,$25")
    (format t "~%not $t1,$t1")
    (format t "~%andi $t1,1")
    (cond ((equal op-var 'AND) 
            (format t "~%and $t2,$t0,$t1"))
          ((equal op-var 'OR) 
            (format t "~%or $t2,$t0,$t1")))
    (format t "~%mtc1 $t2,$f6") ; using $f6 is temp value converter
    (format t "~%cvt.s.w $f0,$f6"); MIPS internal conversion to float
    (format t "~%s.s $f0,~A" p1)))

(defun unary-not (op p1 p2)
  (mk-mips p2 "$f2")
  (format t "~%li.s $f4, 0.0")
  (format t "~%c.eq.s $f2, $f4")
  (format t "~%cfc1 $t0,$25")
  (format t "~%andi $t0,1")
  (format t "~%mtc1 $t0,$f6") 
  (format t "~%cvt.s.w $f0,$f6")
  (format t "~%s.s $f0,~A" p1))

(defun unary-sub (op p1 p2)
  (mk-mips p2 "$f2")
  (format t "~%#loading dummy zero float to $f0")
  (format t "~%l.s $f0,zzeerroo")
  (format t "~%~A $f0,$f0,$f2" op)
  (format t "~%s.s $f0,~A" p1))

(defun branch-not-true (op p1 p2)
  (mk-mips p1 "$f2")
  (format t "~%li.s $f4, 0.0")
  (format t "~%c.eq.s $f2, $f4")
  (format t "~%bc1t ~A" p2))

(defun mk-mips-2ac (i)
  (let ((op (tac-get-mips (first i)))
    (op-var (first i))
	  (p1 (second i))
	  (p2 (third i)))
    (cond ((equal op-var 'UMINUS)
            (unary-sub op p1 p2))
          ((equal op-var 'NOT)
            (unary-not op p1 p2))
          ((equal op-var 'IF)
            (branch-not-true op p1 p2))
          ((equal op-var 'GETRETURN)
            (format t "~%s.s $f0, ~A" p1)
            (format t "~%li $t0, 8")
            (format t "~%mul $t0, $t0, ~A" p2)
            (format t "~%addu $sp, $sp, $t0"))
          ((equal op-var 'GETPARAM)
            (format t "~%#Arg ~A" p1)
            (format t "~%li $t0, 8")
            (format t "~%mul $t0, $t0, ~A" p2)
            (format t "~%addu $t0, $t0, $fp")
            (format t "~%l.s $f2, ($t0)")
            (format t "~%s.s $f2, ~A" p1)))))

(defun mk-mips-1ac (i)
  (let ((op (tac-get-mips (first i)))
    (op-var (first i))
	  (p1 (second i)))
    (cond ((equal op-var 'LABEL)
            (format t "~%~A:" (string-downcase p1)))
          ((equal op-var 'JUMP)
            (format t "~%~A ~A" op (string-downcase p1)))
          ((equal op-var 'PRINT)
            (format t "~%li $v0, 2")
            (format t "~%l.s $f12, ~A" p1)
            (format t "~%syscall")
            (format t "~%li $v0, 4")  ;print newline
            (format t "~%la $a0, newline")
            (format t "~%syscall"))
          ((equal op-var 'PUSH)
            (format t "~%#push actual argument ~A" p1)
            (format t "~%subu $sp, $sp, 8")
            (mk-mips p1 "$f0")
            (format t "~%s.s $f0, ($sp)"))
          ((equal op-var 'CALL)
            (format t "~%~A ~A" op (string-downcase p1)))
          ((equal op-var 'END)
            (format t "~%.end ~A" (string-downcase p1)))
          ((equal op-var 'RETURN)
            (format t "~%l.s $f0, ~A" p1))
          ((equal op-var 'OUTPUT)
            (format t "~%#print out ~A" p1)
            (format t "~%li $v0, 2")
            (format t "~%l.s $f12, ~A" p1)
            (format t "~%syscall")
            (format t "~%li $v0, 4")  ;print newline
            (format t "~%la $a0, newline")
            (format t "~%syscall")))))

(defun mk-mips-0ac (i)
  (let ((op (tac-get-mips (first i)))
        (op-var (first i)))
    (cond ((equal op-var 'NOP)
            (format t "~%~A" op))
          ((equal op-var 'PRESERVE)
            (format t "~%#push saved registers")
            (format t "~%subu $sp, $sp, 8")
            (format t "~%sw $ra, ($sp)")
            (format t "~%subu $sp, $sp, 8")
            (format t "~%sw $fp, ($sp)")
            (format t "~%addu $fp, $sp, 8"))
          ((equal op-var 'LOAD)
            (format t "~%#load saved registers")
            (format t "~%lw $ra, ($fp)")
            (format t "~%lw $fp, -8($fp)")
            (format t "~%addu $sp, $sp, 16")
            (format t "~%jr $ra")))))
  

(defun mk-mips-2copy (i)
  (let ((p1 (first i))
	(p2 (second i)))
    (mk-mips p2 "$f0")
    (format t "~%s.s $f0,~A" p1)))

(defun get-locals-main ()
  (maphash #'(lambda (key val)
                (cond 
                  ((and (equal (second key) 0) (equal (sym-get-type val) 'VAR))
                    (format t "~%~A_~A: .float 0.0" (sym-get-value val) (second key))))) *symtab*))

(defun get-locals-functions (n)
(let ((counter 16))
  (loop for key being the hash-keys of *symtab*
   do (cond 
      ((and (equal (second key) n) (equal (sym-get-type (gethash key  *symtab*)) 'VAR))
        (format t "~%~A_~A: .word ~A" (sym-get-value (gethash key  *symtab*)) (second key) counter)
        (setf counter (+ counter 8)))))))        
    
    

(defun create-data-segment ()
  "only for variables; numbers will use immmediate loading rather than lw or l.s."
  (format t "~2%.data~%")
  ;(maphash #'(lambda (key val)
	;       (if (equal (sym-get-type val) 'VAR) (format t "~%~A_~A: .float 0.0" (sym-get-value val) (second key))))
	;   *symtab*)

  (format t "~%#main-variables")
  (get-locals-main)
  
  (loop for x from 1 to (identity *saved-blockno*)
   do (format t "~%#.block-~A-variables" x)
      (get-locals-functions x)
   )

  (format t "~%#helper-variables")
  (format t "~%zzeerroo: .float 0.0") ; MIPS has no float point zero constant like $zero for ints. bad bad
  (format t "~%newline: .asciiz \"\\n\""))


(defun create-code-segment (code)
  (let ((is-main t)
      (main-instuctions (mk-1ac 'label "main")))
    (format t "~2%.text~2%")
    (dolist (instruction (second code)) ; NB. code is a grammar variable feature (code (i1 i2 i3))
      (let ((itype (first instruction)))
        (cond ((equal itype 'begin)
                (setq is-main nil))
              ((equal itype 'end)
                (format t "~2%")
                (setq is-main t))
              (t (if  (not is-main)
                        (cond  ((equal itype '3AC) (mk-mips-3ac (rest instruction)))
                          ((equal itype '2AC) (mk-mips-2ac (rest instruction)))
                          ((equal itype '1AC) (mk-mips-1ac (rest instruction)))
                          ((equal itype '0AC) (mk-mips-0ac (rest instruction)))
                          ((equal itype '2COPY) (mk-mips-2copy (rest instruction)))
                          ((equal itype '3AC-CONDI) (mk-mips-3ac-condi (rest instruction)))
                          ((equal itype '3AC-CONDX) (mk-mips-3ac-condx (rest instruction)))
                          (t (format t "unknown TAC code: ~A" instruction)))
                      (push  instruction  (cdr (last main-instuctions))))))))
    
    (dolist (instruction main-instuctions)
      (let ((itype (first instruction)))
        (cond  ((equal itype '3AC) (mk-mips-3ac (rest instruction)))
                        ((equal itype '2AC) (mk-mips-2ac (rest instruction)))
                        ((equal itype '1AC) (mk-mips-1ac (rest instruction)))
                        ((equal itype '0AC) (mk-mips-0ac (rest instruction)))
                        ((equal itype '2COPY) (mk-mips-2copy (rest instruction)))
                        ((equal itype '3AC-CONDI) (mk-mips-3ac-condi (rest instruction)))
                        ((equal itype '3AC-CONDX) (mk-mips-3ac-condx (rest instruction)))
                        (t (format t "unknown TAC code: ~A" instruction)))))
    (format t "~%#MIPs termination protocol:")
    (format t "~%li $v0,10") ; MIPs termination protocol
    (format t "~%syscall")
    (format t "~%.end main")))

(defun map-to-mips (code)
  (if (stringp *outstream*) (dribble *outstream*))  ; open out
  (create-data-segment) ; uses the symbol table
  (create-code-segment code)
  (if (stringp *outstream*) (dribble))) ; must close dribble

(defun tac-to-rac (code)
  (format t "~2%Symbol table at IC level:~2%key         value~%(name blockno)  (type value)~%--------------------")
  (maphash #'(lambda (key val)(format t "~%~A : ~A" key val)) *symtab*)
  (format t  "~2%TAC IC code:~%")
  (pprint-code code)
  (format t "~2%QtSpim target code:")
  (map-to-mips code))


;; some aux functions  to retrieve amd make feature values for grammar variables

(defun mk-begin (op)
  (wrap (list 'begin op)))

(defun mk-end (op)
  (wrap (list 'end op)))

(defun mk-place (v)
  (list 'place v))

(defun mk-code (v)
  (list 'code v))

(defun var-get-place (v)
  (second (assoc 'place v)))

(defun var-get-code (v)
  (second (assoc 'code v)))

(defun mk-0ac (op)
  (wrap (list '0ac op)))

(defun mk-1ac (op p1)
  (wrap (list '1ac op p1)))

(defun mk-2ac (op p1 p2)
  (wrap (list '2ac op p1 p2)))

(defun mk-3ac-condi (op p1 p2 p3)
  (wrap (list '3ac-condi op p1 p2 p3)))

(defun mk-3ac-condx (op p1 p2 p3)
  (wrap (list '3ac-condx op p1 p2 p3)))

(defun mk-3ac (op p1 p2 p3)
  (wrap (list '3ac op p1 p2 p3)))

(defun mk-2copy (p1 p2)
  (wrap (list '2copy p1 p2)))

(defun newtemp ()
  (gensym "t"))       ; returns a new symbol prefixed t at Lisp run-time

(defun newlabel ()
  (gensym "l"))       ; returns a new symbol prefixed l at Lisp run-time

(defun blocked-symbol (x)
  (if (numberp x)
    x
    (intern 
      (concatenate 'string 
        (string x) 
        (concatenate 'string "_" (write-to-string *blockno*))))))

(defun increment-block()
  (setf *blockno* (+ *blockno* 1)))

(defun reload-block()
  (setf *blockno* *saved-blockno*))

(defun turn-main-block ()
  (progn
    (setf *saved-blockno* *blockno*)
    (setf *blockno* 0)))


;;;; LALR data 

(defparameter grammar
'(
  (start                --> statement entries                                   #'(lambda (statement entries) 
					                                                                      (tac-to-rac 
                                                                                  (mk-code 
                                                                                    (append
                                                                                      (var-get-code statement)
                                                                                      (var-get-code entries))))))

  (start                --> statement                                           #'(lambda (statement) 
					                                                                      (tac-to-rac 
                                                                                  (mk-code 
                                                                                    (append
                                                                                      (var-get-code statement))))))                                                                                     

  (entries              --> entries entry                                       #'(lambda (entries entry)
                                                                                (list
                                                                                  (mk-place nil)
                                                                                  (mk-code (append
                                                                                    (var-get-code entries)
                                                                                    (var-get-code entry))))))   

  (entries              --> entry                                               #'(lambda (e)(identity e)))  


  (entry                --> statement                                           #'(lambda (e)(identity e)))

  (entry                --> function_def                                        #'(lambda (e)(identity e)))                                                                                            

  (stmts                --> stmts statement                                     #'(lambda (stmts s) 
                                                                                (list 
                                                                                  (mk-place nil)
                                                                                  (mk-code (append 
                                                                                    (var-get-code stmts)
                                                                                    (var-get-code s))))))
                                                                                
  (stmts                --> statement                                           #'(lambda (statement)
                                                                                (list 
                                                                                  (mk-place nil)
                                                                                  (mk-code (var-get-code statement)))))

  (factor               --> LP expr RP                                          #'(lambda (LP expr RP) (identity expr)))

  (factor               --> ID                                                  #'(lambda (ID) 
                                                                                (progn 
                                                                                  (mk-sym-entry (t-get-val ID))
                                                                                  (list 
                                                                                    (mk-place (blocked-symbol (t-get-val ID)))
                                                                                    (mk-code nil)))))

  (factor        -->  ID LP plist_call RP                                       #'(lambda (ID LP plist_call RP) 
                                                                                (let
                                                                                  ((newplace (newtemp)))
                                                                                  (mk-sym-entry newplace)
                                                                                  (list
                                                                                    (mk-code
                                                                                      (append
                                                                                        (var-get-code plist_call)
                                                                                        (mk-1ac 'call (t-get-val ID))
                                                                                        (mk-2ac 'getreturn (blocked-symbol newplace) (var-get-place plist_call))
                                                                                      )
                                                                                    )
                                                                                    (mk-place (blocked-symbol newplace))      
                                                                                  )
                                                                                )))

                                                                                

  (plist_call           --> plist_call COMMA assign_expr                        #'(lambda (plist_call COMMA assign_expr)
                                                                                (progn
                                                                                  (list
                                                                                    (mk-code 
                                                                                      (append 
                                                                                        (var-get-code assign_expr)
                                                                                        (mk-1ac 'push (var-get-place assign_expr))
                                                                                        (var-get-code plist_call)
                                                                                      )
                                                                                    )
                                                                                    (mk-place (+ (var-get-place plist_call) 1 ))
                                                                                  )
                                                                                )))

  (plist_call           -->  assign_expr                                       #'(lambda (assign_expr )
                                                                                (progn
                                                                                  (list
                                                                                    (mk-code 
                                                                                      (append 
                                                                                        (var-get-code assign_expr)
                                                                                        (mk-1ac 'push (var-get-place assign_expr))
                                                                                      )
                                                                                    )
                                                                                    (mk-place 1)
                                                                                  )
                                                                                )))         

  (plist_call           -->                                                     #'(lambda ()(progn (list (mk-code nil) (mk-place 0))))) ;epsilon                                                                                    


  
  (function_def         --> FUN ID LP plist_def RP stmts ENDF END                #'(lambda (FUN ID LP plist_def RP  stmts ENDF END)  ;;function ve variable lar ayni adda ise ne yapilmali?
                                                                                (progn
                                                                                  (turn-main-block)
                                                                                  (list
                                                                                    (mk-code
                                                                                      (append
                                                                                        (mk-begin (t-get-val ID))
                                                                                        (mk-1ac 'label (t-get-val ID))
                                                                                        (mk-0ac 'preserve)
                                                                                        (var-get-code plist_def)
                                                                                        (var-get-code stmts)
                                                                                        (mk-0ac 'load)
                                                                                        (mk-1ac 'end (t-get-val ID))
                                                                                        (mk-end (t-get-val ID))))
                                                                                    (mk-place nil)))))

  (plist_def            --> plist_def COMMA ID                                  #'(lambda (plist_def COMMA ID)
                                                                                (progn
                                                                                  (mk-sym-entry (t-get-val ID))
                                                                                  ;(format t "~%Created2 ~A" (t-get-val ID))
                                                                                  (list
                                                                                    (mk-code
                                                                                      (append
                                                                                        (var-get-code plist_def)
                                                                                        (mk-2ac 'getparam (blocked-symbol(t-get-val ID)) (var-get-place plist_def))
                                                                                      )
                                                                                    )
                                                                                    (mk-place (+ (var-get-place plist_def) 1 ))
                                                                                  ))))

  (plist_def            --> ID                                                  #'(lambda (ID)
                                                                                (progn
                                                                                  ;(format t "~%Created1 ~A" (t-get-val ID))    
                                                                                  (reload-block)                                                                                                                                                                  
                                                                                  (increment-block)
                                                                                  (mk-sym-entry (t-get-val ID))
                                                                                  (list
                                                                                    (mk-code 
                                                                                      (append
                                                                                        (mk-2ac 'getparam (blocked-symbol(t-get-val ID)) 1)))
                                                                                    (mk-place 2)))))

  (plist_def            -->                                                     #'(lambda ()
                                                                                  (progn
                                                                                    (reload-block)                                                                                                                                                                  
                                                                                    (increment-block)
                                                                                    (list
                                                                                      (mk-code nil)
                                                                                      (mk-place nil)))))                                                                                                                                                              

  (unary_expr           --> SUB unary_expr                                      #'(lambda (SUB unary_expr) 
                                                                                (let 
                                                                                  ((newplace (newtemp)))
                                                                                  (mk-sym-entry newplace)
                                                                                  (list 
                                                                                    (mk-place (blocked-symbol newplace))
                                                                                    (mk-code 
                                                                                      (mk-2ac 'uminus (blocked-symbol newplace)
                                                                                        (var-get-place unary_expr)))))))

  (unary_expr           --> NOT unary_expr                                      #'(lambda (NOT unary_expr) 
                                                                                (let 
                                                                                  ((newplace (newtemp)))
                                                                                  (mk-sym-entry newplace)
                                                                                  (list 
                                                                                    (mk-place (blocked-symbol newplace))
                                                                                    (mk-code 
                                                                                      (mk-2ac 'not (blocked-symbol newplace)
                                                                                        (var-get-place unary_expr)))))))                                                                                     

  (unary_expr           --> factor                                              #'(lambda (e)(identity e)))

  (mult_expr            --> mult_expr MULT unary_expr                           #'(lambda (mult_expr MULT unary_expr) 
                                                                                (let ((newplace (newtemp)))
                                                                                  (mk-sym-entry newplace)
                                                                                  (list 
                                                                                    (mk-place (blocked-symbol newplace))
                                                                                    (mk-code 
                                                                                      (append 
                                                                                        (var-get-code mult_expr)
                                                                                        (var-get-code unary_expr)
                                                                                        (mk-3ac 'mult (blocked-symbol newplace)
                                                                                          (var-get-place mult_expr)
                                                                                          (var-get-place unary_expr))))))))

  (mult_expr            --> mult_expr DIV unary_expr                            #'(lambda (mult_expr DIV unary_expr) 
                                                                                (let ((newplace (newtemp)))
                                                                                  (mk-sym-entry newplace)
                                                                                  (list 
                                                                                    (mk-place (blocked-symbol newplace))
                                                                                    (mk-code 
                                                                                      (append 
                                                                                        (var-get-code mult_expr)
                                                                                        (var-get-code unary_expr)
                                                                                        (mk-3ac 'div (blocked-symbol newplace)
                                                                                          (var-get-place mult_expr)
                                                                                          (var-get-place unary_expr))))))))

  (mult_expr            --> unary_expr                                          #'(lambda (e)(identity e)))

  (add_expr             --> add_expr ADD mult_expr                              #'(lambda (add_expr ADD mult_expr) 
                                                                                (let ((newplace (newtemp)))
                                                                                  (mk-sym-entry newplace)
                                                                                  (list 
                                                                                    (mk-place (blocked-symbol newplace))
                                                                                    (mk-code 
                                                                                      (append 
                                                                                        (var-get-code add_expr)
                                                                                        (var-get-code mult_expr)
                                                                                        (mk-3ac 'add (blocked-symbol newplace)
                                                                                          (var-get-place add_expr)
                                                                                          (var-get-place mult_expr))))))))

  (add_expr             --> add_expr SUB mult_expr                              #'(lambda (add_expr SUB mult_expr) 
                                                                                (let ((newplace (newtemp)))
                                                                                  (mk-sym-entry newplace)
                                                                                  (list 
                                                                                    (mk-place (blocked-symbol newplace))
                                                                                    (mk-code 
                                                                                    (append 
                                                                                      (var-get-code add_expr)
                                                                                      (var-get-code mult_expr)
                                                                                      (mk-3ac 'sub (blocked-symbol newplace)
                                                                                        (var-get-place add_expr)
                                                                                        (var-get-place mult_expr))))))))
  (add_expr             --> mult_expr                                           #'(lambda (e) (identity e)))

  (rel_expr             -->  rel_expr GRT add_expr                              #'(lambda (e1 GRT e2) 
                                                                                (let ((newplace (newtemp)))
                                                                                  (mk-sym-entry newplace)
                                                                                  (list 
                                                                                    (mk-place (blocked-symbol newplace))
                                                                                    (mk-code 
                                                                                      (append 
                                                                                        (var-get-code e1)
                                                                                        (var-get-code e2)
                                                                                        (mk-3ac-condi 'greater (blocked-symbol newplace) 
                                                                                          (var-get-place e1)
                                                                                          (var-get-place e2))))))))

  (rel_expr             -->  rel_expr LST add_expr                              #'(lambda (e1 LST e2) 
                                                                                (let ((newplace (newtemp)))
                                                                                  (mk-sym-entry newplace)
                                                                                  (list 
                                                                                    (mk-place (blocked-symbol newplace))
                                                                                    (mk-code 
                                                                                      (append 
                                                                                        (var-get-code e1)
                                                                                      (var-get-code e2)
                                                                                      (mk-3ac-condi 'lesser (blocked-symbol newplace) 
                                                                                        (var-get-place e1)
                                                                                        (var-get-place e2))))))))
                                                                                        
  (rel_expr             -->  rel_expr GRT EQLS add_expr                         #'(lambda (e1 GRT EQLS e2) 
                                                                                (let ((newplace (newtemp)))
                                                                                  (mk-sym-entry newplace)
                                                                                  (list 
                                                                                    (mk-place (blocked-symbol newplace))
                                                                                    (mk-code 
                                                                                      (append 
                                                                                        (var-get-code e1)
                                                                                        (var-get-code e2)
                                                                                        (mk-3ac-condi 'greatereq (blocked-symbol newplace) 
                                                                                          (var-get-place e1)
                                                                                          (var-get-place e2))))))))

  (rel_expr             -->  rel_expr LST EQLS add_expr                         #'(lambda (e1 LST EQLS e2) 
                                                                                (let ((newplace (newtemp)))
                                                                                  (mk-sym-entry newplace)
                                                                                  (list 
                                                                                    (mk-place (blocked-symbol newplace))
                                                                                    (mk-code 
                                                                                      (append 
                                                                                        (var-get-code e1)
                                                                                        (var-get-code e2)
                                                                                        (mk-3ac-condi 'lessereq (blocked-symbol newplace) 
                                                                                          (var-get-place e1)
                                                                                          (var-get-place e2))))))))

  (rel_expr             --> add_expr                                            #'(lambda (e) (identity e)))

  (eq_expr              -->  eq_expr EQLS EQLS rel_expr                         #'(lambda (e1 EQLS1 EQLS2 e2) 
                                                                                (let ((newplace (newtemp)))
                                                                                  (mk-sym-entry newplace)
                                                                                  (list 
                                                                                    (mk-place (blocked-symbol newplace))
                                                                                    (mk-code 
                                                                                      (append 
                                                                                        (var-get-code e1)
                                                                                      (var-get-code e2)
                                                                                      (mk-3ac-condi 'eqeq (blocked-symbol newplace) 
                                                                                        (var-get-place e1)
                                                                                        (var-get-place e2))))))))

  (eq_expr              -->  eq_expr NOT EQLS rel_expr                         #'(lambda (e1 NOT EQLS2 e2) 
                                                                                (let ((newplace (newtemp)))
                                                                                  (mk-sym-entry newplace)
                                                                                  (list 
                                                                                    (mk-place (blocked-symbol newplace))
                                                                                    (mk-code 
                                                                                      (append 
                                                                                        (var-get-code e1)
                                                                                        (var-get-code e2)
                                                                                        (mk-3ac-condi 'noteq (blocked-symbol newplace) 
                                                                                          (var-get-place e1)
                                                                                          (var-get-place e2)))))))) 

  (eq_expr              --> rel_expr                                            #'(lambda (e) (identity e)))

  (and_expr             -->  and_expr AND eq_expr                               #'(lambda (e1 AND e2) 
                                                                                (let ((newplace (newtemp)))
                                                                                  (mk-sym-entry newplace)
                                                                                  (list 
                                                                                    (mk-place (blocked-symbol newplace))
                                                                                    (mk-code 
                                                                                      (append 
                                                                                        (var-get-code e1)
                                                                                        (var-get-code e2)
                                                                                        (mk-3ac-condx 'and (blocked-symbol newplace) 
                                                                                          (var-get-place e1)
                                                                                          (var-get-place e2))))))))
                                                                                          
  (and_expr             --> eq_expr                                             #'(lambda (e) (identity e)))

  (or_expr              -->  or_expr OR and_expr                                #'(lambda (e1 OR e2) 
                                                                                (let ((newplace (newtemp)))
                                                                                  (mk-sym-entry newplace)
                                                                                  (list 
                                                                                    (mk-place (blocked-symbol newplace))
                                                                                    (mk-code 
                                                                                      (append 
                                                                                        (var-get-code e1)
                                                                                      (var-get-code e2)
                                                                                      (mk-3ac-condx 'or (blocked-symbol newplace) 
                                                                                        (var-get-place e1)
                                                                                        (var-get-place e2))))))))             
  (or_expr              --> and_expr                                            #'(lambda (e) (identity e)))

  (assign_expr          --> or_expr                                             #'(lambda (e) (identity e)))

  (assign_expr          --> ID COLON EQLS or_expr                               #'(lambda (ID COLON EQLS or_expr)
                                                                                (progn 
                                                                                  (mk-sym-entry (t-get-val ID))
                                                                                  (list 
                                                                                    (mk-code (append  
                                                                                      (var-get-code or_expr) 
                                                                                      (mk-2copy (blocked-symbol(t-get-val ID)) 
                                                                                        (var-get-place or_expr))))
                                                                                    (mk-place (blocked-symbol(t-get-val ID)))))))

  (expression           --> assign_expr                                         #'(lambda (e) (identity e)))
  
  (expression           --> expression COMMA assign_expr                        #'(lambda (expression COMMA assign_expr) 
                                                                                (progn
                                                                                  (list
                                                                                    (mk-code (append
                                                                                      (var-get-code expression)
                                                                                      (var-get-code assign_expr)))
                                                                                    (mk-place (var-get-place assign_expr))))))
  
  (expr_statement       --> expression  END                                     #'(lambda (expression END) (identity expression)))

  (expr_statement       -->  END                                                #'(lambda (END) 
                                                                                (progn
                                                                                  (list
                                                                                    (mk-code (append
                                                                                      (mk-0ac 'nop)))
                                                                                   (mk-place nil)))))     
  
  (selection_statement  --> IF LP expression RP stmts ENDI END                  #'(lambda (IF LP expression RP stmts ENDI END)
                                                                                (let  
                                                                                  ((label1 (newlabel)))
                                                                                  (list
                                                                                    (mk-code (append
                                                                                      (var-get-code expression)
                                                                                      (mk-2ac 'if (var-get-place expression) label1)
                                                                                      (var-get-code stmts)
                                                                                      (mk-1ac 'label label1)))
                                                                                    (mk-place nil)))))
                                                                                      
  (selection_statement  --> IF LP expression RP stmts ELSE stmts ENDI END       #'(lambda (IF LP expression RP stmts1 ELSE stmts2 ENDI END)
                                                                                (let  
                                                                                  ((label1 (newlabel))
                                                                                  (label2 (newlabel)))
                                                                                  (list
                                                                                    (mk-code (append
                                                                                      (var-get-code expression)
                                                                                      (mk-2ac 'if (var-get-place expression) label1)
                                                                                      (var-get-code stmts1)
                                                                                      (mk-1ac 'jump label2)
                                                                                      (mk-1ac 'label label1)
                                                                                      (var-get-code stmts2)
                                                                                      (mk-1ac 'label label2)))
                                                                                    (mk-place nil)))))

  (iter_statement       --> WHILE LP expression RP stmts ENDW END               #'(lambda (WHILE LP expression RP stmts ENDW END)
                                                                                (let  
                                                                                  ((label1 (newlabel))
                                                                                  (label2 (newlabel)))
                                                                                  (list
                                                                                    (mk-code (append
                                                                                      (mk-1ac 'label label1)
                                                                                      (var-get-code expression)
                                                                                      (mk-2ac 'if (var-get-place expression) label2)
                                                                                      (var-get-code stmts)
                                                                                      (mk-1ac 'jump label1)
                                                                                      (mk-1ac 'label label2)))
                                                                                    (mk-place nil)))))

  (iter_statement       --> DO stmts WHILE LP expression RP ENDDO END           #'(lambda (DO stmts WHILE LP expr RP ENDDO END)
                                                                                (let  
                                                                                  ((label1 (newlabel))
                                                                                  (label2 (newlabel)))
                                                                                  (list
                                                                                    (mk-code (append
                                                                                      (mk-1ac 'label label1)
                                                                                      (var-get-code stmts)
                                                                                      (var-get-code expression)
                                                                                      (mk-2ac 'if (var-get-place expression) label2)                                                     
                                                                                      (mk-1ac 'jump label1)
                                                                                      (mk-1ac 'label label2)))
                                                                                    (mk-place nil)))))   

  (iter_statement       --> FOR LP expr_statement expr_statement RP stmts ENDFOR END      #'(lambda (FOR LP expr_statement1 expr_statement2 RP stmts ENDFOR END)
                                                                                          (let  
                                                                                            ((label1 (newlabel))
                                                                                            (label2 (newlabel)))
                                                                                            (list
                                                                                              (mk-code (append
                                                                                                (var-get-code expr_statement1)
                                                                                                (mk-1ac 'label label1)
                                                                                                (var-get-code expr_statement2)
                                                                                                (mk-2ac 'if (var-get-place expr_statement2) label2)
                                                                                                (var-get-code stmts)
                                                                                                (mk-1ac 'jump label1)
                                                                                                (mk-1ac 'label label2)))
                                                                                              (mk-place nil)))))    

  (iter_statement       --> FOR LP expr_statement expr_statement expression RP stmts ENDFOR END   #'(lambda (FOR LP expr_statement1 expr_statement2 expression RP stmts ENDFOR END)
                                                                                                  (let  
                                                                                                    ((label1 (newlabel))
                                                                                                    (label2 (newlabel)))
                                                                                                    (list
                                                                                                      (mk-code (append
                                                                                                        (var-get-code expr_statement1)
                                                                                                        (mk-1ac 'label label1)
                                                                                                        (var-get-code expr_statement2)
                                                                                                        (mk-2ac 'if (var-get-place expr_statement2) label2)
                                                                                                        (var-get-code stmts)
                                                                                                        (var-get-code expression)
                                                                                                        (mk-1ac 'jump label1)
                                                                                                        (mk-1ac 'label label2)))
                                                                                                      (mk-place nil)))))                                                                                                                                                                      

  (ret_statement        --> RETURN expression END                               #'(lambda (RETURN expression END)
                                                                                (list 
                                                                                    (mk-code 
                                                                                      (append
                                                                                        (var-get-code expression)
                                                                                        (mk-1ac 'return (var-get-place expression))))
                                                                                    (mk-place nil))))

  (output_statement     --> OUTPUT expression END                               #'(lambda (OUTPUT expression END)
                                                                                (list 
                                                                                  (mk-code 
                                                                                    (append
                                                                                      (var-get-code expression)
                                                                                      (mk-1ac 'output (var-get-place expression))))
                                                                                  (mk-place nil))))

  (statement            --> output_statement                                    #'(lambda (s) (identity s)))

  (statement            --> ret_statement                                       #'(lambda (s) (identity s)))

  (statement            --> selection_statement                                 #'(lambda (s) (identity s)))

  (statement            --> iter_statement                                      #'(lambda (s) (identity s)))

  (statement            --> expr_statement                                      #'(lambda (s) (identity s)))

))

(defparameter lexforms '(ID END COLON EQLS LP RP ADD SUB MULT DIV GRT LST AND OR NOT IF ENDI ELSE WHILE ENDW DO ENDDO FOR ENDFOR COMMA FUN ENDF RETURN OUTPUT))

(defparameter lexicon '(
	          (\; END) ;; all but ID goes in the lexicon
		  (|:| COLON)
		  (|=| EQLS)
		  (|(| LP)
		  (|)| RP)
		  ($ $)        ; this is for lalrparser.lisp's end of input
		  (+ ADD)
		  (- SUB)
		  (* MULT)
		  (/ DIV)
      (if IF)
      (|>| GRT)
      (|<| LST)
      (and AND)
      (or OR)
      (|!| NOT)
      (if IF)
      (endi ENDI)
      (else ELSE)
      (while WHILE)
      (endw ENDW)
      (do DO)
      (enddo ENDDO)
      (for FOR)
      (endfor ENDFOR)
      (|,| COMMA)
      (fun FUN)
      (endf ENDF)
      (return RETURN)
      (output OUTPUT)
		  ))
  ;; if you change the end-marker, change its hardcopy above in lexicon above as well.
  ;; (because LALR parser does not evaluate its lexicon symbols---sorry.)
(defparameter *ENDMARKER* '$)

