//
//  GymnastScores.swift
//  GymnasticsAppNew
//
//  Created by Kayla Runkel on 4/19/22.
//

import SwiftUI

struct GymnastScores: View {
    
    let gymnast: String
    let event: String
    
    var body: some View {
        ZStack {
            VStack{
                
                Text("Vault: \((getCompetition(event: event)?.vaultScore)!)")
                Text("Bars: \((getCompetition(event: event)?.barsScore)!)")
                Text("Beam: \((getCompetition(event: event)?.beamScore)!)")
                Text("Floor: \((getCompetition(event: event)?.floorScore)!)")
                
            }
        }
    }
}

