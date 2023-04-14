//
//  File.swift
//  
//
//  Created by Berkan Gezgin on 13.04.2023.
//

import Foundation
import UIKit
import SpriteKit

public class LuckWheelVC: UIViewController {
    @IBOutlet weak var wheelV: UIView!
    @IBOutlet weak var turnBtn: UIButton!
    
    var playScene: PlayScene?
    var segmentText: [String] = ["10", "20", "30", "40", "50", "60", "70", "80"]
    var firstPiece: Int = 3
    var discount: String = ""
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        // Add SKView class
        let skView = SKView(frame: wheelV.bounds)
        skView.backgroundColor = .clear
        wheelV.addSubview(skView)
        
        // Create GameScene class
        let scene = PlayScene(size: wheelV.bounds.size)
        scene.viewController = self
        scene.backgroundColor = .clear
        skView.presentScene(scene)
    }

    func showAlert(_ message:String) {
        let alertController = UIAlertController(title: "Congratulations 🎊", message: " \(message)", preferredStyle: .alert)

        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(okAction)

        present(alertController, animated: true, completion: nil)
    }
    
    @IBAction func turnBtnClicked(_ sender: Any) {
        playScene?.startRotation()
    }
}

class PlayScene: SKScene {
    var spinButton: UIButton!
    var segments = [SKShapeNode]()
    let wheel = SKShapeNode(circleOfRadius: 150)
    let rotate = SKAction.rotate(byAngle: -2 * CGFloat.pi, duration: 2)
    var byAngle: CGFloat = 0
    var viewSize: CGFloat = 0
    var radius = 183
    var centerImage = SKSpriteNode()
    var currentRotation: Float = 0.0
    
    var viewController: LuckWheelVC?
    
