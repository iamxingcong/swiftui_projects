//
//  Questions.swift
//  Menu0616
//
//  Created by r on 2021/6/22.
//

import SwiftUI
struct Que: Decodable {
    var results: [Results]
    struct Results: Decodable {
        var category: String
        var question: String
        var correct_answer: String
        var incorrect_answers: [String] = [String]()
        

    }
    
}

struct Questions: View {
    @State private var xdts = [Que.Results]()
    var body: some View {
        
            VStack(alignment: .leading){
             
                List(xdts, id: \.question){  model in
                    VStack(alignment: .leading){
                        VStack(alignment: .leading){
                            Text(model.question)
                                .padding(.bottom, 10)
                        }
                        Spacer()
                        HStack(alignment: .top){
                            Text(model.correct_answer)
                                .font(.callout).foregroundColor(.red)
                                .padding(.bottom, 5)
                        }
                            
                        ForEach(model.incorrect_answers, id: \.self) { user in
                            HStack(alignment: .top){
                                Text(user)
                                    .font(.callout).foregroundColor(.purple)
                                    .padding(.bottom, 5)
                            
                            }
                        }
                    }
                }
            
            .onAppear(perform: que)
             
        }
        
        
    }
}

extension Questions{
    func que(){
        let headers = ["authority": "opentdb.com"]

        let request = NSMutableURLRequest(url: NSURL(string: "https://opentdb.com/api.php?amount=20")! as URL,
                                          cachePolicy: .useProtocolCachePolicy,timeoutInterval: 10.0)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers

        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
            if (error != nil) {
                print(error!)
            } else {
                if(data != nil){
                    do{
                        let xt = try  JSONDecoder().decode(Que.self, from: data!)
                        DispatchQueue.main.async{
                            print(xt)
                            self.xdts = xt.results
                        }
                    } catch let exception {
                        print(exception)
                    }
                } else {
                    print("no data get from json api")
                }
            }
            
        })
        dataTask.resume()
    }
}
