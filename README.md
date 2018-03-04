# WeatherDriving
### This is an IOS project made in Pelmoex Hachthon.
Main idea of this app is to combine **crowdsource data, weather data and car data** together to better calculate road condition.

## CrowdSource Data
Crowdsource data is reported by users.

## Weather data
Weather data is collected from The Weather Network API.

## Car data
Car data can be collected from specific vehicle through API calls.
Due to demo purposes, we made a mock Josn file to simulate car data.

<img src="https://github.com/zuoweifu/WeatherDriving/blob/master/imgs/Screen%20Shot%202018-03-04%20at%201.38.14%20AM.png" width="300" />

## How it works?
* App pull vehicle sensor data every 5 minutes.
* Use the lat long data provided by the car to get the Geocode of the car through pel-search API. 
* Then use the geocode to get the weather data of the car. 
* Now we have the weather data and car sensor data. These data then being used to calculate the possibility of low visibility event and sleepery road condition event through algorithms. 
* If the possibility is over 60% percent, the event will be posted to our database, and finally those events will be displayed on the map as pins.

## How i combine these data?
Take Low visibility event for example
```Swift
    static func VisibilityWeight (car: CarData, obs:Observation) -> Double {
        
        var weight = 0.0
        
        //condition weights 30% in total
        if( obs.condition == "snow"){
            weight+=10
        }else if( obs.condition == "fog"){
            weight+=30
        }else if ( obs.condition == "rain"){
            weight+=20
        }
        
        //wiper weights 40% in total
        if(car.wiper == "on" ){
            weight+=20
            if(car.wiperfreq > 79 ){
                weight+=20
            }else if(car.wiperfreq > 59 ){
                weight+=10
            }else if(car.wiperfreq > 39 ){
                weight+=5
            }
        }
        
        //headlights weight 30% in total
        if(car.headlampstatus == "twilight4"){
            weight+=30
        }else if(car.headlampstatus == "twilight3"){
            weight+=25
        }else if (car.headlampstatus == "twilight2"){
            weight+=20
        }else if(car.headlampstatus == "twilight1"){
            weight+=15
        }else if(car.headlampstatus == "day"){
            weight+=10
        }
    
        return weight
    }
```

## Preview

<img src="https://github.com/zuoweifu/WeatherDriving/blob/master/imgs/Simulator%20Screen%20Shot%20-%20iPhone%20X%20-%202018-03-04%20at%2001.20.49.png" width="300" />

## Future implementation
* Adapt the app to infotainment system
* Add follow me feature, send notification when user is within certain distance to an event. 
