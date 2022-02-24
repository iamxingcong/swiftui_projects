//
//  Menu.swift
//  Menu0616
//
//  Created by r on 2021/6/16.
//

import SwiftUI

struct Menu: View {
   
    @State private var selection = 1
    
    var body: some View {
        VStack(){
           
                TabView(selection: $selection){

                        MainList()
                        .tabItem{
                            Image(systemName: "person.crop.circle")
                            Text("earthquake")
                        }
                        .tag(0)
                        .navigationBarTitle("")
                        .navigationBarHidden(true)
                    
                      
                     
                        Country()
                        .tabItem{
                            Image(systemName: "heart.circle.fill")
                            Text("country")
                        }
                        .tag(1)
                        .navigationBarTitle("")
                        .navigationBarHidden(true)
                     
                        Questions()
                        .tabItem{
                            Image(systemName: "house.circle.fill")
                            Text("find")
                        }
                        .tag(2)
                        .navigationBarTitle("")
                        .navigationBarHidden(true)
                    
                      
                }
               
        }

    }
    
 }
