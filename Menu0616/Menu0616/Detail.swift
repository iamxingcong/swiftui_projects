//
//  Details.swift
//  Menu0616
//
//  Created by r on 2021/6/16.
//


import SwiftUI




struct Res: Decodable{
    var type: String
    var properties: Properties
    struct Properties: Decodable  {
        var place: String
        var title: String
        var type: String
        var alert: String? = "no data"
        var url: String
        var time: Double
       
        
    }
}

struct Detail: View {

    var item: QuakeAPIList.Features? = nil
    @State private var dts: Res? = nil
 
    

    var body: some View {
        ScrollView(.vertical) {
            VStack(
                alignment: .leading,
                spacing: 15
                 
            ){
                VStack(alignment: .leading, spacing: 20){
                    Text("传值而来")
                        .padding(.horizontal, 15)
                    Text(item?.id ?? "blank")
                        .padding(.horizontal, 15)
                    Text(item?.properties.detail ?? "blank")
                        .padding(.horizontal, 15)
                    Text("请求而来")
                        .padding(.horizontal, 15)
                  
                    Text(dts?.properties.place ?? "blank").padding(.horizontal, 15)
                    Text(dts?.properties.title ?? "blank").padding(.horizontal, 15)
                    Text(dts?.properties.type ?? "blank").padding(.horizontal, 15)
                    Text(dts?.properties.alert ?? "blank").padding(.horizontal, 15)
                    Text(dts?.properties.url ?? "blank").padding(.horizontal, 15)
                    Text( String.timeIntervalChangeToTimeStr(timeInterval: Double.init(item?.properties.time ?? 1623066598291) ) )
                        .padding(.horizontal, 15)
                }
                
             
                VStack(alignment: .leading,spacing: 20){
                    
                    
                    NavigationLink(destination: Ddetail(url: dts)) {
                        Text(dts?.properties.title ?? "n/a")
                    }
                    .padding(.horizontal, 15)
                    Spacer()
                    Link(dts?.properties.title ?? "blank", destination: URL(string: dts?.properties.url ?? "blank")!  )
                        .padding(.horizontal, 15)
                }
               

            }
            .onAppear(perform: loadData)
            .navigationTitle(item?.id ?? "blank")
            .navigationBarTitleDisplayMode(.inline)
            
            Spacer()
        }
    }
}
 

extension Detail {
 
    func loadData() {
        let urlstring = item?.properties.detail ?? ""
            guard let url = URL(string: urlstring) else { return }
            let task =    URLSession.shared.dataTask(with: url) {  (data, response, error) in
                if  data != nil {
                    do{
                        let xt = try  JSONDecoder().decode(Res.self, from: data!)
                        DispatchQueue.main.async{
                            print(xt)
                           self.dts = xt
                       
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
