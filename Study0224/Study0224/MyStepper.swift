//
//  MyStepper.swift
//  Study0224
//
//  Created by r on 2022/2/24.
//

import SwiftUI

struct MyStepper: View {
    @Binding var counterz: Int 

    var body: some View {
        Stepper("\(counterz)", value: $counterz, in: 0...9)

    }
}

