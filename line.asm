		.data
		.align 4
buff:		.space 4
offset:		.space 4
size:		.space 4
width:		.space 4
poczatek:	.space 4
wartosc1:	.space 4
wartosc2:	.space 4
wartosc3:	.space 4
wartosc4:	.space 4
wartosc5:	.space 4
msgFileExc:	.asciiz "Blad zwiazany z plikiem\n"
fileNameIn:	.asciiz "in.bmp"
fileNameOut:	.asciiz "out.bmp"
kom:		.asciiz "Podaj wspolrzedna x punktu 1: \n"
kom2:		.asciiz "\nPodaj wspolrzedna y punktu 1: \n"
kom3:		.asciiz "\nPodaj wspolrzedna x punktu 2: \n"
kom4:		.asciiz "\nPodaj wspolrzedna y punktu 2: \n"
kom5:		.asciiz "\nTwoje punkty maja wspolrzedne: x("
kom6:		.asciiz ","
kom7:		.asciiz "), y("
kom8:		.asciiz ")\n"
kom9:		.asciiz "Rysuje punkt p("
buf:		.space 4
		.text
		.globl main

main:
	# otworzenie pliku o nazwie 'in.bmp':
	la $a0, fileNameIn
	li $a1, 0
	li $a2, 0
	li $v0, 13
	syscall	
	move $t1, $v0 		# deskryptor pliku do $t1
	bltz $t1, fileExc
	# odczytanie 2 bajtow 'BM':
	move $a0, $t1
	la $a1, buff
	li $a2, 2
	li $v0, 14
	syscall
	# odczytanie 4 bajtow okreslajacych rozmiar pliku
	move $a0, $t1
	la $a1, size
	li $a2, 4
	li $v0, 14
	syscall
	lw $s0, size		# zapisanie rozmiaru w $s0
	# alokacja pamieci o rozmiarze pliku:
	move $a0, $s0
	li $v0, 9
	syscall
	move $s1, $v0		# przekazanie adresu zaalokowanej pamieci do $s1
	sw $s1, poczatek
	# odczytanie 4 bajtow zarezerwowanych:
	move $a0, $t1		# przywrocenie deskrptora pliku dla $a0
	la $a1, buff
	li $a2, 4
	li $v0, 14
	syscall
	# odczytanie offsetu:
	move $a0, $t1
	la $a1, offset
	li $a2, 4
	li $v0, 14
	syscall
	# odczytanie 4 bajtow naglowka informacyjnego:
	move $a0, $t1
	la $a1, buff
	li $a2, 4
	li $v0, 14
	syscall
	# odczytanie szerokosci (width) obrazka:
	move $a0, $t1
	la $a1, width
	li $a2, 4
	li $v0, 14
	syscall
	lw $s2, width			# zaladowanie width do $s2
	# odczytanie wysokosci (height) obrazka:
	move $a0, $t1
	la $a1, buff
	li $a2, 4
	li $v0, 14
	syscall
	# zamkniecie pliku:
	move $a0, $t1
	li $v0, 16
	syscall
	# wczytanie tablicy pikseli pod adres zaalokowanej pamieci w $s1
	la $a0, fileNameIn
	la $a1, 0
	la $a2, 0
	li $v0, 13
	syscall
	move $t1, $v0
	move $a0, $t1
	la $a1, ($s1)
	la $a2, ($s0)		# wczytanie tylu bajtow, ile ma plik
	li $v0, 14
	syscall
	lw $s0, size
	move $a0, $t1		# zamkniecie pliku
	li $v0, 16
	syscall
	lw $s5, offset		# zaladowanie offsetu do $s5
	li $t7, 0		# licznik ustawiony na 0
	lw $s2, width
	add $s1, $s1, $s5	# przejscie na poczatek tabeli pikseli
	li $s6, 4
	div $s2, $s6		#podzeielenie z reszta szerokosci przez 4, by ustalic padding
	mfhi $s6		#padding			
#pierwsza
	li $v0, 4
	la $a0, kom
	syscall		# wyswietlenie komunikatu
	li $v0, 5
	syscall		# odczyt inta, jest teraz w v0
	la $t0, ($v0)	# zaladowanie odczytanego inta
	li $v0, 1
	la $a0, ($t0)
	syscall		# wypisanie zawartej pamieci
