; idl routine to generate sbdart input files and run the program
; RMIB: cloudy, solar, spectrally resolved

; interactive: requires input from user where appropriate

pro RMIB_cl_res_driver

blank = strarr(3,1)
data = fltarr(10,4)
my_data = fltarr(40,5,10,4)
file = ''

; the name needs changing each time through

spawn, "ln -s /hebe/helen/SBDART/RMIB_tests/test_0542/atms_0542.dat atms.dat"

    openw, 1, 'INPUT'
    printf, 1, "$INPUT"
    printf, 1, "  wlinf = 0.945"
    printf, 1, "  wlsup = 0.945"
;    printf, 1, "  wlinc = 0.005"
    printf, 1, "  idatm = 0"
    printf, 1, "  iaer = 0"
    printf, 1, "  sza = 0"
    printf, 1, "  iout = 7"
    printf, 1, "  nothrm = 1"
    printf, 1, "  isalb = 10"
    printf, 1, "  sc = 0.0,0.396362,0.871287,0.0
    printf, 1, "  kdist=2"
    printf, 1, "  zcloud = 5.537495"
    printf, 1, "  tcloud = 303.546670"
    printf, 1, "  nre = 26.586267"
    printf, 1, "  idb(8) =1"
;    printf, 1, "  ickp = 2"
    printf, 1, "$end"

    close, 1
    spawn, 'sbdart_v22'
    stop

    openr, 1, 'OUTPUT' 
    readf, 1, blank
    for i=0, 39 do begin
        readf, 1, blank
        for j=0, 4 do begin
            readf, 1, ""
            readf, 1, data
            my_data[i,j,*,*] = data
        endfor
    endfor
    close, 1

stop

end
