//
//  CoachSeeGymnasts.swift
//  GymnasticsAppNew
//
//  Created by Kayla Runkel on 2/3/22.
//

import SwiftUI
import RealmSwift


struct CoachSeeGymnasts: View {
    
    let teamCode: String
    private var gymnastArray: Array<String> = []
    let userRealm: Realm
    
    init(teamCode: String, userRealm: Realm) {
        self.teamCode = teamCode
        self.userRealm = userRealm
        self.gymnastArray = gatherGymnasts(userRealm: globals.userRealm!, teamCode: teamCode)
    }
    
    //@State private var gymnastArray = gatherGymnasts(userRealm: globals.userRealm!, teamCode: teamCode)

    
    var body: some View {
        ZStack {
            VStack {
                Text("hello")
                /*ForEach(gymnastArray, id: \.self) { gymnast in
                    Text(gymnast)
                    
                }*/
                List {
                    ForEach(gymnastArray, id: \.self) { gymnast in
                        NavigationLink(destination: GymnastInformation(gymnast: gymnast) //pass in gymnast
                                        .environment(\.realmConfiguration, app.currentUser!.configuration(partitionValue: gymnast))
                        ) {
                            Text(gymnast)
                        }
                    }
                    

                }
            }
        }
    }
}

