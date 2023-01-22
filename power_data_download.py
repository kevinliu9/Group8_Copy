import requests
import pandas as pd
import urllib.parse
import time
from urllib import request

BASE_URL = "https://power.larc.nasa.gov/api/temporal/hourly/point?"
output = "data/power/"
def main():
	stations = pd.read_csv("data/pm2.5/stations.csv")
	input_data = {
	'parameters': 'AOD_55,ALLSKY_KT,ALLSKY_SFC_LW_DWN,ALLSKY_SFC_SW_DWN,ALLSKY_SFC_UV_INDEX,CLRSKY_KT,CLRSKY_SFC_LW_DWN,CLRSKY_SFC_SW_DWN,GLOBAL_ILLUMINANCE,QV2M,T2M,WD2M,WS2M,PRECTOTCORR',
	'start': 20210101,
	'end': 20211231,
	'Time': 'UTC',
	'community': 'RE',
	'format': 'CSV'}

	for lat, lon in zip(stations['Latitude'], stations['Longitude']):
		input_data['latitude'] = lat
		input_data['longitude'] = lon
		print(f'Making request for latitude {lat} and longitude {lon}...')
		url = BASE_URL + urllib.parse.urlencode(input_data, safe=',')
		data = request.urlretrieve(url, output + str(lat) + str(lon) + ".csv")
if __name__ == "__main__":
	main()


#https://power.larc.nasa.gov/api/temporal/hourly/point?Time=LST&parameters=AOD_55,ALLSKY_KT,ALLSKY_SFC_LW_DWN,ALLSKY_SFC_SW_DWN,ALLSKY_SFC_UV_INDEX,CLRSKY_KT,CLRSKY_SFC_LW_DWN,CLRSKY_SFC_SW_DWN,GLOBAL_ILLUMINANCE,QV2M,T2M,WD2M,WS2M,PRECTOTCORR&community=RE&longitude=-85.9926&latitude=33.9915&start=20210101&end=20211231&format=CSV
