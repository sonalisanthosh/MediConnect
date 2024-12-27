//
//  HomeView.swift
//  MediConnect
//
//  Created by Sonali Santhosh on 12/27/24.
//

import Foundation
import SwiftUI

struct HomeView: View {
    var body: some View {
        VStack {
            Text("Welcome to the Home Page!")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding()
        }
        .navigationBarTitle("Home", displayMode: .inline)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