# druga wspolrzedna
	li $v0, 4
	la $a0, kom2
	syscall		# wyswietlenie komunikatu
	li $v0, 5
	syscall		# odczyt inta, jest teraz w v0
	la $t1, ($v0)	# zaladowanie odczytanego inta
	li $v0, 1
	la $a0, ($t1)
	syscall		# wypisanie zawartej pamieci
# trzecia wspolrzedna
	li $v0, 4
	la $a0, kom3
	syscall		# wyswietlenie komunikatu
	li $v0, 5
	syscall		# odczyt inta, jest teraz w v0
	la $t2, ($v0)	# zaladowanie odczytanego inta
	li $v0, 1
	la $a0, ($t2)
	syscall		# wypisanie zawartej pamieci
# czwarta wspolrzedna
	li $v0, 4
	la $a0, kom4
	syscall		# wyswietlenie komunikatu
	li $v0, 5
	syscall		# odczyt inta, jest teraz w v0
	la $t3, ($v0)	# zaladowanie odczytanego inta
	li $v0, 1
	la $a0, ($t3)
	syscall		# wypisanie zawartej pamieci
# podsumowanie:
	li $v0, 4
	la $a0, kom5
	syscall		# wyswietlenie komunikatu
	li $v0, 1
	la $a0, ($t0)
	syscall		# wypisanie zawartej pamieci
	li $v0, 4
	la $a0, kom6
	syscall		# wyswietlenie komunikatu
	li $v0, 1
	la $a0, ($t1)
	syscall		# wypisanie zawartej pamieci
	li $v0, 4
	la $a0, kom7
	syscall		# wyswietlenie komunikatu
	li $v0, 1
	la $a0, ($t2)
	syscall		# wypisanie zawartej pamieci
	li $v0, 4
	la $a0, kom6
	syscall		# wyswietlenie komunikatu
	li $v0, 1
	la $a0, ($t3)
	syscall		# wypisanie zawartej pamieci
	li $v0, 4
	la $a0, kom8
	syscall		# wyswietlenie komunikatu
# tu mamy 4 wspolrzedne, x1, y1, x2, y2 pod adresami t0, t1, t2, t3
	la $t4, ($t0)	# zmienne x i y na ktorych bedziemy operowac
	la $t5, ($t1)	# tu x to t4, y, to t5
	bge $t0, $t2, else		# jak wieksze lub rowne t0(x1) od t2(x2), to else
	li $t6, 1		#xi = 1
	sub $t7, $t2, $t0	#dx = x2 - x1
	b next		# tu xi to t6 , dx to t7
else:
	li $t6, -1		#xi = -1
	sub $t7, $t0, $t2	#dx = x1 - x2
next:
	bge $t1, $t3, else2	#if(y1<y2)
	li $s0, 1		#yi = 1
	sub $s7, $t3, $t1 	#dy = y2 - y1
	b next2	# tu yi, to s0, a dy to s7
else2:
	li $s0, -1		#yi = -1
	sub $s7, $t1, $t3	#dy = y2 - y1
next2:	#algorytm korzysta z 13 zmiennych, konieczny zapis
	sw $t0, wartosc1	#x1
	sw $t1, wartosc2	#y1
	sw $t2, wartosc3	#x2
	sw $t3, wartosc4	#y2
	sw $s7, wartosc5	#dy
kolorowanie:			# obliczamy (y-1)*(3*szerokosc+padding)+3*(x-1)
	lw $s5, width		#szerokosc
	move $t1, $t4		#x
	move $t2, $t5		#y
	li $t3, 0		#licznik do wyliczania piksela
	subi $t1, $t1, 1	#x--
	blez $t1, paf		#if(x>0) , to wchodzimy w puf
puf:
	addi $t3, $t3, 3	#+3
	subi $t1, $t1, 1	#x-- w petli
	bgtz $t1, puf		#petla az t1(x) <= 0
paf:
	li $t0, 0		#licznik
	subi $t2, $t2, 1	#y--
	blez $t2, pok		#jak t2(y) <= 0 , to omijamy pam
pam:
	add $t0, $t0, $s5	#dodajemy potrojna szerokosc tyle razy ile y-1
	add $t0, $t0, $s5
	add $t0, $t0, $s5
	add $t0, $t0, $s6		## s6 to padding, 
	subi $t2, $t2, 1	#y--
	bgtz $t2, pam
