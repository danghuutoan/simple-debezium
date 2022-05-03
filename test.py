from cachetools import cached, TTLCache
import time

from numpy import place



# cache weather data for no longer than ten minutes
@cached(cache=TTLCache(maxsize=10, ttl=600))
def get_weather(place):
    print("#############")
    if place.endswith(".keyword"): 
        return place[:-len(".keyword")]
    return place



if __name__ == '__main__':
    n = 0
    while True:
        n = (n + 1)
        if n > 10:
            n = 0

        place = f'{n}.keyword'
        for i in range(10):
            print(get_weather(place=place))
        
