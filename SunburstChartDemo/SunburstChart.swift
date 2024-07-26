//
//  SunburstChart.swift
//  SunburstChartDemo
//
//  Created by Daniel Bolella on 5/2/24.
//

import SwiftUI
import Charts

struct SunburstChart: View {
    let chartWidth: CGFloat = 175
    
    @State var selectedTotal1: Double?
    @State var selectedSegment1: MarketData?
    
    @State var selectedTotal2: Double?
    @State var selectedSegment2: MarketData?
    
    var body: some View {
        VStack {
            if let selectedSegment1 {
                Text(selectedSegment1.name)
                    .font(.title)
                Text("$\(selectedSegment1.total.formatted())")
                    .font(.title3)
            } else if let selectedSegment2 {
                Text(selectedSegment2.name)
                    .font(.title)
                Text("$\(selectedSegment2.total.formatted())")
                    .font(.title3)
            } else {
                Text("Welcome to Our Market!")
                    .font(.title)
                Text("Select a segment...")
                    .font(.title3)
            }
            
            ZStack {
                let outerRing = getRing()
                Chart(outerRing){ item in
                    SectorMark(angle: .value("Total", item.total),
                               innerRadius: .ratio(0.6),
                               outerRadius: .ratio(0.9),
                               angularInset: 1.5)
                    .foregroundStyle(colorFor(type: item.type)
                        .opacity(selectOpacity(markID: item.id, selectID: selectedSegment2?.id, ring: 2)))
                }
                .frame(width: chartWidth * 2, height: chartWidth * 2)
                .chartAngleSelection(value: $selectedTotal2)
                .onChange(of: selectedTotal2) { _, newValue in
                    selectedSegment1 = nil
                    if let newValue {
                        selectedSegment2 = findSelectedSector(value: newValue, in: outerRing)
                    } else {
                        selectedSegment2 = nil
                    }
                }
                
                Chart(mockData){ item in
                    SectorMark(angle: .value("Total", item.total),
                               innerRadius: .ratio(0.5),
                               angularInset: 1.5)
                    .foregroundStyle(colorFor(type: item.type)
                        .opacity(selectOpacity(markID: item.id, selectID: selectedSegment1?.id)))
                }
                .frame(width: chartWidth, height: chartWidth)
                .chartAngleSelection(value: $selectedTotal1)
                .onChange(of: selectedTotal1) { _, newValue in
                    selectedSegment2 = nil
                    if let newValue {
                        selectedSegment1 = findSelectedSector(value: newValue, in: mockData)
                    } else {
                        selectedSegment1 = nil
                    }
                }
            }
        }
    }
    
    func getRing() -> [MarketData] {
        let allChildren = mockData.map { $0.children }
        return allChildren.flatMap { $0 }
    }
    
    func colorFor(type: MarketType) -> Color {
        switch type {
        case .fruit:
            return Color.yellow
        case .vegetable:
            return Color.red
        case .meat:
            return Color.blue
        case .other:
            return Color.green
        }
    }
    
    func selectOpacity(markID: UUID, selectID: UUID?, ring: Int = 1) -> CGFloat {
        if let selectID {
            if selectID == markID {
                return 1.0
            }
        }
        return ring == 1 ? 0.8 : 0.55
    }
    
    private func findSelectedSector(value: Double, in data: [MarketData]) -> MarketData? {
        var accumulatedCount: Double = 0
        
        let sector = data.first { item in
            accumulatedCount += item.total
            return value <= accumulatedCount
        }
        
        return sector
    }
}