    override func didMove(to view: SKView) {
        self.byAngle = .pi * 20
        self.viewSize = (viewController?.wheelV.frame.size.height)!/2
        self.radius = Int(self.viewSize)
        
        wheel.position = CGPoint(x: (viewController?.wheelV.frame.size.width)!/2, y: (viewController?.wheelV.frame.size.height)!/2)
        addChild(wheel)
        
        
        // Spin button
        let spinButton = UIButton(frame: CGRect(x: 0, y: 0, width: (viewController?.wheelV.frame.size.width)!, height: (viewController?.wheelV.frame.size.height)!))
        
        spinButton.setTitle("", for: .normal)
        spinButton.addTarget(self, action: #selector(startRotation), for: .touchUpInside)
        
        self.viewController?.wheelV.addSubview(spinButton)
        viewController?.turnBtn.addTarget(self, action: #selector(startRotation), for: .touchUpInside)
        
        let attributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.boldSystemFont(ofSize: 16),
            .foregroundColor: UIColor.white,]

        
        // Create frame
        let segment03 = SKShapeNode(path: createSegmentPath4(start: 0, end: CGFloat(360)))
        segment03.fillColor = UIColor.black
        wheel.addChild(segment03)
        
        let segment02 = SKShapeNode(path: createSegmentPath3(start: 0, end: CGFloat(360)))
        segment02.fillColor = UIColor.white
        wheel.addChild(segment02)
        
        let segment01 = SKShapeNode(path: createSegmentPath2(start: 0, end: CGFloat(360)))
        segment01.fillColor = UIColor.black
        wheel.addChild(segment01)
        
        
        // MARK: Segment 1
        let segment1 = SKShapeNode(path: createSegmentPath(start: CGFloat(2 * 45 + 20), end: CGFloat(3 * 45 + 20)))
        let firstLine = NSAttributedString(string: "\(self.viewController!.segmentText[0])", attributes: attributes)
        let mutableAttributedString = NSMutableAttributedString()
        mutableAttributedString.append(firstLine)
        
        let label1 = SKLabelNode(attributedText: mutableAttributedString)
        label1.horizontalAlignmentMode = .left
        label1.verticalAlignmentMode = .center
        label1.position = CGPoint(x: -45, y: 45)
        label1.zRotation = -CGFloat(Double.pi/8) * CGFloat(-5.5)
        label1.numberOfLines = 0
        label1.lineBreakMode = .byWordWrapping
        
        segment1.addChild(label1)
        segment1.fillColor = UIColor(red: CGFloat(223) / 255.0, green: CGFloat(130) / 255.0, blue: CGFloat(128) / 255.0, alpha: 1)
        segments.append(segment1)
        wheel.addChild(segment1)
        
        
        // MARK: Segment 2
        let segment2 = SKShapeNode(path: createSegmentPath(start: CGFloat(45 + 20), end: CGFloat(2 * 45 + 20)))
        let firstLine2 = NSAttributedString(string: "\(self.viewController!.segmentText[1])", attributes: attributes)
        let mutableAttributedString2 = NSMutableAttributedString()
        mutableAttributedString2.append(firstLine2)
        
        let label2 = SKLabelNode(attributedText: mutableAttributedString2)
        label2.zRotation = -CGFloat(Double.pi/8) * CGFloat(-3.5)
        label2.horizontalAlignmentMode = .left
        label2.verticalAlignmentMode = .center
        label2.position = CGPoint(x: -5, y: 60)
        label2.numberOfLines = 0
        label2.lineBreakMode = .byWordWrapping
        
        segment2.addChild(label2)
        segment2.fillColor = UIColor(red: CGFloat(248) / 255.0, green: CGFloat(224) / 255.0, blue: CGFloat(144) / 255.0, alpha: 1)
        segments.append(segment2)
        wheel.addChild(segment2)
        
        
        // MARK: Segment 3
        let segment3 = SKShapeNode(path: createSegmentPath(start: CGFloat(0 + 20), end: CGFloat(45 + 20)))
        let firstLine3 = NSAttributedString(string: "\(self.viewController!.segmentText[2])", attributes: attributes)
        let mutableAttributedString3 = NSMutableAttributedString()
        mutableAttributedString3.append(firstLine3)
        
        let label3 = SKLabelNode(attributedText: mutableAttributedString3)
        label3.zRotation = -CGFloat(Double.pi/8) * CGFloat(-1.5)
        label3.horizontalAlignmentMode = .left
        label3.verticalAlignmentMode = .center
        label3.position = CGPoint(x: 45, y: 45)
        label3.numberOfLines = 0
        label3.lineBreakMode = .byWordWrapping
        segment3.addChild(label3)
        segment3.fillColor = UIColor(red: CGFloat(112) / 255.0, green: CGFloat(207) / 255.0, blue: CGFloat(146) / 255.0, alpha: 1)
        segments.append(segment3)
        wheel.addChild(segment3)
        
        
        // MARK: Segment 4
        let segment4 = SKShapeNode(path: createSegmentPath(start: 7 * CGFloat(45) + 20, end: 8 * CGFloat(45) + 20))
        let firstLine4 = NSAttributedString(string: "\(self.viewController!.segmentText[3])", attributes: attributes)
        let mutableAttributedString4 = NSMutableAttributedString()
        mutableAttributedString4.append(firstLine4)
        
        let label4 = SKLabelNode(attributedText: mutableAttributedString4)
        label4.zRotation = -CGFloat(Double.pi/8) * CGFloat(0)
        label4.horizontalAlignmentMode = .left
        label4.verticalAlignmentMode = .center
        label4.position = CGPoint(x: 60, y: -5)
        label4.numberOfLines = 0
        label4.lineBreakMode = .byWordWrapping
        segment4.addChild(label4)
        segment4.fillColor = UIColor(red: CGFloat(142) / 255.0, green: CGFloat(176) / 255.0, blue: CGFloat(218) / 255.0, alpha: 1)
        segments.append(segment4)
        wheel.addChild(segment4)
        
        
        // MARK: Segment 5
        let segment5 = SKShapeNode(path: createSegmentPath(start: CGFloat(6 * 45 + 20), end: CGFloat(7 * 45 + 20)))
        let firstLine5 = NSAttributedString(string: "\(self.viewController!.segmentText[4])", attributes: attributes)
        let mutableAttributedString5 = NSMutableAttributedString()
        mutableAttributedString5.append(firstLine5)
        
        let label5 = SKLabelNode(attributedText: mutableAttributedString5)
        label5.zRotation = -CGFloat(Double.pi/8) * CGFloat(2.5)
        label5.horizontalAlignmentMode = .left
        label5.verticalAlignmentMode = .center
        label5.position = CGPoint(x: 45, y: -45)
        label5.numberOfLines = 0
        label5.lineBreakMode = .byWordWrapping
        segment5.addChild(label5)
        segment5.fillColor = UIColor(red: CGFloat(223) / 255.0, green: CGFloat(130) / 255.0, blue: CGFloat(128) / 255.0, alpha: 1)
        segments.append(segment5)
        wheel.addChild(segment5)
        
        
        // MARK: Segment 6
        let segment6 = SKShapeNode(path: createSegmentPath(start: CGFloat(5 * 45 + 20), end: CGFloat(6 * 45 + 20)))
        let firstLine6 = NSAttributedString(string: "\(self.viewController!.segmentText[5])", attributes: attributes)
        let mutableAttributedString6 = NSMutableAttributedString()
        mutableAttributedString6.append(firstLine6)
        
        let label6 = SKLabelNode(attributedText: mutableAttributedString6)
        label6.zRotation = -CGFloat(Double.pi/8) * CGFloat(4.5)
        label6.horizontalAlignmentMode = .left
        label6.verticalAlignmentMode = .center
        label6.position = CGPoint(x: -5, y: -60)
        label6.numberOfLines = 0
        label6.lineBreakMode = .byWordWrapping
        segment6.addChild(label6)
        segment6.fillColor = UIColor(red: CGFloat(248) / 255.0, green: CGFloat(224) / 255.0, blue: CGFloat(144) / 255.0, alpha: 1)
        segments.append(segment6)
        wheel.addChild(segment6)
        
        
        // MARK: Segment 7
        let segment7 = SKShapeNode(path: createSegmentPath(start: 4 * CGFloat(45) + 20, end: 5 * CGFloat(45) + 20))
        let firstLine7 = NSAttributedString(string: "\(self.viewController!.segmentText[6])", attributes: attributes)
        let mutableAttributedString7 = NSMutableAttributedString()
        mutableAttributedString7.append(firstLine7)
        
        let label7 = SKLabelNode(attributedText: mutableAttributedString7)
        label7.zRotation = -CGFloat(Double.pi/8) * CGFloat(6)
        label7.horizontalAlignmentMode = .left
        label7.verticalAlignmentMode = .center
        label7.position = CGPoint(x: -45, y: -45)
        label7.numberOfLines = 0
        label7.lineBreakMode = .byWordWrapping
        segment7.addChild(label7)
        segment7.fillColor = UIColor(red: CGFloat(112) / 255.0, green: CGFloat(207) / 255.0, blue: CGFloat(146) / 255.0, alpha: 1)
        segments.append(segment7)
        wheel.addChild(segment7)
        
        
        // MARK: Segment 8
        let segment8 = SKShapeNode(path: createSegmentPath(start: 3 * CGFloat(45) + 20, end: 4 * CGFloat(45) + 20))
        let firstLine8 = NSAttributedString(string: "\(self.viewController!.segmentText[7])", attributes: attributes)
        let mutableAttributedString8 = NSMutableAttributedString()
        mutableAttributedString8.append(firstLine8)
        
        let label8 = SKLabelNode(attributedText: mutableAttributedString8)
        label8.zRotation = -CGFloat(Double.pi/8) * CGFloat(8)
        label8.horizontalAlignmentMode = .left
        label8.verticalAlignmentMode = .center
        label8.position = CGPoint(x: -60, y: 5)
        label8.numberOfLines = 0
        label8.lineBreakMode = .byWordWrapping
        segment8.addChild(label8)
        segment8.fillColor = UIColor(red: CGFloat(142) / 255.0, green: CGFloat(176) / 255.0, blue: CGFloat(218) / 255.0, alpha: 1)
        segments.append(segment8)
        wheel.addChild(segment8)
        
        
        // MARK: Center img
        centerImage = SKSpriteNode(imageNamed: "wheelCenter.png")
        centerImage.size = CGSize(width: 30, height: 30)
        centerImage.position = CGPoint(x: 0, y: 0)
        centerImage.zPosition = 1
        wheel.addChild(centerImage)
    }
    
    // Function to create a segment path
    func createSegmentPath(start: CGFloat, end: CGFloat) -> CGPath {
        let center = CGPoint(x: 0, y: 0)
        let path = UIBezierPath(arcCenter: center, radius: viewSize - CGFloat(20), startAngle: start * CGFloat.pi / 180, endAngle: end * CGFloat.pi / 180, clockwise: true)
        path.addLine(to: center)
        path.close()
        return path.cgPath
    }
    
    func createSegmentPath2(start: CGFloat, end: CGFloat) -> CGPath {
        let path = CGMutablePath()
        path.addArc(center: CGPoint(x: 0, y: 0), radius: viewSize - CGFloat(15), startAngle: start * CGFloat.pi / 180, endAngle: end * CGFloat.pi / 180, clockwise: true)
        path.addLine(to: .zero)
        path.closeSubpath()
        return path
    }
    
    func createSegmentPath3(start: CGFloat, end: CGFloat) -> CGPath {
        let path = CGMutablePath()
        path.addArc(center: CGPoint(x: 0, y: 0), radius: viewSize - CGFloat(5), startAngle: start * CGFloat.pi / 180, endAngle: end * CGFloat.pi / 180, clockwise: true)
        path.addLine(to: .zero)
        path.closeSubpath()
        return path
    }
    
    func createSegmentPath4(start: CGFloat, end: CGFloat) -> CGPath {
        let path = CGMutablePath()
        path.addArc(center: CGPoint(x: 0, y: 0), radius: viewSize, startAngle: start * CGFloat.pi / 180, endAngle: end * CGFloat.pi / 180, clockwise: true)
        path.addLine(to: .zero)
        path.closeSubpath()
        return path
    }
    
    private func rotateSet(duration: Double, timingMode: SKActionTimingMode){
        let spin = SKAction.rotate(byAngle: -.pi * 2, duration: TimeInterval(duration))
        spin.timingMode = timingMode
        wheel.run(spin)
    }
    
    // Stopping random
    private func randomRotate(duration: Double, timingMode: SKActionTimingMode){
        let random = Float(Int.random(in: 0...8)) * (.pi / 4)
        let spin = SKAction.rotate(byAngle: CGFloat(random), duration: TimeInterval(duration))
        spin.timingMode = timingMode
        
        wheel.run(spin) {
            self.viewController?.showAlert("\(self.viewController!.segmentText[self.viewController!.firstPiece])")
        }
        
        if random == 2.3561945 {
            self.viewController?.firstPiece += 3
            
        } else if random == 5.497787 {
            self.viewController?.firstPiece += 7
            
        } else if random == 3.9269905 {
            self.viewController?.firstPiece += 5
            
        } else if random == 4.712389 {
            self.viewController?.firstPiece += 6
            
        } else if random == 0.7853981 {
            self.viewController?.firstPiece += 1
            
        } else if random == 3.1415925 {
            self.viewController?.firstPiece += 4
            
        } else if random == 1.5707963 {
            self.viewController?.firstPiece += 2
            
        }

        if (self.viewController?.firstPiece)! > 7 {
            self.viewController?.firstPiece = self.viewController!.firstPiece % 8
        }
        
        self.viewController?.discount = self.viewController!.segmentText[self.viewController!.firstPiece]
    }
    
    // Rotate settings
    @objc func startRotation() {
        rotateSet(duration: 2, timingMode: .easeIn)
        rotateSet(duration: 1.5, timingMode: .linear)
        rotateSet(duration: 1.3, timingMode: .linear)
        rotateSet(duration: 1.5, timingMode: .linear)
        rotateSet(duration: 1.75, timingMode: .linear)
        rotateSet(duration: 2, timingMode: .linear)
        rotateSet(duration: 2.75, timingMode: .easeInEaseOut)
        rotateSet(duration: 3, timingMode: .easeInEaseOut)
        rotateSet(duration: 4, timingMode: .easeInEaseOut)
        rotateSet(duration: 5, timingMode: .easeInEaseOut)
        rotateSet(duration: 6, timingMode: .easeInEaseOut)
        randomRotate(duration: 7, timingMode: .easeInEaseOut)
            
        self.byAngle = wheel.zPosition
    }
}

