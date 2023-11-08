# This Python file uses the following encoding: utf-8
import sys
from pathlib import Path

from PySide6.QtGui import QGuiApplication
from PySide6.QtQml import QQmlApplicationEngine
from PySide6.QtCore import QObject,Slot,Signal
import requests


class Backend(QObject):

    def __init__(self,api_key):
        super().__init__()
        self.api_key = api_key
        self.base_url = "https://api.openweathermap.org/data/2.5/weather"



    weatherData = Signal(list,arguments=['weather'])
    mainData = Signal(list,arguments=['main'])
    windData = Signal(list,arguments=['wind'])
    cloudData = Signal(list,arguments=['cloud'])
    cityData = Signal(str,arguments=['city'])
    countryData = Signal(str,arguments=['country'])
    sunData = Signal(list,arguments=['sun'])

    @Slot(str)
    def update_data(self,city):
        params = {
                   "q": city,
                   "appid": self.api_key,
                   "units": "metric"  # Use Celsius for temperature
               }
        response_data = requests.get(self.base_url,params=params).json()
        weather_data = response_data['weather'][0]
        main_data = response_data['main']
        wind_data = response_data['wind']
        cloud_data = response_data['clouds']

        weather_data_values = list(weather_data.values())
        main_data_values = list(main_data.values())
        wind_data_values = list(wind_data.values())
        cloud_data_values = list(cloud_data.values())
        city_data = response_data['name']
        country_data = response_data['sys']['country']

        sun_data = list()
        sun_data.append(response_data['sys']['sunrise'])
        sun_data.append(response_data['sys']['sunset'])





        self.weatherData.emit(weather_data_values)
        self.mainData.emit(main_data_values)
        self.windData.emit(wind_data_values)
        self.cloudData.emit(cloud_data_values)
        self.cityData.emit(city_data)
        self.countryData.emit(country_data)
        self.sunData.emit(sun_data)





if __name__ == "__main__":

    api_key = '' #Your api key

    app = QGuiApplication(sys.argv)

    backend = Backend(api_key)

    engine = QQmlApplicationEngine()
    engine.rootContext().setContextProperty('backend',backend)

    qml_file = Path(__file__).resolve().parent / "Components/compenent.qml"

    engine.load(qml_file)

    if not engine.rootObjects():
        sys.exit(-1)
    sys.exit(app.exec())
