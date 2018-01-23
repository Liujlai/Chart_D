//
//  DViewController.swift
//  Chart_D
//
//  Created by idea on 2018/1/23.
//  Copyright © 2018年 youlu. All rights reserved.
//

import UIKit
import Charts

class DViewController: UIViewController {

    var pieChartView: PieChartView!
    override func viewDidLoad() {
        super.viewDidLoad()
        pieChartView = PieChartView(frame: CGRect(x: 0, y: 0, width: 300, height: 500))
        view.addSubview(pieChartView)
        // Do any additional setup after loading the view.
        let months = ["Jan", "Feb", "Mar", "Apr", "May", "Jun"]
        let unitsSold = [20.0, 4.0, 6.0, 3.0, 12.0, 16.0]
        
        setChart(dataPoints: months, values: unitsSold)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
        
        /*
         let lineChartDataSet = LineChartDataSet(yVals: dataEntries, label: "Units Sold")
         let lineChartData = LineChartData(xVals: dataPoints, dataSet: lineChartDataSet)
         lineChartView.data = lineChartData
         */
    } }
