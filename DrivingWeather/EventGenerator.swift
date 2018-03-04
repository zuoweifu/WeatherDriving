import Foundation

class EventGenerator {
    
    //function to create Visibility Event
    static func hasVisibilityEvent(car: CarData,obs:Observation) -> Event? {

        //get total weight of Visibility
        var weight = 0.0
        weight = VisibilityWeight(car:car, obs:obs)

        var event: Event? = nil
        
        //create Events with different severuty according to the weight
        if(weight >= 60 ){
            
            let formatter = DateFormatter()
            // initially set the format based on your datepicker date
            formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
            let timestamp = formatter.string(from: Date())
            
            event = Event()
            event?.Lat = car.lat
            event?.Long = car.long
            event?.EventType = .Visibility
            event?.Time = timestamp
            event?.Cause = obs.condition
            event?.Notes = "Car generated"
            
            if(weight >= 80){
                event?.Severity = .High
            }else if(weight>=70){
                event?.Severity = .Medium
            }else {
                event?.Severity = .Low
            }
        }
        return event
    }

    //function to create Road Condition Event
    static func hasRoadConditionEvent(car: CarData,obs:Observation) {
        //get total weight of Road condition
        var weight = 0.0
        weight = RoadConditionWeight(car:car, obs:obs)

        //create Events with different severuty according to the weight
        if(weight >= 60 ){
            if(weight >= 80){
                //create high severity Event
            }else if(weight>=70){
                //create medium severity Event
            }else {
                //create low severity Event
            }
            //push to db
        }


    }

    //function to create Extreme Event
    func hasExtremeEvent(car:CarData, obs:Observation)  {

        //implementation for extreme

    }

    
    //function to calculate Visibility weight
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
    
    //function to calculate Road Condition weight
    static func RoadConditionWeight(car: CarData, obs:Observation) -> Double {
        
        var weight = 0.0
        
        //weather condition counts 30%
        if (obs.condition == "snow"){
            weight+=30
        }else if (obs.condition == "rain"){
            weight+=15
        }
        
        //speed counts 15%
        if(car.speed < 30){
            weight+=15
        }else if (car.speed < 40){
            weight+=10
        }else if(car.speed < 50){
            weight+=5
        }
        
        //rpm counts 15%
        if(car.rpm < 500 ){
            weight+=15
        }else if(car.rpm < 600 ){
            weight+=10
        }else if(car.rpm < 700){
            weight+=5
        }
        
        //temp counts 10%
        if(car.externaltemp < -10){
            weight+=10
        }else if (car.externaltemp < -5){
            weight+=5
        }
        
        //tire pressure counts20%
        //the higher the tire pressure is, the worse the road condition is
        if(car.tirepressure > 100 ){
            weight+=20
        }else if (car.tirepressure > 70 ){
            weight+=10
        }else if(car.tirepressure > 60){
            weight+=5
        }
        
        return weight
    }
}

