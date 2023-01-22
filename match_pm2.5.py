import os
import pandas as pd

output = "data/pm2.5/"
def main():
	stations = pd.read_csv("pm2.5_stations.csv")
	pm = pd.read_csv("data/pm2.5/hourly_88101_2021.csv")
	for i, (lat, lon) in enumerate(zip(stations['Latitude'], stations['Longitude'])):
		stationId = stations["AQS_Site_ID"][i]
		if (os.path.isfile(inp)):
			os.rename(inp, out)
if __name__ == "__main__":
	main()