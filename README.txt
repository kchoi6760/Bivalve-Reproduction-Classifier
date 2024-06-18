The script repro_process.R processes the files in the "data" folder.

Files in the data folder include: 
- reprodata.csv : a file containing site ID, the source study, bivalve species name, locality name, latitude and longitude in degrees/minutes, and up to three reproductive seasons, arranged by the start of the spawning season, the peak, and the end. these are arranged in units of month of year that the observation occurred (1-12)
note that the month is calendar month and so seasons are opposite in the northern and soutern hemispheres!
- families.csv: contains the families associated with different bivalve species

Within the environment data subfolder:
- chlorophyll, salinity and temperature folders, containing csv files named by the site ID from the reprodata.csv file. the first column is decimal date (with integers representing years and the decimal representing how far along we are in each year). The second column reprsents the environmental data.
- chlorophyll is in units of micrograms/L. chlorophyll-a is a measure of how much plankton is present (the bivalves' food). The hypothesis we're testing with this data is whether the bivalves spawn when food is greatest.
- temperature is units of Celsius. This data will help us test if the bivalves are timing their bivalves according to the temperature
- salinity is in Practical Salinity Units (PSU). for bivalves in estuaries, salinity could be important

repro_process.R in the root of directory organizes and cleans up the data, merging the environmental data into data frames organized by site name. also joins the family name onto the main reproductive data file. 