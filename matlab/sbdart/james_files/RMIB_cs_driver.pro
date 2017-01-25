; idl routine to generate sbdart input files and run the program
; RMIB: clear, solar

; interactive: requires input from user where appropriate

pro RMIB_cs_driver

; 9 solar zenith angles

szen = [0,10,20,30,40,50,60,70,80]

blank = strarr(3,1)
data = fltarr(8,751)
my_data = fltarr(9,8,751)
file = ''

; the name needs changing each time through

spawn, "ln -s /hebe/helen/SBDART/RMIB_tests/test_2309/atms_2309.dat atms.dat"

for isza = 0, 8 do begin

    openw, 1, 'INPUT'
    printf, 1, "$INPUT"
    printf, 1, "  wlinf = 0.25"
    printf, 1, "  wlsup = 4.0"
    printf, 1, "  wlinc = 0.005"
    printf, 1, "  idatm = 0"
    printf, 1, "  iaer = 0"
;    printf, 1, "  vis = 23" 
    printf, 1, "  sza = ",szen[isza]
    printf, 1, "  iout = 1"
    printf, 1, "  nothrm = 1"
    printf, 1, "  isalb = 10"
    printf, 1, "  sc = 0.0,1.278154,0.0,0.0
    printf, 1, "  kdist = 2"
    printf, 1, "$end"

    close, 1
    spawn, 'sbdart_v121_dbl'
    openr, 1, 'OUTPUT' 
    readf, 1, blank
    readf, 1, data
    print, data
    close, 1
    my_data[isza,*,*] = data

    spawn, 'rm OUTPUT INPUT'

endfor
        
; write out all runs to one file

nrec = 751

read, file, prompt='Enter the filename for SBDART output: '

openw, 1, file
for j=0, nrec-1 do begin
    printf, 1, format = '(F12.8,9(E12.4))', my_data[0,0,j],my_data[0,3,j],my_data[1,3,j],my_data[2,3,j],  $
              my_data[3,3,j],my_data[4,3,j],my_data[5,3,j],my_data[6,3,j],my_data[7,3,j],my_data[8,3,j]
endfor
close, 1
stop

end
