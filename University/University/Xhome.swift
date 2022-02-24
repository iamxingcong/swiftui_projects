//
//  Xhome.swift
//  University
//
//  Created by r on 2021/12/23.
//

import SwiftUI


struct Wdlist: Codable {

    
    var imgurl : String? = nil
    var info: Info
    
    struct Info: Codable {

        var name: String
        var date: String
         
    }

}
struct Xhome: View {
    
    @State   var dts : Wdlist!

    @State var oss: Bool = false
  

    var body: some View {
        
        VStack(){
            
            if(self.oss == true){
                VStack(alignment: .leading){
                    Text(dts?.info.name ?? "")
                    Text(dts?.imgurl ?? "")
                    Text(dts?.info.date ?? "")
                }
                .padding(5.0)
                .cornerRadius(5.0)
               
                
                RemoteImage(url:  dts?.imgurl ?? "")
               

                .aspectRatio(contentMode: .fit)

               
            }else{
                Text("LOADING")
                ProgressView()

            }
            Spacer()
                                 
            Button("Refresh", action: que)
 
        }
        
        .onAppear(perform: que)
      
        
    }
}
 



extension Xhome{

     
    func que(){

        self.oss = false

        let surl = URL(string: "https://api.vvhan.com/api/bing?type=json")!

               let request = URLRequest(url: surl)

               let dTask = URLSession.shared.dataTask(with: request as URLRequest, completionHandler: {  data, response, error  in

                   if (error != nil) {

                       print(error!)

                   } else {

                       if(data != nil){

                           do{

                            let xt = try  JSONDecoder().decode(Wdlist.self, from: data!)

                                print(xt)

                               DispatchQueue.main.async{

                                self.dts = xt
                               
                               }
                                self.oss = true
                           } catch let exception {

                               print(exception)

                           }

                       } else {

                           print("no data get from json api")
                       }
                 }
 
               })

               dTask.resume()
    }

}

