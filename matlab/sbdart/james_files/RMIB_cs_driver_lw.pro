; idl routine to generate sbdart input files and run the program
; RMIB: clear, longwave

; interactive: requires input from user where appropriate

pro RMIB_cs_driver_lw

; 18 viewing zenith angles

blank = strarr(1,3)
blank2 = strarr(1,4)
flux = fltarr(8)
rad = fltarr(18)
file = ''

; the name needs changing each time through

spawn, "ln -s /hebe/helen/SBDART/RMIB_tests/test_2309/atms_2309.dat atms.dat"

openw, 1, 'INPUT'
printf, 1, "$INPUT"
printf, 1, "  wlinf = 2.5"
printf, 1, "  wlsup = 20.0"
printf, 1, "  wlinc = 0.05"
printf, 1, "  idatm = 0"
printf, 1, "  iaer = 4"
;printf, 1, "  vis = 23"
printf, 1, "  iout = 5"
printf, 1, "  nothrm = 0"
printf, 1, "  isalb = 0"
printf, 1, "  kdist = 2"
printf, 1, "  albcon = 0.094628"
printf, 1, "  sza = 95"
printf, 1, "$end"
printf, 1, "$DINPUT
printf, 1, "  btemp = 276.221985"
printf, 1, "  phi = 45."
printf, 1, "  nstr = 16"
printf, 1, "  uzen = 0,5,10,15,20,25,30,35,40,45,50,55,60,65,70,75,80,85
printf, 1, "$end"

close, 1
spawn, 'sbdart_v121_dbl'

nrec = 351

my_data = fltarr(nrec,20)
openr, 1, 'OUTPUT' 
readf, 1, blank
for i=0, 350 do begin
    readf, 1, flux
    readf, 1, blank2
    readf, 1, rad
    my_data[i,0] = flux[0]
    my_data[i,1] = flux[3]
    my_data[i,2:19] = rad[*]
endfor
close, 1

spawn, 'rm OUTPUT INPUT'

; write out part 1 runs to one file

read, file, prompt='Enter the filename for SBDART output: '

openw, 2, file
for j=0, nrec-1 do begin
    printf, 2, format = '(F8.4,1X,19(E12.5,1X))',my_data[j,*]
endfor

; second part, 20-100 microns (use 20 from previous) 

openw, 1, 'INPUT'
printf, 1, "$INPUT"
printf, 1, "  wlinf = 20.0"
printf, 1, "  wlsup = 100.0"
printf, 1, "  wlinc = 1.0"
printf, 1, "  idatm = 0"
printf, 1, "  iaer = 4"
;printf, 1, "  vis = 23"
printf, 1, "  iout = 5"
printf, 1, "  nothrm = 0"
printf, 1, "  isalb = 0"
printf, 1, "  albcon = 0.094628"
printf, 1, "  kdist = 2"
printf, 1, "  sza = 95"
printf, 1, "$end"
printf, 1, "$DINPUT
printf, 1, "  btemp = 276.221985"
printf, 1, "  phi = 45."
printf, 1, "  nstr = 16"
printf, 1, "  uzen = 0,5,10,15,20,25,30,35,40,45,50,55,60,65,70,75,80,85
printf, 1, "$end"

close, 1
spawn, 'sbdart_v121_dbl'

nrec = 81
my_data = fltarr(nrec,20)
openr, 1, 'OUTPUT' 
readf, 1, blank
for i=0, 80 do begin
    readf, 1, flux
    readf, 1, blank2
    readf, 1, rad
    my_data[i,0] = flux[0]
    my_data[i,1] = flux[3]
    my_data[i,2:19] = rad[*]
endfor
close, 1

spawn, 'rm OUTPUT INPUT'

; write out part 2 runs to same file

for j=1, nrec-1 do begin
    printf, 2, format = '(F8.4,1X,19(E12.5,1X))',my_data[j,*]
endfor
close, 2
stop

end
