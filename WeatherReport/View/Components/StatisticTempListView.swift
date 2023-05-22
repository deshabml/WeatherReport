//
//  StatisticTempListView.swift
//  WeatherReport
//
//  Created by Лаборатория on 22.05.2023.
//

import SwiftUI

struct StatisticTempListView: View {

    @EnvironmentObject var mainViewModel: WeatherViewModel

    var body: some View {
        List {
            ForEach(0 ..< mainViewModel.statistics.count, id: \.self) { index in
                    HStack {
                        Text("\(mainViewModel.tempDescription(mainViewModel.statistics[index].min))")
                            .frame(width: 40)
                        ZStack(alignment: .leading) {
                            Rectangle()
                                .frame(width: 200, height: 30)
                                .cornerRadius(15)
                                .foregroundColor(.gray)
                            Rectangle()
                                .frame(width: CGFloat(mainViewModel.widthDeyTemp(index: index)), height: 30)
                                .cornerRadius(15)
                                .foregroundColor(.blue)
                                .padding(.left, CGFloat(mainViewModel.paddingTemp(index: index)))
                        }
                        Text("\(mainViewModel.tempDescription(mainViewModel.statistics[index].max))")
                    }
                    .listRowBackground(Color.black.opacity(0.4).blur(radius: 4))
            }
            Text("")
                .listRowBackground(Color.clear)
        }
        .listStyle(.plain)
    }
    
}

struct StatisticTempListView_Previews: PreviewProvider {
    static var previews: some View {
        StatisticTempListView()
    }
}
