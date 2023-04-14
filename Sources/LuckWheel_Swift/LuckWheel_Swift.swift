public struct LuckWheel_Swift {
    
    let luckWheelVC: LuckWheelVC?
    
    public init() {
        luckWheelVC =  LuckWheelVC()
    }
    
    public func turnWheel(title1: String, title2: String, title3: String, title4: String, title5: String, title6: String, title7: String, title8: String) {
        
        luckWheelVC!.segmentText = [title1, title2, title3, title4, title5, title6, title7, title8]
        luckWheelVC!.playScene?.startRotation()
    }
}
