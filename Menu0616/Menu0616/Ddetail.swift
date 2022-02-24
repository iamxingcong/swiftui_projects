//
//  Ddetail.swift
//  Menu0616
//
//  Created by r on 2021/6/21.
//

import SwiftUI

struct Ddetail: View {
    var url: Res? = nil
    var body: some View {
       
        WebView(urlString: url?.properties.url ?? "n/a")
    }
}
