//
//  ContentView.swift
//  UESTC BBS Login Test
//
//  Created by Ethan Yi on 11/11/22.
//

import SwiftUI

import SwiftUI

struct ContentView: View {
    @State private var username:String = ""
    @State private var password:String = ""
    @State private var show = false
    @State private var wrongUsername = 0
    @State private var wrongPassword = 0
    
    
    
    
    
    var body: some View {
        NavigationView{
            ZStack {
                VStack{
                    Text("Login Test")
                        .font(.largeTitle)
                        .bold()
                        .padding()
                    TextField("Username", text: $username)
                        .textContentType(.emailAddress)
                        .disableAutocorrection(true)
                        .accentColor(Color.blue)
                        .border(Color.gray)
                        .padding()
                        .textFieldStyle(myTextFieldStyle())
                        .textFieldStyle(UnderlineTextFieldStyle())
                        .textFieldStyle(TextFieldCleanButtonStyle(text: $username))
                    SecureField("Password", text: $password)
                        .textContentType(.password)
                        .keyboardType(.alphabet)
                        .autocapitalization(.none)
                        .disableAutocorrection(true)
                        .accentColor(Color.red)
                        .border(Color.gray)
                        .padding()
                        .textFieldStyle(myTextFieldStyle())
                        .textFieldStyle(UnderlineTextFieldStyle())
                        .textFieldStyle(TextFieldCleanButtonStyle(text: $password))
                    Button("Login"){
                        login(username: username, password: password)
                    }
                    .padding()
                    .foregroundColor(.white)
                    .frame(width: 150)
                    .frame(height: 40)
                    .background(Color.blue)
                    .cornerRadius(30)
                    
                    NavigationLink(destination:loggedin(), isActive: $show){
                        EmptyView()
                    }
                }
                .navigationBarHidden(true)
            }
        }
    }
    
    func login(username:String,password:String) {
        let urlString = "https://bbs.uestc.edu.cn/mobcent/app/web/index.php?r=user/login" + "&username=" + username + "&password=" + password
        
        let url:URL = URL(string: urlString)!
        
        let session = URLSession.shared
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let task = session.dataTask(with: request as URLRequest) {(
            data, response, error) in
            guard let data = data, let _:URLResponse = response, error == nil else {
                print("error")
                return
            }
            let dataString =  String(data: data, encoding: String.Encoding.utf8)
            let dict = getDictionaryFromJSONString(jsonString: dataString!)
            print(dict)
            let check = dict["rs"]
            if check as! Int == 1 {
                wrongUsername = 0
                wrongPassword = 0
                show = true
            }
    else{
                wrongPassword = 2
                wrongUsername = 2
            }
                }
        task.resume()
    }
    
    func getDictionaryFromJSONString(jsonString:String) ->NSDictionary{
        let jsonData:Data = jsonString.data(using: .utf8)!
        let dict = try? JSONSerialization.jsonObject(with: jsonData, options: .mutableContainers)
        if dict != nil {
            return dict as! NSDictionary
        }
        return NSDictionary()
    }
    
    
    
    
    struct TextFieldCleanButtonStyle: TextFieldStyle{
        @Binding var text: String
        func _body(configuration:TextField<Self._Label>)->some View{
            HStack{
                configuration
                    .padding()
                if !text.isEmpty{
                    Button {
                        self.text = ""
                    } label: {
                        Image(systemName: "minus.circle.fill")
                            .foregroundColor(Color.red)
                    }
                    .padding(.trailing , 10)
                    
                }
            }
        }
    }
    
    struct myTextFieldStyle : TextFieldStyle{
        func _body(configuration:TextField<Self._Label>)->some View{
            HStack{
                Image(systemName: "pencil.circle.fill")
                    .foregroundColor(Color.cyan)
                configuration
                    .padding(.vertical,10)
            }
            .padding(.horizontal,10)
            .background(Color.gray)
            
        }
    }
    
    
    struct UnderlineTextFieldStyle: TextFieldStyle{
        func _body(configuration:TextField<Self._Label>)->some View{
            configuration
                .overlay(
                    Rectangle()
                        .frame(height:1).padding(.top ,35)
                        .cornerRadius(40)
                )
                .foregroundColor(Color.pink)
        }
    }
    
    
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView()
        }
    }
}

