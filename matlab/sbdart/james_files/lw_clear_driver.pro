; idl routine to generate sbdart input files and run the program

; Here we are looking to calculate broad-band radiances and fluxes for the
; LW with realistic surface emissivities for each TIGR-3 atmosphere (336 in all)  
; Eventual aim is to test the GERB radiance to flux conversion

pro lw_clear_driver

data1 = fltarr(8,1)
blank = strarr(1,4)
data2 = fltarr(1)      

op1 = fltarr(126,3)
op2 = fltarr(126,15)

; first: indices of TIGR-3 atmospheres to be used, and their associated surface type

openr, 1, 'LW_atmos_indices'
readf, 1, npts

index = fltarr(npts)
surf = fltarr(npts)

readf, 1, index
readf, 1, surf
close, 1

index = fix(index)

; surface types (various combinations of JPL/JHU spectral albedo data):
; wavelengths run from 2.5 to 15 microns in steps of 0.25

category = ['ocean','evergreen','mixed','crop','savanna','barren','desert']

wave = fltarr(51)
albedo = fltarr(51)
albn = fltarr(7,2,52)

for i=0,6 do begin

    filen = strcompress(category[i]+'_albedo.dat',/remove_all)
    openr, 1, filen
    readf, 1, wave,albedo
    close, 1
    albn[i,0,0:50] = wave[*]
    albn[i,1,0:50] = albedo[*]
    albn[i,0,51] = 100.
    albn[i,1,51] = albn[i,1,50]

endfor

; loop over the TIGR-3 atmospheres

data = fltarr(5,40)

for iatm = 0, npts-1 do begin

; read in the appropriate atmosphere and write out to atms.dat

    if index[iatm] lt 10 then begin
         text = strcompress('000'+string(index[iatm]), /remove_all)
    endif
    if index[iatm] ge 10 and index[iatm] lt 100 then begin
         text = strcompress('00'+string(index[iatm]), /remove_all)
    endif
    if index[iatm] ge 100 and index[iatm] lt 1000 then begin
         text = strcompress('0'+string(index[iatm]), /remove_all)
    endif
    if index[iatm] ge 1000 then text = string(index[iatm])
    
    cd, '/hebe/helen/AEROSOL/MODTRAN/Mod4v3r1/LW_runs/atmos_data'   

    filename = strcompress('atms_'+text+'.dat', /remove_all)
    openr, 1, filename
    readf, 1, b1
    readf, 1, data
    close, 1

    cd, '/hebe/helen/AEROSOL/SBDART/executables/radiance_to_flux'

; write out info to file for reading by SBDART

    openw, 1, 'atms.dat'
    printf, 1, '40'
    printf, 1, data
    close, 1

; use the surface type to assign the correct albedo - and extend to full range

    albi = fix(surf[iatm]) - 1
    albi = 0
    openw, 1, 'albedo.dat'
    for i=0,51 do begin
        printf, 1, albn[albi,0,i],albn[albi,1,i]
    endfor
    close, 1

    openw, 1, 'INPUT'
    printf, 1, "$INPUT"
    printf, 1, "  wlinf = 2.5"
    printf, 1, "  wlsup = 15.0"
    printf, 1, "  wlinc = 0.1"
    printf, 1, "  idatm = 0"
    printf, 1, "  sza = 100."
    printf, 1, "  iout = 5"
    printf, 1, "  nothrm = 0"
    printf, 1, "  isalb = -1"
    printf, 1, "  kdist = 3"
    printf, 1, "  iaer = 0"
    printf, 1, "  nstr = 20"
    printf, 1, "  nzen = 15"
    printf, 1, "  uzen = 0,84"
    printf, 1, "  phi = 0"
    printf, 1, "$end"
    close, 1
    spawn, 'sbdart_v24ed'

    openr, 1, 'OUTPUT' 
    for iwv=0,125 do begin
        readf, 1, data1
        op1[iwv,0] = reform(data1[0,0])
        op1[iwv,1] = reform(data1[2,0])
        op1[iwv,2] = reform(data1[3,0]) 
        readf, 1, blank
        for izen=0,14 do begin
            readf, 1, data2
            op2[iwv,izen] = data2
        endfor
    endfor
    close, 1

    cd, '/iris/helen/SBDART_OUTPUT'

    filename = strcompress('clear_lw_atm'+string(iatm+1)+'.output', /remove_all)
    openw, 1, filename
    printf, 1, op1
    printf, 1, op2
    close, 1

stop   
    spawn, 'rm OUTPUT INPUT'

endfor
stop

end
