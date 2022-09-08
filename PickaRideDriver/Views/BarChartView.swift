//
//  BarChartView.swift
//  BaseStructure
//
//  Created by Gaurang on 06/09/22.
//

import UIKit

struct BarEntry {
    let height: CGFloat
    let title: String
    let value: CGFloat
}

class BarChartView: UIView {

    let barColor: UIColor = themeColor
    let selectedBarColor: UIColor = hexStringToUIColor(hex: "#2fcca3")
    var space: CGFloat = 12.0
    var topSpace: CGFloat = 00.0
    var bottomSpace: CGFloat = 20.0
    var barCornerRadius: CGFloat = 8
    var xAxisLabelColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
    private let fontSize: CGFloat = 10
    var dataEntries: [BarEntry] = []
    private var barLayers: [CAShapeLayer] = []
    private lazy var popover = BarPopoverView(frame: .zero)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    private func setup() {
        let gesture = UIPanGestureRecognizer(target: self, action: #selector(handlePan(_:)))
        addGestureRecognizer(gesture)
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        addGestureRecognizer(tapGesture)
    }
 
    func setDataEntries(values: [CGFloat], titles: [String]) {
        guard let maxValue = values.max() else { return }
        var entries: [BarEntry] = []
        for index in 0..<values.count {
            let value = values[index]
            let height: CGFloat = value / maxValue
            entries.append(BarEntry( height: height.isNaN ? 0 : height, title: titles[index], value: value))
        }
        self.dataEntries = entries
    }
    
    func reloadData() {
        self.layoutIfNeeded()
        let dataCount = CGFloat(dataEntries.count)
        let totalWidth = frame.width - ((dataCount - 1.0) * space)
        let barWidth = totalWidth / dataCount
        var xPos: CGFloat = 0
        barLayers = []
        for bar in dataEntries {
            drawBar(xPos: xPos, height: bar.height, barWidth: barWidth)
            drawXLabel(xPos: xPos, width: barWidth, title: bar.title)
            xPos += barWidth + space
        }
        addSubview(popover)
    }
    
    private func drawBar(xPos: CGFloat, height: CGFloat, barWidth: CGFloat) {
        let frameHeight = frame.height - bottomSpace
        let barHeight = frameHeight * height
        let barLayer = CAShapeLayer()
        barLayer.cornerRadius = barCornerRadius
        barLayer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        barLayer.frame = CGRect(x: xPos, y: frameHeight - barHeight,
                                width: barWidth, height: barHeight)
        barLayer.backgroundColor = barColor.cgColor
        barLayers.append(barLayer)
        layer.addSublayer(barLayer)
    }
    
    private func drawXLabel(xPos: CGFloat, width: CGFloat, title: String) {
        var yPos: CGFloat = frame.height - bottomSpace
        yPos += (bottomSpace - fontSize) / 2
        let textLayer = CATextLayer()
        textLayer.frame = CGRect(x: xPos, y: yPos, width: width, height: bottomSpace - fontSize)
        textLayer.foregroundColor = xAxisLabelColor.cgColor
        textLayer.backgroundColor = UIColor.clear.cgColor
        textLayer.alignmentMode = CATextLayerAlignmentMode.center
        textLayer.contentsScale = UIScreen.main.scale
        textLayer.font = CTFontCreateWithName(UIFont.systemFont(ofSize: 0).fontName as CFString, 0, nil)
        textLayer.fontSize = fontSize
        textLayer.string = title
        layer.addSublayer(textLayer)
    }
    
    @objc private func handlePan(_ gesture: UIPanGestureRecognizer) {
        let point = gesture.location(in: self)
        switch(gesture.state) {
        case .began, .changed:
            handleLayerTouches(isCancelled: false, point: point)
        case .ended:
            handleLayerTouches(isCancelled: true, point: point)
        default:
            break
        }
    }
    
    @objc private func handleTap(_ gesture: UITapGestureRecognizer) {
        let point = gesture.location(in: self)
        handleLayerTouches(isCancelled: false, point: point )
    }
    
    private func handleLayerTouches(isCancelled: Bool, point: CGPoint) {
        var selectedLayer: CAShapeLayer?
      
        for layer in barLayers {
            if isCancelled || isLayerContains(point: point, layer: layer) == false {
                layer.backgroundColor = barColor.cgColor
            } else {
                layer.backgroundColor = selectedBarColor.cgColor
                selectedLayer = layer
            }
        }
        if popover.isHidden == true && selectedLayer != nil {
            UIImpactFeedbackGenerator(style: .light).impactOccurred()
        }
        popover.isHidden = selectedLayer == nil
        let popoverHeight: CGFloat = 20
        if let selectedLayer = selectedLayer {
            let layerFrame = selectedLayer.frame
            let frame = CGRect(x: layerFrame.origin.x, y: layerFrame.origin.y - popoverHeight - 4,
                               width: layerFrame.width, height: popoverHeight)
            if let index = barLayers.firstIndex(of: selectedLayer) {
                let value = dataEntries[index].value
                popover.title = "\(value)"
            }
            popover.frame = frame
        }
    }
    
    private func isLayerContains(point: CGPoint, layer: CAShapeLayer) -> Bool {
        var frame = layer.frame
        frame.origin.y = 0
        frame.size.height = UIScreen.main.bounds.height
        return frame.contains(point)
    }
    
    
}

class BarPopoverView: UIView {
    
    var title: String? {
        didSet {
            label.text = title
        }
    }
    lazy var label = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        addSubview(label)
        label.setAllSideContraints(UIEdgeInsets(top: 4, left: 6, bottom: -4, right: -6))
        label.textColor = .white
        label.font = CustomFont.medium.returnFont(10)
        backgroundColor = .lightGray
        layer.cornerRadius = 6
    }
    
}
