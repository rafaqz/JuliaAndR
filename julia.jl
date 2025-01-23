# Set up the environment
using Pkg
Pkg.activate(".")
# Pkg.instantiate()

using RCall
using Rasters
using RasterDataSources
using ArchGDAL

# Load a raster file 
rast = Raster(WorldClim{BioClim}, :bio1; lazy=true)
# And write it
write("bio1.grd", rast; force=true)

# Install and load terra

R"""
# options(repos=c(CRAN="https://mirror.accum.se/mirror/CRAN/"))
# install.packages("terra")
""
"""

@rlibrary terra

R"""
R_rast <- terra::rast('bio1.grd')
"""

@rget R_rast

