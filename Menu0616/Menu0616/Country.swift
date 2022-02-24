//
//  Country.swift
//  Menu0616
//
//  Created by r on 2021/6/18.
//

import SwiftUI




struct Ck: Codable   {
    var area: Double? = 100
    var name: String
    var nativeName: String
    var region: String
    var capital: String
    var flag: String
    var subregion: String
    var numericCode: String? = nil
    var population: Int? = 50
    
    
}

struct CDRow: View {

    var model: Ck? = nil
   
    
    var body: some View {
        VStack(alignment: .leading ){
          
             
            VStack(alignment: .leading, spacing: 10){
                    HStack(){
                        Text(model?.name ?? "")
                            .font(.callout).foregroundColor(.blue)
                        Text(model?.nativeName ?? "")
                            .font(.callout).foregroundColor(.red)
                        Text(model?.capital ?? "")
                            .font(.callout).foregroundColor(.purple)
                    }
                    HStack(){
                    
                        Text(model?.region ?? "")
                        Text(model?.subregion ?? "")
                    }

                    HStack(){
                        Text("面积：\(model?.area?.description ?? "33")")
                 
                        Text("人口：\(model?.population?.description ?? "33")")
                            .font(.callout).foregroundColor(.purple)
                    }
            }

        }
    }
}


struct Country: View {
 
    @State private var xdts = [Ck]()
    var body: some View {
        
            
                List(xdts, id: \.name){  model in
                   
                   
                        CDRow(model: model)
                    
                }
           
            .onAppear(perform: ata)
             
        
    }
}

 
extension Country {

      func ata() {
        let urlstring = "https://restcountries.eu/rest/v2/all"
            guard let url = URL(string: urlstring) else { return }
            let task =    URLSession.shared.dataTask(with: url) {  (data, response, error) in
                if  data != nil {
                    do{
                        let xt = try  JSONDecoder().decode([Ck].self, from: data!)
                        DispatchQueue.main.async{
                            self.xdts = xt
                        }
                    } catch let exception {
                        print(exception)
                    }
                } else {
                    print("some thing gose wrong")
                }
             }
           task.resume()
    }
}
