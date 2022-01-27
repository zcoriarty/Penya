//
//  Chat.swift
//  Penya
//
//  Created by Zachary Coriarty on 1/25/22.
//

import SwiftUI

struct CustomField: ViewModifier {
    func body(content: Content) -> some View {
        return content
            .padding()
            .background(Color(.secondarySystemBackground))
            .cornerRadius(7)
    }
}

struct Chat: View {
//    @Binding var showMenu: Bool

    @State var message: String = ""
    @EnvironmentObject var model: AppStateModel
    let otherUsername: String
    
    init(otherUsername: String) {
        self.otherUsername = otherUsername
    }
    
    var body: some View {
//        VStack {
//            Title(showMenu: $showMenu, topRight: "plus")
//            Spacer()
//        }
//        .padding(.horizontal)
//        .background(Color("BackgroundGray"))
        VStack {
            ScrollView(.vertical) {
                ForEach(model.messages, id: \.self) { message in
                    ChatRow(text: message.text, type: message.type)
                        .padding(3)
                }
                
            }
            
            // send button
            HStack {
                TextField("Message...", text: $message)
                    .modifier(CustomField())
                
                SendButton(text: $message)
            }
            .padding()
        }
        .navigationBarTitle(otherUsername, displayMode: .inline)
        .onAppear {
            model.otherUsername = otherUsername
            model.observeChat()
        }
        
        
        
    }
}

struct Chat_Previews: PreviewProvider {
    static var previews: some View {
        Chat(otherUsername: "Samantha")
            .preferredColorScheme(.dark)
    }
}