pok:
	add $t3, $t3, $t0	#suma dwoch powyzszych wyrazen
	add $s1, $s1, $t3		#pierwszy bit piksela x,y
	li $s7, 0		# wartosc do kolorowania, 0 0 0 to czarny
	sb $s7, ($s1)
	addi $s1, $s1, 1	#kolorowaine BGR W pikselu
	sb $s7, ($s1)
	addi $s1, $s1, 1
	sb $s7, ($s1)
	subi $s1, $s1, 2			## kolorowanie na czarno
	sub $s1, $s1, $t3	# powrot do poczatku skad zaczynalismy
	lw $t0, wartosc1
	lw $t1, wartosc2
	lw $t2, wartosc3
	lw $t3, wartosc4
	lw $s7, wartosc5
	# podsumowanie:
	li $v0, 4
	la $a0, kom9
	syscall		# wyswietlenie komunikatu
	li $v0, 1
	la $a0, ($t4)
	syscall		# wypisanie zawartej pamieci
	li $v0, 4
	la $a0, kom6
	syscall		# wyswietlenie komunikatu
	li $v0, 1
	la $a0, ($t5)
	syscall		# wypisanie zawartej pamieci
	li $v0, 4
	la $a0, kom8
	syscall		# wyswietlenie komunikatu
# to wyzej to rysowanie plamki o wspolrzednych t4, t5
next3:	
	bge $s7, $t7, else3
	#tu jestesmy jak s7 < t7, czyli dy < dx, czyli os wiodaca, to OX
	sub $s2, $s7, $t7	#ai = dy-dx
	sll $s2, $s2, 1		#ai = 2*ai
	sll $s3, $s7, 1		#bi = 2*dy
	sub $s4, $s3, $t7	#d = bi - dx
loop:
	beq $t2, $t4, back 	#while(x!=x2)
	bltz $s4, else4		#if(d>=0), to wchodzimy nizej
	add $t4, $t6, $t4	#x += xi
	add $t5, $s0, $t5	#y += yi
	add $s4, $s2, $s4	#d +=ai
	b next4
else4:
	add $s4, $s3, $s4	#d += bi
	add $t4, $t6, $t4	#x += xi
next4:
	sw $t0, wartosc1	#algorytm korzysta z 13 zmiennych, konieczny zapis	
	sw $t1, wartosc2
	sw $t2, wartosc3
	sw $t3, wartosc4
	sw $s7, wartosc5
kolorowanie2:			#analogiczne do wyzej (kolorowanie)
	lw $s5, width		#szerokosc
	move $t1, $t4			##x
	move $t2, $t5			##y
	li $t3, 0		#licznik do wyliczania piksela
	subi $t1, $t1, 1	#x--
	blez $t1, paf2		#if(x>0) , to wchodzimy w puf2
puf2:
	addi $t3, $t3, 3	#+3
	subi $t1, $t1, 1	#x-- w petli
	bgtz $t1, puf2		#petla az t1(x) <= 0
paf2:
	li $t0, 0		#licznik
	subi $t2, $t2, 1	#y--
	blez $t2, pok2		#jak t2(y) <= 0 , to omijamy pam2
pam2:
	add $t0, $t0, $s5	#dodajemy potrojna szerokosc tyle razy ile y-1
	add $t0, $t0, $s5
	add $t0, $t0, $s5
	add $t0, $t0, $s6		## s6 to padding, 
	subi $t2, $t2, 1	#y--
	bgtz $t2, pam2
pok2:
	add $t3, $t3, $t0	#suma dwoch powyzszych wyrazen
	add $s1, $s1, $t3		#pierwszy bit piksela x,y
	li $s7, 0		# wartosc do kolorowania, 0 0 0 to czarny
	sb $s7, ($s1)
	addi $s1, $s1, 1	#kolorowaine BGR W pikselu
	sb $s7, ($s1)
	addi $s1, $s1, 1
	sb $s7, ($s1)
	subi $s1, $s1, 2			## kolorowanie na czarno
	sub $s1, $s1, $t3	# powrot do poczatku skad zaczynalismy
	lw $t0, wartosc1
	lw $t1, wartosc2
	lw $t2, wartosc3
	lw $t3, wartosc4
	lw $s7, wartosc5
	# podsumowanie:
	li $v0, 4
	la $a0, kom9
	syscall		# wyswietlenie komunikatu
	li $v0, 1
	la $a0, ($t4)
	syscall		# wypisanie zawartej pamieci
	li $v0, 4
	la $a0, kom6
	syscall		# wyswietlenie komunikatu
	li $v0, 1
	la $a0, ($t5)
	syscall		# wypisanie zawartej pamieci
	li $v0, 4
	la $a0, kom8
	syscall		# wyswietlenie komunikatu
	# to wyzej to rysowanie plamki o wspolrzednych t4, t5
	b loop
