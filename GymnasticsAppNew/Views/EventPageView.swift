//
//  EventPageView.swift
//  GymnasticsAppNew
//
//  Created by Kayla Runkel on 10/14/21.
//

import SwiftUI
import RealmSwift


struct EventPageView: View {
    //use objects fetched from Realm
    //@ObservedResults(GymEvent.self, sortDescriptor: SortDescriptor(keyPath: "timeStamp", ascending: true)) var events //Realm results set with GymEvent objects
    @ObservedResults(Gymnast.self, sortDescriptor: SortDescriptor(keyPath: "timeStamp", ascending: true)) var competitions //Realm results set with GymEvent objects

    //let realm = try! Realm()
    //let realm: Realm
    
    
    let username: String //username parameter passed in
    let event: String //enclosing view passed in the name of the event
    /*let vaultScore: Int
    let barsScore: Int
    let beamScore: Int
    let floorScore: Int*/
    
    
    @State private var vaultScore = ""
    @State private var barsScore = ""
    @State private var beamScore = ""
    @State private var floorScore = ""
    //@State private var competitions = getCompetitions()
    
    private var competition: Competition?
    
    init(username: String, event: String) {
        self.username = username
        self.event = event
        self.competition = getCompetition(event: event)
        self.vaultScore = String((competition?.vaultScore)!)
    }
    
    var body: some View {
        
        VStack {
            ScrollView(.vertical) {
                VStack {
                    HStack {
                        Text("Vault Score: ")
                        TextField("Enter vault score", text: $vaultScore)
                            .padding()
                            .background(Color.gray.opacity(0.3).cornerRadius(10))
                            .font(.headline)
                    }
                    Text("\(vaultScore)")
                    HStack {
                        Text("Bars Score: ")
                        TextField("Enter bars score", text: $barsScore)
                            .padding()
                            .background(Color.gray.opacity(0.3).cornerRadius(10))
                            .font(.headline)
                    }
                    Text("\(barsScore)")
                    HStack {
                        Text("Beam Score: ")
                        TextField("Enter beam score", text: $beamScore)
                            .padding()
                            .background(Color.gray.opacity(0.3).cornerRadius(10))
                            .font(.headline)
                    }
                    Text("\(beamScore)")
                    HStack {
                        Text("Floor Score: ")
                        TextField("Enter floor score", text: $floorScore)
                            .padding()
                            .background(Color.gray.opacity(0.3).cornerRadius(10))
                            .font(.headline)
                    }
                    Text("\(floorScore)")
                }
                
                //self.floorScore = floorScore
                
                /*ForEach (events) { gymEvent in
                    HStack {
                        Text(gymEvent.vaultScore)
                        Text(gymEvent.barsScore)
                        Text(gymEvent.beamScore)
                        Text(gymEvent.floorScore)
                    }
                }*/
                
            }
            Spacer()
            HStack {
                //Button(action: save) { Image(systemName: "paperplane.fill") } //button with save function
                Button(action: save) {
                        Text("Save".uppercased())
                            .padding()
                            .background(Color.blue.cornerRadius(10))
                            .foregroundColor(.white)
                            
                    }
                }
        .navigationBarTitle("\(event)", displayMode: .inline)
        .padding()
        }
    }
    
    //save function to send data to Realm
    private func save() {

        try! globals.userRealm!.write {
            competition!.vaultScore = Float(vaultScore)
            competition!.barsScore = Float(barsScore)
            competition!.beamScore = Float(beamScore)
            competition!.floorScore = Float(floorScore)
        }
    }
    
}

