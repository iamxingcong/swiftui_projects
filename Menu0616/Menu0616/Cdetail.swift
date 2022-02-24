//
//  Cdetail.swift
//  Menu0616
//
//  Created by r on 2021/6/19.
//

import SwiftUI
import Kingfisher


import Foundation



struct Row: View {

    var model: StructData.Datainfo? = nil

    var body: some View {

        VStack(alignment: .leading){

            Text(model?.title ?? "N/A")

            Text(model?.subtitle ?? "N/A")

            Text(model?.id ?? "N/A")
            
            KFImage(URL(string: model?.image ?? "")!)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .padding(.bottom, 40)
            
        }

    }

}


struct Cdetail: View {

    @ObservedObject var server = Server()
    var body: some View {

            List(server.dts) { model in
                    Row(model: model)
               
            }
           

    }
}

struct StructData: Codable {

    var message : String? = nil

    var code: Int? = nil

    var datainfo: [Datainfo] = [Datainfo]()

    struct Datainfo:  Codable, Identifiable {

        var charge: Double? = nil

        var id: String? = nil

        var image: String? = nil

        var linkurl: String? = nil

        var title: String? = nil

        var subtitle: String? = nil

        var sales: Int? = nil

    }

}


class Server: ObservableObject {

    @Published var dts = [StructData.Datainfo]()

    init() {

      

        let urlstring = "https://front.miido.com.cn/shop/rest/indexface/getMoreCourse?page=1"

        guard let url = URL(string: urlstring) else { return }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in

            

            if data != nil {

                do {

                    let myServiceResponse = try JSONDecoder().decode(StructData.self, from: data!)

                    DispatchQueue.main.async {

                         

                        self.dts = myServiceResponse.datainfo

                        //print(myServiceResponse)

                    }

                } catch let exception {

                    print(exception)

                }

            }else {

                print("Something went wrong!")

            }

        }

        task.resume()

    }

}