else3:
	# tu jestesmy jak os wiodaca, to OY
	sub $s2, $t7, $s7	#ai = dx - dy
	sll $s2, $s2, 1		#ai = 2*ai
	sll $s3, $t7, 1		#bi = 2*dx
	sub $s4, $s3, $s7	#d = bi - dy
loop2:
	beq $t3, $t5, back	#while(y!=y2)
	bltz $s4, else5		#if(d>=0), to wchodzi
	add $t4, $t6, $t4	#x += xi
	add $t5, $s0, $t5	#y += yi
	add $s4, $s2, $s4	#d +=ai
	b next5
else5:
	add $s4, $s3, $s4	#d +=bi
	add $t5, $t5, $s0	#y += yi
next5:		
	sw $t0, wartosc1
	sw $t1, wartosc2
	sw $t2, wartosc3
	sw $t3, wartosc4
	sw $s6, wartosc5
kolorowanie3:			# opis wyzej, analogicznie do kolorowanie
	lw $s5, width		#szerokosc
	move $t1, $t4		#x
	move $t2, $t5		#y
	li $t3, 0		#licznik do wyliczania piksela
	subi $t1, $t1, 1	#x--
	blez $t1, paf3		#if(x>0) , to wchodzimy w puf3
puf3:
	addi $t3, $t3, 3	#+3
	subi $t1, $t1, 1	#x-- w petli
	bgtz $t1, puf3		#petla az t1(x) <= 0
paf3:
	li $t0, 0		#licznik
	subi $t2, $t2, 1	#y--
	blez $t2, pok3		#jak t2(y) <= 0 , to omijamy pam
pam3:
	add $t0, $t0, $s5	#dodajemy potrojna szerokosc tyle razy ile y-1
	add $t0, $t0, $s5
	add $t0, $t0, $s5
	add $t0, $t0, $s6		## s6 to padding, 
	subi $t2, $t2, 1	#y--
	bgtz $t2, pam3
pok3:
	add $t3, $t3, $t0	#suma dwoch powyzszych wyrazen
	add $s1, $s1, $t3		#pierwszy bit piksela x,y
	li $s7, 0		# wartosc do kolorowania, 0 0 0 to czarny
	sb $s7, ($s1)
	addi $s1, $s1, 1	#kolorowaine BGR W pikselu
	sb $s7, ($s1)
	addi $s1, $s1, 1
	sb $s7, ($s1)
	subi $s1, $s1, 2			## kolorowanie na czarno
	sub $s1, $s1, $t3	# powrot do poczatku skad zaczynalismy
	lw $t0, wartosc1
	lw $t1, wartosc2
	lw $t2, wartosc3
	lw $t3, wartosc4
	lw $s7, wartosc5
	# podsumowanie:
	li $v0, 4
	la $a0, kom9
	syscall		# wyswietlenie komunikatu
	li $v0, 1
	la $a0, ($t4)
	syscall		# wypisanie zawartej pamieci
	li $v0, 4
	la $a0, kom6
	syscall		# wyswietlenie komunikatu
	li $v0, 1
	la $a0, ($t5)
	syscall		# wypisanie zawartej pamieci
	li $v0, 4
	la $a0, kom8
	syscall		# wyswietlenie komunikatu
# to wyzej to rysowanie plamki o wspolrzednych t4, t5	
	b loop2	
fileExc:		# ewentualny blad do wyswietlenia w przypadku braku lub blednego pliku in.bmp
	la $a0, msgFileExc
	li $v0, 4
	syscall	
	b end
back:
saveFile:
	# zapisujemy wynik pracy w pliku "out.bmp"
	la $a0, fileNameOut
	li $a1, 1
	li $a2, 0
	li $v0, 13
	syscall		#otwarcie pliku
	move $t0, $v0
	bltz $t0, fileExc
	lw $s0, size
	lw $s1, poczatek
	move $a0, $t0
	la $a1, ($s1)	#to co do zapisania
	la $a2, ($s0)	#liczba znakow
	li $v0, 15
	syscall		#zapis do pliku
	move $a0, $t0
	li $v0, 16
	syscall		#zamkniece pliku
end:
	# zamkniecie programu:
	li $v0, 10
	syscall
