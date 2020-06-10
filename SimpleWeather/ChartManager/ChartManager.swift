//
//  ChartManager.swift
//  SimpleWeather
//
//  Created by Alexander on 08.06.2020.
//  Copyright © 2020 Alexander Team. All rights reserved.
//

import Charts
import Foundation

class ChartManager {
    
    weak var lineChartView: LineChartView?
    var line = LineChartDataSet()
    var data = LineChartData()
    var dataEntries = [ChartDataEntry]()
    let marker = DailyMarker()
    
    init(lineChartView: LineChartView, lineChartViewDelegate: ChartViewDelegate?) {
        self.lineChartView = lineChartView
        self.lineChartView?.delegate = lineChartViewDelegate
        setupLine()
        setupChart()
        setupMarker()
    }
    
    func setupMarker() {
        lineChartView?.marker = marker
    }
    
    func setupLine() {
        line.colors = [NSUIColor.blue]
        line.circleRadius = 12
        let color = #colorLiteral(red: 0.4823529412, green: 0.3725490196, blue: 0.5607843137, alpha: 1)
        let nscolor = NSUIColor(cgColor: color.cgColor)
        line.circleColors = [nscolor]
        line.drawCircleHoleEnabled = false
        line.colors = [NSUIColor.lightGray]
        line.lineWidth = 1.5
        line.label = "Daily temp"
        line.highlightLineWidth = 0
    }
    
    func setupChart() {
        lineChartView?.notifyDataSetChanged()
        lineChartView?.xAxis.enabled = false
        lineChartView?.xAxis.drawGridLinesEnabled = false
        lineChartView?.leftAxis.enabled = false
        lineChartView?.rightAxis.enabled = false
        lineChartView?.pinchZoomEnabled = false
        lineChartView?.doubleTapToZoomEnabled = false
        lineChartView?.dragEnabled = false
        lineChartView?.scaleXEnabled = false
        lineChartView?.scaleYEnabled = false
        lineChartView?.legend.enabled = false
        lineChartView?.setViewPortOffsets(left: 20, top: 20, right: 20, bottom: 20)
        lineChartView?.notifyDataSetChanged()
    }
    
    func chartUpdate(entries: [ChartDataEntry]) {
        dataEntries = entries
        data.removeDataSet(line)
        line.replaceEntries(dataEntries)
        data.addDataSet(line)
        data.setDrawValues(false)
        lineChartView?.data = data
        lineChartView?.animate(xAxisDuration: 1, yAxisDuration: 1, easingOption: .linear)
        lineChartView?.notifyDataSetChanged()
        lineChartView?.marker = marker
    }
}

class DailyMarker: MarkerView {
    
    let dot = UIView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupMarker()
    }
    
    func setupMarker() {
        self.addSubview(dot)
        dot.translatesAutoresizingMaskIntoConstraints = false
        dot.frame = CGRect(origin: center, size: CGSize(width: 10, height: 10))
        dot.layer.cornerRadius = self.dot.frame.height / 2
        dot.center = self.center
        dot.backgroundColor = .white
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
