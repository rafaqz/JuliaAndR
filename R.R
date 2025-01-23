# install.packages('terra')
# install.packages('JuliaCall')

library(terra)
library(JuliaCall)

# install_julia()

x <- julia_command('a = 1')

# The variable `a` still exists in julia
x <- julia_eval('a')

# Can pass in values from R with `julia_call`
m <- julia_call('max', 1, 2)
m

m <- julia_call('maximum', c(1, 2, 3, 4, 5))

t <- julia_call('typeof', c(1, 2, 3, 4, 5))

# Libraries

# Install some packages
julia_install_package_if_needed('Rasters')
julia_install_package_if_needed('RasterDataSources')
julia_install_package_if_needed('ArchGDAL')

# Check the current version
julia_installed_package('Rasters')

julia_library('Rasters')
julia_library('ArchGDAL')
julia_library('RasterDataSources')


# Download a raster with Rasters
julia_command('ENV["RASTERDATASOURCES_PATH"] = "."')
julia_command('rast = Raster(WorldClim{BioClim}, :bio1; lazy=true, missingval=NaN)')

# And write it as an R native grd file 
julia_command('write("bio1.grd", rast; force=true)')

# Load the raster in terra
library('terra')
rast = terra::rast('bio1.grd')

plot(rast)

j_rast <- julia_eval('rast')
j_rast[is.na(j_rast)] <- -1
