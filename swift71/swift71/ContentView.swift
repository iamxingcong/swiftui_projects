//
//  ContentView.swift
//  swift71
//
//  Created by r on 2021/7/1.
//

import SwiftUI
import Foundation
import Kingfisher


struct Data: Codable {
    var drinks: [Drinks]
    struct Drinks: Codable {
        var strDrink: String
        var strDrinkThumb: String
        var idDrink: String
    }
}


struct ContentView: View {
    @State private var dts = [Data.Drinks]()
    var body: some View {
        VStack(){
            List(dts, id: \.idDrink){  model in
                VStack( alignment: .leading, spacing: 10 ){
                    Text(model.idDrink)
                    Text(model.strDrink)
                    KFImage(URL(string: model.strDrinkThumb)!)
                        .resizable()
                            .aspectRatio(contentMode: .fill)
                        .padding(.bottom, 40)

                }
                Spacer()
            }
            
        }.onAppear(perform: fata)
    }
}

extension ContentView {
    
     func fata() {
        let apilinks = "https://www.thecocktaildb.com/api/json/v1/1/filter.php?a=Non_Alcoholic"
        let request = NSMutableURLRequest(url: NSURL(string: apilinks)! as URL)
        request.httpMethod = "GET"
        
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
            if (error != nil) {
                print(error!)
            } else {
                let xt = try! JSONDecoder().decode(Data.self, from: data!)

                DispatchQueue.main.async {
                    self.dts = xt.drinks
                    print(xt)
                }
            }
        })
        dataTask.resume()
   }
}
