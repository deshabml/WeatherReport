//
//  WeatherView.swift
//  WeatherReport
//
//  Created by Лаборатория on 19.05.2023.
//

import SwiftUI

struct WeatherView: View {

    @StateObject var viewModel: WeatherViewModel

    var body: some View {
        VStack {
            ZStack {
                VStack {
                    CityView()
                        .environmentObject(viewModel)
                    HStack(spacing: 30) {
                        Text(viewModel.tempDescription(viewModel.weatherData?.main.tempMin))
                            .font(.custom("AvenirNext-Bold", size: 20))
                        Text(viewModel.tempDescription(viewModel.weatherData?.main.temp))
                            .font(.custom("AvenirNext-Bold", size: 80))
                        Text(viewModel.tempDescription(viewModel.weatherData?.main.tempMax))
                            .font(.custom("AvenirNext-Bold", size: 20))
                    }
                    .padding(.vertical, 10)
                    HStack {
                        Text("Восход: \n\(viewModel.getTime(utc: viewModel.weatherData?.sys.sunrise))")
                            .padding()
                        Spacer()
                        VStack {
                            Text(viewModel.pressureDescr(viewModel.weatherData?.main.pressure))
                                .font(.custom("AvenirNext-Regular", size: 20))
                            Text(viewModel.weatherData?.weather[0].main ?? "-")
                                .font(.custom("AvenirNext-Bold", size: 20))
                            Text("\(viewModel.weatherData?.wind.speed.description ?? "-") м/с \(viewModel.getDirection())")
                                .font(.custom("AvenirNext-Regular", size: 20))
                        }
                        .padding(10)
                        .background(
                            Color("DarkSea").blur(radius: 40)
                        )
                        Spacer()
                        Text("Закат:\n\(viewModel.getTime(utc: viewModel.weatherData?.sys.sunset))")
                            .padding()
                    }.frame(maxWidth: .infinity)
                    List {
                        Text("")
                            .listRowBackground(Color.clear)
                    }
                    .listStyle(.plain)
                }
                CheckListCitysView()
                    .environmentObject(viewModel)
            }
        }
        .foregroundColor(.white)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(
            Image("Background")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .ignoresSafeArea())
        .animation(.easeInOut(duration: 0.3), value: viewModel.isChoosingCity)
        .onAppear {
            viewModel.loadScreen()
        }
    }

}

struct WeatherView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherView(viewModel: WeatherViewModel())
    }
}
