//
//  GymEvent.swift
//  GymnasticsAppNew
//
//  Created by Kayla Runkel on 10/6/21.
//

import Foundation
import RealmSwift

struct globalVariables {
    
    var gymnast: Gymnast = Gymnast()
    var userRealm: Realm? = nil

}

var globals = globalVariables()

/*
@objcMembers class GymEvent: Object, ObjectKeyIdentifiable {
    dynamic var _id = ObjectId.generate()
    dynamic var author = ""
    dynamic var event = "" //partition key
    dynamic var vaultScore = ""
    dynamic var barsScore = ""
    dynamic var beamScore = ""
    dynamic var floorScore = ""
    dynamic var timeStamp = Date() //date event was created
    //@embedded...
    dynamic var events = List<String>()
    
    //class called Gymnast with gymnast name, age, etc.
    //Gymnasts will have an events = List<GymEvent>
    
    //class called GymEvent with scores
    
    convenience init(username: String, event: String, vaultScore: String, barsScore: String, beamScore: String, floorScore: String, events: List<String>) {
        self.init()
        self.author = username
        self.event = event
        self.vaultScore = vaultScore
        self.barsScore = barsScore
        self.beamScore = beamScore
        self.floorScore = floorScore
        self.events = events
    }
    
    override static func primaryKey() -> String? {
        return "_id"
    }
    
    //need to make it so that the events array is ignored and does not get sent to realm because realm does not accept arrays
    //@objc override open class func ignoredProperties() -> [String] { return ["events"] }
    
}*/

@objcMembers class Gymnast: Object, ObjectKeyIdentifiable {
    @Persisted(primaryKey: true) var _id = ObjectId.generate()
    @Persisted var author = "" //name of the gymnast
    
    //@Persisted var competition: Competition?
    @Persisted var competitions: List<Competition>
    
    convenience init(author: String) {
        self.init()
        self.author = author
        self.competitions = List<Competition>()
        //self.competitions.append(objectsIn: competitions)
    }
}

@objcMembers class Competition: EmbeddedObject {
    @Persisted var event: String? //name of competition
    @Persisted var vaultScore: Float? = 0
    @Persisted var barsScore: Float? = 0
    @Persisted var beamScore: Float? = 0
    @Persisted var floorScore: Float? = 0
    
    convenience init(event: String) {
        self.init()
        self.event = event
    }
}

func createGymnast(author: String, userRealm: Realm) {
    
    globals.userRealm = userRealm
    
    var gymnasts: Results<Gymnast>
    var gymnast: Gymnast
    
    //let gymnnasts: Results<Gymnast>
    gymnasts = userRealm.objects(Gymnast.self).where {
        $0.author == author
    } //give me all of the gymnasts that are in atlas that have the author name of the person that just logged in (should be one user)
    
    print("========================================================================================")
    print(gymnasts.count)
    
    //new
    
    //if there is no gymnast with the name of the user that just logged in, create a new gymnast for the new user
    if gymnasts.count == 0 {
        gymnast = Gymnast(author: author)
        
        try! userRealm.write {
            userRealm.add(gymnast)
        }
        print("user not found. creating gymnast: \(author)")
    }
    else {
        gymnast = gymnasts[0]
        print("found gymnast \(author) in realm")
    }
    
    globals.gymnast = gymnast
    
}

func buildEventNameArray() -> Array<String> {
    var eventsArray: Array<String> = []
    
    /*ForEach(0..<globals.gymnast.competitions.count) { index in
        eventsArray.append(globals.gymnast.competitions[index].event)
    }*/
    for competition in globals.gymnast.competitions {
        eventsArray.append(competition.event!)
    }
    print(eventsArray.count)
    return eventsArray
}

func getCompetition(event: String) -> Competition? {
    for competition in globals.gymnast.competitions {
        if competition.event == event {
            return competition
        }
    }
    return nil
}


