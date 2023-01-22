import os
import pandas as pd

output = "data/power/"
def main():
	stations = pd.read_csv("pm2.5_stations.csv")

	for i, (lat, lon) in enumerate(zip(stations['Latitude'], stations['Longitude'])):
		inp = output + str(lat) + str(lon) + ".csv"
		out = output + str(stations["AQS_Site_ID"][i]) + ".csv"
		if (os.path.isfile(inp)):
			os.rename(inp, out)
if __name__ == "__main__":
	main()