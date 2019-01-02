//
//  LineDrawViewController.swift
//  helloproject
//
//  Created by apple on 02/01/19.
//  Copyright © 2019 apple. All rights reserved.
//

import UIKit

class LineDrawViewController: UIViewController {

    @IBOutlet weak var startBtn: UIButton!
    var currentPoint : CGPoint = CGPoint ()
    
    var tapGesture : UITapGestureRecognizer = UITapGestureRecognizer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        currentPoint = CGPoint(x: -1, y: -1)// start
        // Do any additional setup after loading the view, typically from a nib.
        tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapAction))
        self.view.addGestureRecognizer(tapGesture)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func tapAction(sender : UITapGestureRecognizer){
        print("tap action ")
        if currentPoint == CGPoint(x: -1, y: -1) {
            currentPoint = sender.location(in: self.view)
        }else{
            let newPoint = sender.location(in: self.view)
            
            let lineV = LineView(frame: self.view.frame, startPoint: currentPoint, endPoint: newPoint)
            self.view.addSubview(lineV)
            currentPoint = newPoint
            self.view.bringSubview(toFront: self.startBtn)
        }
        
        let location = sender.location(in: self.view)
        let dot = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 10))
        dot.center = location
        dot.backgroundColor = UIColor.red
        dot.layer.cornerRadius = 5.0
        dot.clipsToBounds = true
        self.view.addSubview(dot)
    }
    
    @IBAction func StartAction(_ sender: UIButton) {
        currentPoint = CGPoint(x: -1, y: -1)// start
    }
    
    // MARK:- Draw Line
    func okok(){
        
    }
    
}

class LineView : UIView {
    
    var startP : CGPoint = CGPoint()
    var endP : CGPoint = CGPoint()
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.init(white: 0.0, alpha: 0.0)
    }
    
    init(frame: CGRect, startPoint : CGPoint, endPoint : CGPoint){
        super.init(frame: frame)
        self.backgroundColor = UIColor.clear
        startP = startPoint
        endP = endPoint
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        if let context = UIGraphicsGetCurrentContext() {
            context.setStrokeColor(UIColor.blue.cgColor)
            context.setLineWidth(3)
            context.beginPath()
            context.move(to: startP) // This would be oldX, oldY
            context.addLine(to: endP) // This would be newX, newY
            context.strokePath()
        }
    }

}
