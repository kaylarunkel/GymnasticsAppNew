//
//  EventsView.swift
//  GymnasticsAppNew
//
//  Created by Kayla Runkel on 10/14/21.
//

import SwiftUI
import RealmSwift

//this view is the view that shows all of the events

struct EventsView: View {
    
    let username: String
    
    //@State var events: Array<String>
    //@Binding var events: Array<String>
    
    //var events = []
    //@State private var events = ["test", "test14te2t4we", "Testing"]
    @State private var events = buildEventNameArray()
    //@State private var competitions = getCompetitions()
    /*let instanceOfGymEvent = GymEvent()
    @State private lazy var competitions = instanceOfGymEvent.competitions*/
    
    //variables for alert
    @State var isPresented: Bool = false
    @State var text: String
    
    //let globalCompetitions = globals.gymnast!.competitions
    
    var body: some View {
        ZStack {
            VStack {
                List { //the events will show up as a list and when you click on a event it will take you to a new screen for that event
                    ForEach(events, id: \.self) { event in
                        NavigationLink(destination: EventPageView(username: username, event: event)
                                        .environment(\.realmConfiguration, app.currentUser!.configuration(partitionValue: event))
                        ) {
                            Text(event)
                        }
                    }
                   /* ForEach(globalCompetitions, id: \.event) { competition in
                        NavigationLink(destination: EventPageView(username: globals.gymnast!.author, event: competition)
                                        .environment(\.realmConfiguration, app.currentUser!.configuration(partitionValue: competition))
                        ) {
                            Text(competition)
                        }
                    }*/
                    /*ForEach(0..<globals.gymnast.competitions.count) { index in
                        NavigationLink(destination: EventPageView(username: globals.gymnast.author, event: globals.gymnast.competitions[index].event!)
                                        .environment(\.realmConfiguration, app.currentUser!.configuration(partitionValue: globals.gymnast.competitions[index].event!))
                        ) {
                            Text(globals.gymnast.competitions[index].event)
                        }
                    }*/
                //}
                
                //NEW
               /* List(viewModel.competitions) { competition in
                    let index = viewModel.competitons.firstIndex(where: { $0.id == competition })!
                    
                    NavigationLink(destination: CompetitionEdit(competiton: $viewModel.competitions[index])) {
                        CompetitionRow(competition: competition)
                    }
                }*/
            
           /* List {
                ForEach(viewModel.competitions, id: \.self) { competition in
                    let index = viewModel.competitons.firstIndex(where: { $0.id == competition })!
                    
                    NavigationLink(destination: CompetitionEdit(competiton: $viewModel.competitions[index])) {
                        CompetitionRow(competition: competition)
                    }
                }*/
            }
                //NEW^^
                
                Button("Add Event") {
                    self.isPresented = true
                }
                //Text(text)
                
                //i need to make it so that a user can't get two events with the same name
                AddEventAlert(title: "Add Event", isShown: $isPresented, text: $text, onDone: { text in
                    //view.events.append(text)
                    //!!! - event gets added but does not stay added when log out and back in
                    //events += ["\(text)"]
                    self.events.append(text)
                    print("added competition name (\(text)) to events array")
                    
                    try! globals.userRealm!.write {
                        
                        var competition: Competition
                        competition = Competition(event: text)
                        
                        globals.gymnast.competitions.append(competition)
                    }
                    print("added competition (\(text)) to realm")
                   
                })
                
            }

        }
    }
}


/*func getCompetitions() -> <#Return Type#> {
    let instanceOfGymEvent = GymEvent()
    return instanceOfGymEvent.competitions
}*/


/*struct EventsView_Previews: PreviewProvider {
    static var previews: some View {
        EventsView(username: "", text: "")
    }
}*/


/*
ZStack{
    VStack {
        Button("Show alert") {
            self.isPresented = true
        }
        Text(text)
    }
    AddEventAlert(title: "Add Event", isShown: $isPresented, text: $text, onDone: { text in
        
    })
}
*/

