//
//  HomeView.swift
//  Go Taxi
//
//  Created by apple on 09.08.2023.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        TaxiMapViewRepresentable()
            .ignoresSafeArea()
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
