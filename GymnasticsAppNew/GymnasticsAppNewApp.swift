//
//  GymnasticsAppNewApp.swift
//  GymnasticsAppNew
//
//  Created by Kayla Runkel on 10/4/21.
//

import SwiftUI
import RealmSwift

let app = RealmSwift.App(id: "gymnasticsapp-danij")

@main
struct GymnasticsAppNewApp: SwiftUI.App {

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
