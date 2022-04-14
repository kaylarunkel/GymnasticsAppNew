//
//  LoginView.swift
//  GymnasticsAppNew
//
//  Created by Kayla Runkel on 10/6/21.
//

import SwiftUI
import RealmSwift

struct LoginView: View {
    
    
    @Binding var username: String
    
    @State private var email = ""
    @State private var password = ""
    @State var newUser = false //stopped here w/ video at 34:22
    @State var teamCode = ""
    @State var areYouCoach = false
    
    /*let userRealm: Realm
    init(userRealmConfiguration: Realm.Configuration) {
        self.userRealm = try! Realm(configuration: userRealmConfiguration)
        //self.username = ""
        super.init(nibName: nil, bundle: nil)
    }*/
    
    var body: some View {
        VStack(spacing: 20) {
            Spacer(minLength: 30)
            Text("Login")
                .font(.title)
                .bold()
                .frame(maxWidth: .infinity, alignment: .leading)
            Text("Sign in here to continue.")
                //.font(.caption)
                .frame(maxWidth: .infinity, alignment: .leading)
            TextField("email address", text: $email)
                //.frame(maxWidth: .infinity, alignment: .center)
                //.multilineTextAlignment(.center)
                .padding()
                .background(Color.gray).opacity(0.6)
                .cornerRadius(5.0)
                .padding(.bottom, 20)
            SecureField("password", text: $password) //makes it so you can't see what is typed
                //.frame(maxWidth: .infinity, alignment: .center)
                //.multilineTextAlignment(.center)
                .padding()
                .background(Color.gray).opacity(0.6)
                .cornerRadius(5.0)
                .padding(.bottom, 20)
            
            if newUser {
                TextField("team code", text: $teamCode)
                    .padding()
                    .background(Color.gray).opacity(0.6)
                    .cornerRadius(5.0)
                    .padding(.bottom, 20)
            }
            
            Button(action: {newUser.toggle() }) {
                HStack {
                    Image(systemName: newUser ? "checkmark.square" : "square")
                    Text("Register as new gymnast")
                    Spacer()
                }
            }
            .foregroundColor(Color.black)
            
            /*Button(action: {areYouCoach.toggle() }) {
                HStack {
                    Image(systemName: areYouCoach ? "checkmark.square" : "square")
                    Text("Register as new coach")
                    Spacer()
                }
            }*/

            /*Button(action: userAction) {
                Text(newUser ? "Register as new gymnast" : "Log in")
                NavigationLink(destination: EventsView)
            }*/
           /* Button(action: self.userAction) { //error: userAction isn't getting run
                NavigationLink(destination: EventsView(username: username, text: "")) {
                    Text(newUser ? "Register as new gymnast" : "Log in")
                }
            }*/
            
            /*if newUser {
                TextField("team code", text: $teamCode)
                    .padding()
                    .background(Color.gray).opacity(0.6)
                    .cornerRadius(5.0)
                    .padding(.bottom, 20)
            }*/
            
            
            Button(action: userAction) {
                    Text(newUser ? "Register as new gymnast" : "Log in as gymnast")
                Spacer()
            }
            .font(.headline)
            .foregroundColor(Color.black)
            .padding()
            .frame(width: 280, height: 60)
            .background(Color.pink).opacity(0.6)
            .cornerRadius(15.0)
            
            //.brightness(40)
            /*Button(action: userAction) {
                Text(areYouCoach ? "Register as new coach" : "Log in as coach")
            }*/
            
           
            /*NavigationLink(destination: EventsView(username: username, text: "")) {
                Text("Continue")
            }*/
            /*Button(action: createCoach(coachName: email, userRealm: globals.userRealm!, teamCode: teamCode)) {
                Text("I Am A Coach")
            }*/
            
            /*Button(action: areYouCoachFunc) {
                HStack {
                    Image(systemName: areYouCoach ? "checkmark.square" : "square")
                    Text("I Am A Coach")
                }
            }
            .foregroundColor(Color.black)
            .frame(maxHeight: .infinity, alignment: .bottom)*/
            
            NavigationLink(destination: CoachesView(username: $email, teamCode: $teamCode)) {
                Text("Continue As Coach")
            }
            .frame(maxHeight: .infinity, alignment: .bottom)
            .foregroundColor(Color.pink)
        }
        .navigationBarTitle("Gymnast Log In", displayMode: .inline)
        .padding()
    }
    
    private func areYouCoachFunc() {
        newUser == true
        userAction()
    }
    
    private func userAction() {
        if newUser {
            signup()
        } else {
            login()
        }
    }
    
    private func signup() {
        app.emailPasswordAuth.registerUser(email: email, password: password) {error in
            if let error = error {
                print("\(error.localizedDescription)")
            } else {
                login()
            }
        }
        
    }
    
    //function when the user clicks to log in
    private func login() {
        //_in says that we are not going to use given callback function
        print("email: \(email)")
        print("password: \(password)")
        app.login(credentials: .emailPassword(email: email, password: password)) { _ in
            DispatchQueue.main.async {
                username = email
            }
        
        
        //let configuration = configuration(partitionValue: "author=\(email)")
        let user = app.currentUser!
        //let partitionValue = "author=\(email)"
        let partitionValue = email
        let config = user.configuration(partitionValue: partitionValue)
        Realm.asyncOpen(configuration: config) { (result) in
            switch result {
            
            case .failure(let error):
                print("failed to open realm: \(error.localizedDescription)")
            
            case .success(let userRealm):
                
                if areYouCoach == true {
                    createCoach(coachName: email, userRealm: userRealm, teamCode: teamCode)
                }
                else {
                    createGymnast(author: email, userRealm: userRealm, teamCode: teamCode)
                }
                
            }
            
            }
        }
        }
        
    }


/*struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView(username: .constant("Billy"))
    }
}*/
