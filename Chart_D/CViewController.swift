//
//  CViewController.swift
//  Chart_D
//
//  Created by idea on 2018/1/23.
//  Copyright © 2018年 youlu. All rights reserved.
//

import UIKit
import Charts
//import SnapKit
import Cupcake

class CViewController: UIViewController ,ChartViewDelegate {
    
    
    var months = ["小麦", "水稻", "玉米"," "]
    var unitsSold = [33.0, 33.0, 34.0,400.0]
    var kxiao = ["小麦", " "]
    var kmai = [33.0, 60.0-33 ]
    var kshui = ["水稻", " "]
    var kdao = [33.0, 240.0-33 ]
    var kyu = ["玉米", " "]
    var kmi = [34.0, 200.0-33 ]

    
    fileprivate lazy var pieChartView: PieChartView = {
        let pieChartView = PieChartView()
        pieChartView.backgroundColor = UIColor.white
        //基本样式
        pieChartView.delegate = self
        return pieChartView
    }()
    fileprivate lazy var piexiaoView: PieChartView = {
        let piexiaoView = PieChartView()
        piexiaoView.backgroundColor = UIColor.white
        //基本样式
        piexiaoView.delegate = self
        return piexiaoView
    }()
    fileprivate lazy var pieshuiView: PieChartView = {
        let piexiaoView = PieChartView()
        piexiaoView.backgroundColor = UIColor.white
        //基本样式
        piexiaoView.delegate = self
        return piexiaoView
    }()
    fileprivate lazy var pieyuView: PieChartView = {
        let piexiaoView = PieChartView()
        piexiaoView.backgroundColor = UIColor.white
        //基本样式
        piexiaoView.delegate = self
        return piexiaoView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(pieChartView)
        pieChartView.makeCons { (make) in
            make.left.equal(self.view).offset(5)
            make.top.equal(self.view).offset(64)
            make.right.equal(self.view).offset(-5)
            make.height.equal(250)
        }
       
        
        piexiaoView.makeCons { (make) in
            make.left.equal(self.view).offset(5)
            make.top.equal(self.pieChartView).bottom.offset(10)
            make.height.width.equal(150)
        }
        pieshuiView.makeCons { (make) in
            make.right.equal(self.view).offset(-5)
             make.top.equal(piexiaoView)
            make.height.width.equal(piexiaoView)
        }
        pieyuView.makeCons { (make) in
            make.left.equal(self.view).offset(5)
            make.top.equal(self.piexiaoView).bottom.offset(10)
            make.height.width.equal(piexiaoView)
        }
        view.addSubviews(piexiaoView,pieshuiView,pieyuView)
        
       let left = VStack(Label.str("当月排行"),Label.str("第1名")).gap(5).align(.center)
        let rig = VStack(Label.str("订单"), Button.str("3笔").color("#288Fce")).gap(2).align(.center)
        HStack(10,left,"<-->",rig,10).embedIn(pieChartView,10,10,10)
        
        let lab1 = Label.str("团队作业占比：").color("#288Fce")
         let lab2 = Label.str("100.0/500.0")
         HStack("<-->",lab1,5,lab2,"<-->").embedIn(pieChartView,nil,10,10,10)
        setChart(dataPoints: months, values:unitsSold)
        setChartK(dataPoints: kxiao, values:kmai,ind:1)
        setChartK(dataPoints: kshui, values:kdao,ind:2)
        setChartK(dataPoints: kyu, values:kmi,ind:3)
        // Do any additional setup after loading the view.
    }
    
    func setChartK(dataPoints: [String], values: [Double],ind:Int) {
        var dataEntries: [ChartDataEntry] = []
        for i in 0..<dataPoints.count {
            let entry = PieChartDataEntry(value: values[i], label: "\(dataPoints[i])"+"\(values[i])亩") //设置数据 title和对应的值
            
            dataEntries.append(entry)
        }

        let pichartDataSet = PieChartDataSet(values: dataEntries, label: "") //设置表示

        let pieChartData = PieChartData(dataSet: pichartDataSet)
        //设置饼状图字体样式
        setPieChartDataConfig(pieChartData: pieChartData)
        if ind == 1{
            piexiaoView.data = pieChartData //将配置及数据添加到表中
        }else if ind == 2{
             pieshuiView.data = pieChartData //将配置及数据添加到表中
        }else if ind == 3{
            pieyuView.data = pieChartData
        }
        

        //设置饼状图样式
        setDrawHoleState()
        
        var colors: [UIColor] = []
        for i in 0..<dataPoints.count {
            if i == dataPoints.count-1{
                colors.append(UIColor(r: 210, g: 210, b: 210))
            }else{
                colors.append(UIColor.randomColor())
            }
        }
        
        pichartDataSet.colors = colors//设置区块颜色
    }
    
    
    func setChart(dataPoints: [String], values: [Double]) {
        var dataEntries: [ChartDataEntry] = []
        for i in 0..<dataPoints.count {
            let entry = PieChartDataEntry(value: values[i], label: "\(dataPoints[i])"+"\(values[i])亩") //设置数据 title和对应的值
            
            dataEntries.append(entry)
        }
        
        
        let pichartDataSet = PieChartDataSet(values: dataEntries, label: "") //设置表示
        //设置饼状图字体配置
        setPieChartDataSetConfig(pichartDataSet: pichartDataSet)
        
        
        let pieChartData = PieChartData(dataSet: pichartDataSet)
        //设置饼状图字体样式
        setPieChartDataConfig(pieChartData: pieChartData)
        pieChartView.data = pieChartData //将配置及数据添加到表中
        
        
        //设置饼状图样式
        setDrawHoleState()
        
        var colors: [UIColor] = []
        for i in 0..<dataPoints.count {
            if i == dataPoints.count-1{
                colors.append(UIColor(r: 210, g: 210, b: 210))
            }else{
                colors.append(UIColor.randomColor())
            }
        }
        
        pichartDataSet.colors = colors//设置区块颜色
    }
    //设置饼状图字体配置
    func setPieChartDataSetConfig(pichartDataSet: PieChartDataSet){
        pichartDataSet.sliceSpace = 0 //相邻区块之间的间距
        pichartDataSet.selectionShift = 0 //选中区块时, 放大的半径
        
        
    }
    
