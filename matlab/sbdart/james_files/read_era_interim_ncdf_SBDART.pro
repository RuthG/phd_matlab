;program to open nand read netcdf file. this is specifically for emcwf ERA-interim data. This data will be
;used as a case study for the SBDART radiative transfer model.

;written by J.Ingram 07/12/2012

pro read_era_interim_ncdf

;set working directory and output directory

dir = 'F:\PHD\SBDART\ERA_interim_data'

;specify the string format pattern of the filename for the code to search for
filename = 'ggap201006051200.nc'

;files to process
files_to_process = FILE_SEARCH(dir, filename)
 
cd, dir

nfiles = N_ELEMENTS(files_to_process)

; Loop over the number of files (nfiles)
  FOR i=0, nfiles -1 DO BEGIN

  ; Open File
    ncdf_id = NCDF_OPEN(filename)

  ;read the data variables that i want (eg temperature, rh, pressure, lat, lon etc)
  
      NCDF_VARGET, ncdf_id, 't', base_time
      NCDF_VARGET, ncdf_id, 'p', pressure
      NCDF_VARGET, ncdf_id, 'R', atmosphericRelativeHumidity
      NCDF_VARGET, ncdf_id, 'T', AirTemp
      NCDF_VARGET, ncdf_id, 'latitude', latitude
      NCDF_VARGET, ncdf_id, 'longitude', longitude
      NCDF_VARGET, ncdf_id, 'CC', cloud_cover
      NCDF_VARGET, ncdf_id, 'CIWC', CIWC
      NCDF_VARGET, ncdf_id, 'Z', geopotential
      NCDF_VARGET, ncdf_id, 'O', ozone
  NCDF_CLOSE, ncdf_id  
  
;save data files
save, filename = 'F:\PHD\SBDART\ERA_interim_data\era_interim_profiles.sav',  base_time, atmosphericRelativeHumidity, AirTemp, Latitude, Longitude, cloud_cover, ozone 

;subset by latitude and longitude
;mesh grid is used to matchup the latitude and longitude matrices, as they are not arrays in era-interim data. 
mesh = meshgrid(longitude, latitude)
longitude = mesh[*,*,0]
latitude = mesh[*,*,1]

grid = where(latitude ge -2. and latitude le 0 and longitude ge 16.8 and longitude le 19.3, ngrid)
   ;s = SIZE(grid)
  ; ncol = s(1)
   ;column = grid MOD ncol
   ;row = grid / ncol
   ;
;wheretomulti will find where an event is occuring in a 2 or 3 dimensional array, rather than giving the data in a 1d array
wheretomulti, mesh, grid,  Column, Row, Frame

print, 'latitudes', latitude[column, row], column, row
print, 'longitudes', longitude[column, row]
;subset temperature profile by the grid
temp = AirTemp[column, row, *]
rh = atmosphericRelativeHumidity[column, row, *]


;calculate geopotential height
geo = geopotential/9.8
gp = geo[column,row,*]

;calculate the ozone density
OD = (ozone*(pressure/(287.05/temp)))*1000


;calcualte the water vapour density
 
stop



endfor
end
