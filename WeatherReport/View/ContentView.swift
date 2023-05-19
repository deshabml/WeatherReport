//
//  ContentView.swift
//  WeatherReport
//
//  Created by Лаборатория on 19.05.2023.
//

import SwiftUI

struct ContentView: View {

    var body: some View {
        NavigationView {
            WeatherView(viewModel: WeatherViewModel())
        }
        .preferredColorScheme(.light)
    }

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
