//
//  LoginManager.swift
//  Testing
//
//  Created by Nandhitha Raghuram on 12/2/20.
//

import Foundation
import Combine

struct ServerMessage: Decodable{
    let token: String
}

class LoginManager: ObservableObject {
    
    @Published var authenticated = false
	var model = TestWC()
	var messageText = "True"
    
    func checkDetails(username: String, password: String) {
        guard let url = URL(string: "http://192.168.0.152:8000/auth/") else { return }
        let body: [String:String] = [
            "username": username,
            "password": password
        ]
        let finalBody = try! JSONSerialization.data(withJSONObject: body)
        var request = URLRequest(url:url)
        request.httpMethod = "POST"
        request.httpBody = finalBody
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        URLSession.shared.dataTask(with: request){ (data,response,error) in
            guard let data = data else { return }
            do {
                let finalData = try JSONDecoder().decode(ServerMessage.self, from: data) //need to handle when wrong password is entered
                if !finalData.token.isEmpty {
                    try WatchConnectivityManager.sharedManager.updateApplicationContext(applicationContext: ["userToken" : finalData.token, "isLoggedIn": true ])
                    DispatchQueue.main.async {
                        UserDefaults.standard.set(true, forKey: "ISUSERLOGGEDIN")
                        UserDefaults.standard.set(finalData.token, forKey: "USERTOKEN")
						let obj = UserStateManager()
						print(obj.isUserLoggedIn)
                        print("User logged in")
						WatchConnectivityManager.sharedManager.sendMessage(message: ["message" : self.messageText], replyHandler: nil) { (error) in
							print(error.localizedDescription)
						}
						WatchConnectivityManager.sharedManager.sendMessage(message: ["token" : finalData.token], replyHandler: nil) { (error) in
							print(error.localizedDescription)
						}
						self.authenticated = true
                    }
                }
            } catch {
                print("Error in logging in \(error.localizedDescription)")
                DispatchQueue.main.async {
                    self.authenticated = false
                }
            }
        }.resume()
    }
    
    func logout() {
        UserDefaults.standard.set(false, forKey: "ISUSERLOGGEDIN")
        do {
            try WatchConnectivityManager.sharedManager.updateApplicationContext(applicationContext: [ "isLoggedIn": false ])
        } catch {
            print("Couldnt send logout message to watch: \(error.localizedDescription)")
        }
//        WatchConnectivityManager.sharedManager.sendMessage(message: [
//                                                            "userToken" : "",
//                                                            "isLoggedIn": false], replyHandler: nil)
        
        DispatchQueue.main.async {
            self.authenticated = false
        }
    }
}
