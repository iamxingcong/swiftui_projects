//
//  Word.swift
//  WpChurch
//
//  Created by r on 2021/12/22.
//

import SwiftUI

struct Wdlist: Decodable {
    
    var res: Res
    
    struct Res: Decodable {
        var canonical_url: String
        var jetpack_featured_media_url: String
        var title: Title
        struct Title: Decodable {
                var rendered: String
            }
    }
}
struct Word: View {
    
    @State private var xdts = [Wdlist.Res]()
    @State var oss: Bool = false



    var body: some View {
        
        
        VStack(){
            
            
            if( !oss == true ){

                Text("LOADING")

                ProgressView()



            }else{


                List(xdts, id: \.canonical_url){  model in
                    
                    
                  
                    VStack(alignment: .leading){
                       
                        Text(model.title.rendered)
                        Spacer()
                        
                        Link(model.canonical_url, destination: URL(string: model.canonical_url)!)
                            .font(.system(size: 14.0))
                        Spacer()
                        
                        RemoteImage(url: model.jetpack_featured_media_url)
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 190)
                      
                        Spacer()
                       
                    }
                }
            }
        }
        .onAppear(perform: que)
    }
}

 
extension Word{
    
    
    func que(){
        self.oss = false
        
        let surl = URL(string: "https://techcrunch.com/wp-json/wp/v2/posts?per_page=10")!

          
               

               let request = URLRequest(url: surl)

               let dTask = URLSession.shared.dataTask(with: request as URLRequest, completionHandler: {  data, response, error  in



                   if (error != nil) {

                       print(error!)

                   } else {



                       if(data != nil){
                       


                           do{

                            let xt = try  JSONDecoder().decode([Wdlist.Res].self, from: data!)

                               
                            print(xt.description)
                               DispatchQueue.main.async{

                                self.xdts = xt
                                
                                 
                                self.oss = true
                               }
                                
                               

                             

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
