//
//  Hm.swift
//  Ap1227
//
//  Created by r on 2021/12/27.
//

import SwiftUI

struct Lis: Decodable {
    var res: [Res]
    
    struct Res: Decodable {
        var name: String
        var date: String
    }
}

struct Hm: View {
    
    @State private var xdts = [Lis.Res]()


    var body: some View {
        
        VStack(){

                    
               Text("美国节日")
            
                
                List(xdts, id: \.name){  model in
                    
                    Text(model.name)
                    Text(model.date)
                    
                }
            
        }
        .onAppear(perform: que)
    }
}

 

extension Hm{



     

    func que(){

        
        let headers = [
            "x-rapidapi-host": "public-holiday.p.rapidapi.com",
            "x-rapidapi-key": "dd76a2b16cmsh549b91253113b8fp1d6e8cjsn67a86289538d"
        ]

        let ur: String = "https://public-holiday.p.rapidapi.com/2022/US"
        
        let request = NSMutableURLRequest(url: NSURL(string: ur)! as URL,
                                                cachePolicy: .useProtocolCachePolicy,
                                            timeoutInterval: 10.0)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers

        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
            if (error != nil) {
                print(error.debugDescription)
            } else {
                //                let httpResponse = response as? HTTPURLResponse
                //                print(httpResponse?.description ?? "")
                                
                if(data != nil){
                    
                    do{

                        let xt = try  JSONDecoder().decode([Lis.Res].self, from: data!)

                        DispatchQueue.main.async{
                            self.xdts = xt
                        }

                    } catch let exception {

                        print(exception)

                    }
                }
            }
        })

        dataTask.resume()
        
    }
}
