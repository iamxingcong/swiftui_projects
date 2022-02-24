//
//  Detail.swift
//  Menu0616
//
//  Created by r on 2021/6/16.
//


import SwiftUI
 

import Foundation
struct QuakeAPIList: Decodable {
    var features: [Features]
     

    struct Features: Decodable  {
        var id: String
        var properties: Properties
        var geometry: Geometry
 
        struct Properties: Decodable  {
            var mag: Double
            var place: String
            var time: Double
            var detail: String
            var title: String
            var type: String? = nil
            var alert: String? = nil
            
        }
        struct Geometry: Decodable  {
            var type: String
            var coordinates: [Double]
        }
    }

}
 


struct DRow: View {

    var item: QuakeAPIList.Features? = nil
   
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(item?.properties.title ?? "")
                .font(.headline)
            Text(item?.properties.place ?? "")
           
            Text(item?.properties.alert ?? "")
 
            Text( String.timeIntervalChangeToTimeStr(timeInterval: Double.init(item?.properties.time ?? 1623066598291)))
           
 
        }
    }
}



struct MainList: View {
 
    @State private var countryData = [QuakeAPIList.Features]()
 
    
    var body: some View {
        
        VStack(){
            NavigationView {
                List(countryData, id: \.id) { item in
                    NavigationLink(destination: Detail(item: item)) {
                        DRow(item: item)
                    }
                }
                .navigationTitle("地震信息")
                .navigationBarTitleDisplayMode(.inline)
                .navigationViewStyle(StackNavigationViewStyle())
            }
            
            .onAppear(perform: loadData)
        }
    }
}
struct MainList_Previews: PreviewProvider {
    static var previews: some View {
        MainList()
    }
}

extension String{
   
    static func timeIntervalChangeToTimeStr(timeInterval:Double) -> String {


       let xtimeInterval = timeInterval/1000

        let date:Date = Date(timeIntervalSince1970: xtimeInterval)
        let formatter = DateFormatter()
       
            formatter.dateFormat = "YYYY-MM-dd HH:mm:ss"
       
        return formatter.string(from: date as Date)
    }
    
   
}


extension MainList {
    
    

    func loadData() {
        let urlstring = "https://earthquake.usgs.gov/earthquakes/feed/v1.0/summary/significant_month.geojson"
        
        let time =  1623066598291
        
        let myTimeInterval = TimeInterval(time/1000)
        let wtime = NSDate(timeIntervalSince1970: TimeInterval(myTimeInterval))
        
        print(wtime)

        let date = NSDate(timeIntervalSince1970: 1432233446145.0/1000.0)
        print("date is \(date)")
        // date is 2015-05-21 18:37:26 +0000
      
           guard let url = URL(string: urlstring) else { return }
           let task =    URLSession.shared.dataTask(with: url) {  (data, response, error) in
               if  data != nil {
                   do{
                       let response_obj = try  JSONDecoder().decode(QuakeAPIList.self, from: data!)
                       DispatchQueue.main.async{
                        self.countryData = response_obj.features
                         // print(response_obj.features)
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
