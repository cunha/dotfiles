#!/usr/bin/env python

# There are issues with cartopy that I haven't checked in the last
# couple of months.  However, if you run the following commands it
# *should* fix the cartopy issues.  I found some random threads in a
# github issue for cartopy, and I had to combine two solutions to fix
# the issue.

#pip uninstall -y shapely
#pip install shapely --no-binary shapely
#apt-get -qq install python3-cartopy
#pip install --upgrade matplotlib


import matplotlib
import matplotlib.pyplot as plt
from matplotlib import rc, cm
import cartopy
import cartopy.io.shapereader as shpreader
import cartopy.crs as ccrs
import numpy as np
import pandas as pd
from matplotlib.colors import ListedColormap, LinearSegmentedColormap


def formatSize(width=16, height=4.94, legendFontsize='20'):
    params = {'legend.fontsize': legendFontsize,
              'figure.figsize': (width, height),
              'axes.labelsize': 30,
              'axes.titlesize':30,
              'xtick.labelsize': 22,
              'ytick.labelsize': 22,
              'font.weight': 'normal'}  
    matplotlib.rcParams.update(params)

#Set up the color map

# The scale of the colorbar.  We go from -40 -- 40, so N=80 worked
# best.  N is also needed later to determine the color.
N = 80

RdGyGn = LinearSegmentedColormap.from_list(
    name='RdGyGn',
    colors = [
              (1, 0, 0), #red
              (1, 153/255, 51/255), #orange
              (1, 1, 51/255), #yellow
              (51/255, 204/255, 153/255), # blue green
              #(0, 130/255, 130/255), # teal
              #    (0, 1, 0), # green
              #(0, 0, 1), # blue
              (0, 33/255, 203/255), #indigo
    ],
    N=N)

cm.register_cmap(name='RdGyGn', cmap=RdGyGn)
colorbarMappable = cm.ScalarMappable(cmap=RdGyGn)
colorbarMappable.set_array([-1 * (N/2), (N/2)])



##########
#
# This section sets up the figure, loops through the countries, and
# sets the colors according the the above colormap
#
#########

formatSize(height=4.94, legendFontsize=12)

# I left the options I didn't use commented out as I messed with the
# maps

ax = plt.axes(projection=ccrs.PlateCarree())
#ax.add_feature(cartopy.feature.LAND)
ax.add_feature(cartopy.feature.OCEAN)
#ax.add_feature(cartopy.feature.COASTLINE)
ax.add_feature(cartopy.feature.BORDERS, linestyle='-')#, alpha=.5)
#ax.add_feature(cartopy.feature.LAKES, alpha=0.95)
#ax.add_feature(cartopy.feature.RIVERS)
ax.set_extent([-130, 180, -50, 70], crs=ccrs.PlateCarree())

# Pull in country info, including full name and two letter
# abbreviation.
shpfilename = shpreader.natural_earth(resolution='110m',
                                      category='cultural',
                                      name='admin_0_countries')
reader = shpreader.Reader(shpfilename)
countries = reader.records()

# These are here for a simple  example just to make sure it runs without error.
overlappingCC_euc = ['UK', 'FR']
class PlotData():
    def __init__(self):
        self.data = []
        
rtt_dif_country_stan_eu_cent_fra_P50 = PlotData()
rtt_dif_country_stan_eu_cent_fra_P50.data.append({
    'cc': 'FR',
    'diff': -20
    })

rtt_dif_country_stan_eu_cent_fra_P50.data.append({
    'cc': 'UK',
    'diff': 20
    })

# I assume that the data is binned into data by country, and the
# countries are labeled by the standard 2-letter abbeviation.
#
# The if catches are because at the time for some reason France,
# Norway, and Turkey were not correct in the shapreader of the python
# package.  MAY be fixed now, I haven't checked.

# Loop through all countries
for country in countries:
  if country.attributes['ISO_A2'] == "-99":
    if country.attributes['SOVEREIGNT'] == 'France':
      cc = "FR"
    elif country.attributes['SOVEREIGNT'] == 'Norway':
      cc = "NO"
    elif country.attributes['SOVEREIGNT'] == 'Turkey':
      print(json.dumps(country.attributes,indent=2))
  else:
    cc = country.attributes['ISO_A2']

  # While looping through all countries, IF the current country has
  # data to be mapped, in this case I kept a list of which country
  # codes had both premium and standard data available, then determine
  # the color to use based on the data.
  if cc in overlappingCC_euc:
	# We know the country is in the overlap, so find the country's
	# data.  Could probably have done this as a dict, but it is an
	# artifact of how I used the same data for other calculations
    for c in rtt_dif_country_stan_eu_cent_fra_P50.data:
      if c['cc'] == cc:
        break


	# N/2 sets the value to '0', then the diff determines where on the
	# color bar the country falls
    color = RdGyGn(int((N/2) + c['diff']))

    # I used hatches earlier so that black and white printing would
    # also be easy to detect differences, so it is here for posterity
    hatch=''
    #if c['diff'] <= -50:
    #    hatch='////'
    #elif c['diff'] <= -25:
    #    hatch='///'
    #elif c['diff'] <= -10:
    #    hatch='//'
    #elif c['diff'] <= 10:
    #    hatch='-'
    #elif c['diff'] <= 25:
    #    '\\\\'
    #elif c['diff'] <= 50:
    #    hatch='\\\\\\'
    #else:
    #    hatch='\\\\\\\\'

    ax.add_geometries(country.geometry, ccrs.PlateCarree(),
                          color=color, facecolor=color,
                          label=cc, alpha = .75, hatch='')
    


# Add the datacenter location to the map
ax.scatter(8.601107, 50.127793,
           color="k", s=50, alpha = 1, transform=ccrs.Geodetic(), zorder=150)

# Manually set the colorbar ticks, otherwise the auto detect/populate
# messes things up
plt.colorbar(colorbarMappable, pad=.01, ticks=[-40, -30, -20, -10, 0, 10, 20, 30, 40])

# I saved to pdf so it renders better
plt.savefig('difference-by-country-EU-West-Map-AWS.pdf', bbox_inches='tight')
