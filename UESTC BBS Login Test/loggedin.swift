//
//  loggedin.swift
//  UESTC BBS Login Test
//
//  Created by Ethan Yi on 11/11/22.
//

import SwiftUI
struct loggedin: View{
    @State private var out = false
    @State private var exit:String = "Fuckoff"
    var body: some View {
        ZStack{
            Circle()
                .scale(0.808)
                .foregroundColor(.blue.opacity(0.39))
            Circle()
                .scale(1.0)
                .foregroundColor(.cyan.opacity(0.6))
            VStack{
                Text("Successfully logged in")
                    .font(.title)
                    .bold()
                    .monospacedDigit()
                Button("Log out") {logout(exit:exit)}
                    .foregroundColor(.white)
                    .frame(width: 150)
                    .frame(height: 40)
                    .background(.red)
                    .cornerRadius(40)
                NavigationLink(destination: ContentView(), isActive: $out){
                    EmptyView()
                }
            }
        }
    }
    func logout(exit:String){
        if exit == "Fuckoff"{
            out = true
        }
    }
}
    

