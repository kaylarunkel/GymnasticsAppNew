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
    @State private var newUser = false //stopped here w/ video at 34:22
    
    /*let userRealm: Realm
    init(userRealmConfiguration: Realm.Configuration) {
        self.userRealm = try! Realm(configuration: userRealmConfiguration)
        //self.username = ""
        super.init(nibName: nil, bundle: nil)
    }*/
    
    var body: some View {
        VStack(spacing: 16) {
            TextField("email address", text: $email)
            SecureField("password", text: $password) //makes it so you can't see what is typed
            Button(action: {newUser.toggle() }) {
                HStack {
                    Image(systemName: newUser ? "checkmark.square" : "square")
                    Text("Register new user")
                    Spacer()
                }
            }
            Button(action: userAction) {
                Text(newUser ? "Register new user" : "Log in")
            }
        }
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
                createGymnast(author: email, userRealm: userRealm)
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
