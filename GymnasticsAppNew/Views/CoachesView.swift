//
//  CoachesView.swift
//  GymnasticsAppNew
//
//  Created by Kayla Runkel on 2/1/22.
//

import SwiftUI
import RealmSwift

struct CoachesView: View {
    
    @Binding var username: String
    
    @State private var email = ""
    @State private var password = ""
    @State private var newUser = false
    @State private var teamCode = ""
    
    var body: some View {
        VStack(spacing: 16) {
            TextField("email address", text: $email)
            SecureField("password", text: $password) //makes it so you can't see what is typed
            Button(action: {newUser.toggle() }) {
                HStack {
                    Image(systemName: newUser ? "checkmark.square" : "square")
                    Text("Register as new coach")
                    Spacer()
                }
            }
            
            if newUser {
                TextField("team code", text: $teamCode)
            }
            
            Button(action: userAction) {
                Text(newUser ? "Register as new coach" : "Log in")
            }
        }
        .navigationBarTitle("Coach Log In", displayMode: .inline)
        .padding()
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

    private func login() {
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
                createCoach(coachName: username, userRealm: userRealm)
            }
            
            }
        }
    }
    
}

