//
//  AddEventAlert.swift
//  GymnasticsAppNew
//
//  Created by Kayla Runkel on 11/3/21.
//

import SwiftUI

struct AddEventAlert: View {
    
    let screenSize = UIScreen.main.bounds
    
    var title: String = ""
    @Binding var isShown: Bool
    @Binding var text: String
    var onDone: (String) -> Void = { _ in } //closure function called when you press done
    var onCancel: () -> Void = { }

    
    var body: some View {
        VStack {
            Text(title)
            TextField("", text: $text)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            
            HStack {
                Button("Done") {
                    self.isShown = false
                    self.onDone(self.text)
                }
                
                Button("Cancel") {
                    self.isShown = false //since isShown is binding, it will automatically change for isPresented
                    self.onCancel()
                }
            }
            
        } .padding()
            .frame(width: screenSize.width * 0.7, height: screenSize.height * 0.3)
            .background(Color(.lightGray))
            .clipShape(RoundedRectangle(cornerRadius: 20.0, style: .continuous))
            .offset(y: isShown ? 0 : screenSize.height)
            .animation(.spring())
            .shadow(color: Color(.lightGray), radius: 6, x: -9, y: -9)
    }
}

struct AddEventAlert_Previews: PreviewProvider {
    static var previews: some View {
        AddEventAlert(isShown: .constant(true), text: .constant(""))
    }
}