    //设置饼状图字体样式
    func setPieChartDataConfig(pieChartData: PieChartData){
        pieChartData.setValueFormatter(DigitValueFormatter())//设置百分比
        
        pieChartData.setValueTextColor(UIColor.gray) //字体颜色为白色
        pieChartData.setValueFont(UIFont.systemFont(ofSize: 0))//字体大小
    }
    
    
    //设置饼状图中心文本
    func setDrawHoleState(){
        ///饼状图距离边缘的间隙
        pieChartView.setExtraOffsets(left: 0, top: 0, right: 30, bottom: 0)
        piexiaoView.setExtraOffsets(left: 0, top: 3, right: 0, bottom: 0)
        //拖拽饼状图后是否有惯性效果
        pieChartView.dragDecelerationEnabled = true
        //是否显示区块文本
        pieChartView.drawSlicesUnderHoleEnabled = true
        //是否根据所提供的数据, 将显示数据转换为百分比格式
        pieChartView.usePercentValuesEnabled = true
        
//         设置饼状图描述
//                pieChartView.chartDescription?.text = "饼状团队作业占比图示例"
                pieChartView.chartDescription?.font = UIFont.systemFont(ofSize: 0)
        piexiaoView.chartDescription?.font = UIFont.systemFont(ofSize: 0)
        pieshuiView.chartDescription?.font = UIFont.systemFont(ofSize: 0)
        pieyuView.chartDescription?.font = UIFont.systemFont(ofSize: 0)
//                pieChartView.chartDescription?.textColor = UIColor.gray
        piexiaoView.legend.font = UIFont.systemFont(ofSize: 0)
        piexiaoView.legend.formSize = 0 //图示大小
        pieshuiView.legend.font = UIFont.systemFont(ofSize: 0)
        pieshuiView.legend.formSize = 0 //图示大小
        pieyuView.legend.font = UIFont.systemFont(ofSize: 0)
        pieyuView.legend.formSize = 0 //图示大小
        
//        // 设置饼状图图例样式
        pieChartView.legend.maxSizePercent = 1 //图例在饼状图中的大小占比, 这会影响图例的宽高
        pieChartView.legend.formToTextSpace = 10 //文本间隔
        pieChartView.legend.font = UIFont.systemFont(ofSize: 15) //字体大小
        pieChartView.legend.textColor = UIColor.gray //字体颜色
        pieChartView.legend.verticalAlignment = .center //图例在饼状图中的位置
        pieChartView.legend.form = .square //图示样式: 方形、线条、圆形
        pieChartView.legend.formSize = 12 //图示大小
        pieChartView.legend.orientation = .vertical
        pieChartView.legend.horizontalAlignment = .left
        
        
        
        
      
         ///设置饼状图中心的文本
         if pieChartView.isDrawHoleEnabled {
         ///设置饼状图中间的空心样式
         pieChartView.drawHoleEnabled = true //饼状图是否是空心
         pieChartView.holeRadiusPercent = 0.6 //空心半径占比
         pieChartView.holeColor = Color("#288Fce") //空心颜色
            piexiaoView.holeColor = Color("lightGray,0.1")
         pieChartView.transparentCircleRadiusPercent = 0.63 //半透明空心半径占比
         pieChartView.transparentCircleColor = UIColor.lightGray//半透明空心的颜色
         pieChartView.drawCenterTextEnabled = true //是否显示中间文字
         //普通文本
         pieChartView.centerText = "  20% \n\n 作业占比"
            ImageView.img("pic_zuoyefenlei").pin(.center).pin(54,54).addTo(piexiaoView)
//            piexiaoView.bg("#pic_zuoyefenlei")
        }
        
        
        pieChartView.setNeedsDisplay()
        
        
    }
    //        pieChartData.setValueFormatter(DigitValueFormatter() //设置百分比
    //转化为带%
    class DigitValueFormatter: NSObject, IValueFormatter {
        func stringForValue(_ value: Double, entry: ChartDataEntry, dataSetIndex: Int, viewPortHandler: ViewPortHandler?) -> String {
            let valueWithoutDecimalPart = String(format: "%.2f%%", value)
            return valueWithoutDecimalPart
            
        }
        
        
    }
    
}



