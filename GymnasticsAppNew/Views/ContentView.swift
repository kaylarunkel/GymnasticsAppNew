//
//  ContentView.swift
//  GymnasticsAppNew
//
//  Created by Kayla Runkel on 10/4/21.
//

import SwiftUI
import RealmSwift


struct ContentView: View {
    
    @State private var username = ""
    
    //@State var thisEvents = ["Starstruck Invitational", "Winter Classic", "Xcel States 2021"]
/*
    //variables for alert
    @State var isPresented: Bool = false
    @State var text: String
 */
    //need to define initializer b/c the private variables causes a private access level
   /* fileprivate init (isPresent: Bool, text: String) {
        self.isPresented = isPresented
        self.text = text
    }*/
    
    //@State var events = ["Starstruck Invitational", "Winter Classic", "Xcel States 2021"]

    
    var body: some View {
        NavigationView {
            Group {
                /*if app.currentUser == nil {
                    LoginView(username: $username) //if no one is logged in, go to login screen
                }
                else {
                    EventsView(username: username, text: "") //when logged in, go to list of all events
                        .padding()
                }*/
                LoginView(username: $username)
            }
            .navigationBarTitle(username, displayMode: .inline)
            .navigationBarItems(trailing: app.currentUser != nil ? Button(action: logout) { Text("Logout") } : nil)
            /*.navigationBarItems(trailing: Button("Add Event") {
                self.isPresented = true
            }
            )*/

            /*
            //create alert
            AddEventAlert(title: "Add Event", isShown: $isPresented, text: $text, onDone: { text in
                
            })*/
           
        }
    }
    
/*        ZStack{
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
    
    private func logout() {
        app.currentUser?.logOut() { _ in
            DispatchQueue.main.async {
                username = "" //change username to nothing
            }
        }
        //LoginView(username: $username) //go to login screen
    }
}
    
    
    /*private func addEvent() { //when add button item is pressed, have pop up open to ask for event name
        
    }*/


/*struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}*/
