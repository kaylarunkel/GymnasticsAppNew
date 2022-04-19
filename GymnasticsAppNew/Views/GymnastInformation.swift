//
//  GymnastInformation.swift
//  GymnasticsAppNew
//
//  Created by Kayla Runkel on 2/8/22.
//

import SwiftUI
import RealmSwift

struct GymnastInformation: View {
    
    let gymnast: String
    @State private var events = buildEventNameArray()
    
    var body: some View {
        ZStack {
            VStack {
                List {
                    ForEach(events, id: \.self) { event in
                        NavigationLink(destination: GymnastScores(gymnast: gymnast, event: event)
                                        .environment(\.realmConfiguration, app.currentUser!.configuration(partitionValue: event))
                        ) {
                            Text(event)
                        }
                    }
                }
            }
        }
    }
}




//find gymnast in realm
//show competitions linked to gymnast
