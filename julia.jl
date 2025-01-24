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
NA
"""

@rlibrary terra


# Load the file from disk

R"""
R_rast <- terra::rast('bio1.grd')
A <- as.matrix(R_rast)
"""

# @rget and @rput

@rget R_rast
@rget A

# Make it
newrast = Raster(reshape(A, Base.size(rast)), dims(rast); missingval=NaN)

@rput newrast


R"""
terra::rast(newrast, extent=terra::ext(R_rast))
"""



# Python 

# we could do this but NINA windows defender wont let us install 
# packages with mamba

# using PythonCall, RDatasets
# using CondaPkg

# CondaPkg.add("seaborn")

# iris = dataset("datasets", "iris")

# sns = pyimport("seaborn")
# sns.set_theme()
# sns.pairplot(pytable(iris), hue="Species")