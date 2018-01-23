//
//  ViewController.swift
//  Chart_D
//
//  Created by idea on 2018/1/16.
//  Copyright © 2018年 youlu. All rights reserved.
//

import UIKit
import Charts
let s_w = UIScreen.main.bounds.width
let s_h = UIScreen.main.bounds.height

class ViewController: DemoBaseViewController {

    var pieChartView: PieChartView!
    var lineChartView: LineChartView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
          self.title = "图标"
        pieChartView = PieChartView.init(frame: CGRect(x: 0, y: 0, width: s_w, height: s_h/2))
        pieChartView.delegate = self;
        self.view.addSubview(pieChartView)
        lineChartView = LineChartView.init(frame: CGRect(x: 0, y: s_h/2+20, width: s_w, height: s_h/2-20))
        lineChartView.delegate = self;
        self.view.addSubview(lineChartView)
        let months = ["Jan", "Feb", "Mar", "Apr", "May", "Jun"]
        let unitsSold = [20.0, 4.0, 6.0, 3.0, 12.0, 16.0]
        
        setChart(dataPoints: months, values: unitsSold)
        
    }
    
    func setChart(dataPoints: [String], values: [Double]) {
        
        var dataEntries: [ChartDataEntry] = []
        
        for i in 0..<dataPoints.count {
            let dataEntry = ChartDataEntry(x: values[i], y: Double(i))
            dataEntries.append(dataEntry)
        }
        
        let pieChartDataSet = PieChartDataSet(values: dataEntries, label: "Units Sold")
        let pieChartData = PieChartData(dataSet: pieChartDataSet)
        pieChartView.data = pieChartData
        
        var colors: [UIColor] = []
        
        for i in 0..<dataPoints.count {
            let red = Double(arc4random_uniform(256))
            let green = Double(arc4random_uniform(256))
            let blue = Double(arc4random_uniform(256))
            
            let color = UIColor(red: CGFloat(red/255), green: CGFloat(green/255), blue: CGFloat(blue/255), alpha: 1)
            colors.append(color)
        }
        
        pieChartDataSet.colors = colors
        
        
        let lineChartDataSet = LineChartDataSet(values: dataEntries, label: "Units Sold")
        let lineChartData = LineChartData(dataSet: lineChartDataSet)
        lineChartView.data = lineChartData
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

