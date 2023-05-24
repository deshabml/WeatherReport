//
//  CityView.swift
//  WeatherReport
//
//  Created by Лаборатория on 20.05.2023.
//

import SwiftUI

struct CityView: View {

    @EnvironmentObject var mainViewModel: WeatherViewModel

    var body: some View {
        VStack {
            if mainViewModel.isChoosingCity {
                    TextField("Город", text: $mainViewModel.city)
                        .font(.custom("AvenirNext-Bold", size: 24))
                        .padding()
                        .multilineTextAlignment(.center)
                        .background(
                            Color("DarkSea").blur(radius: 2))
            } else {
                Text(mainViewModel.weatherData?.name ?? "-")
                    .font(.custom("AvenirNext-Bold", size: 24))
                    .onTapGesture {
                        mainViewModel.isChoosingCity.toggle()
                    }
            }
        }
        .frame(height: 50)
    }

}

struct CityView_Previews: PreviewProvider {
    static var previews: some View {
        CityView()
    }
}
