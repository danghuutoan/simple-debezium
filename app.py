from flask import Flask, request
from cachetools import cached, TTLCache
import time
app = Flask(__name__)


# cache weather data for no longer than ten minutes
@cached(cache=TTLCache(maxsize=10, ttl=600))
def get_weather(place):
    print("#############")
    time.sleep(3)
    if place.endswith(".keyword"): 
        return place[:-len(".keyword")]
    return place


@app.route("/")
def hello_world():
    place = request.args.get('place')
    print(place)
    return get_weather(place=place)
