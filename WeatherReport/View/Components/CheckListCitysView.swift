//
//  CheckListCitysView.swift
//  WeatherReport
//
//  Created by Лаборатория on 21.05.2023.
//

import SwiftUI

struct CheckListCitysView: View {

    @EnvironmentObject var mainViewModel: WeatherViewModel

    var body: some View {
        VStack {
            if mainViewModel.isCityExists, mainViewModel.isChoosingCity {
                List() {
                    ForEach(0 ..< mainViewModel.citys.count, id: \.self) {index in
                        HStack {
                            Spacer()
                            Text(mainViewModel.citys[index])
                                .font(.custom("AvenirNext", size: 24))
                                .foregroundColor(.white)
                                .onTapGesture {
                                    mainViewModel.isChoosingCity.toggle()
                                    mainViewModel.saveCity(city: mainViewModel.citys[index])
                                }
                            Spacer()
                        }
                    }
                    .listRowBackground(Color.black.opacity(0.8).blur(radius: 4))
                    Text("")
                        .listRowBackground(Color.clear)
                }
                .listStyle(.plain)
                .frame(width: 300)
                .cornerRadius(18)
                .padding(.vertical, 50)
            }
            Spacer()
        }
    }

}
