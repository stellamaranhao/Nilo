import CoreMotion
import SwiftUI


struct ParallaxMotionModifier: ViewModifier {
    
    @ObservedObject var manager: MotionManager
    var magnitude: Double
    //TODO: Animacao de flutuando continua | Sombra responder a isso | Sem
    func body(content: Content) -> some View {
        content
            .rotation3DEffect(.degrees(-manager.roll*magnitude*0.3), axis: (x: 0, y: 1, z: 0))
//            .rotation3DEffect(.degrees(-manager.pitch*magnitude), axis: (x: 1, y: 0, z: 0))
            .offset(x: 0, y: CGFloat(manager.pitch * magnitude))
    }
}

class MotionManager: ObservableObject {
    
    @Published var pitch: Double = 0.0
    @Published var roll: Double = 0.0
    
    private var manager: CMMotionManager
    
    init() {
        self.manager = CMMotionManager()
        self.manager.deviceMotionUpdateInterval = 1/60
        self.manager.startDeviceMotionUpdates(to: .main) { (motionData, error) in
            guard error == nil else {
                print(error!)
                return
            }
            
            if let motionData = motionData {
                self.pitch = motionData.attitude.pitch
                self.roll = motionData.attitude.roll
            }
        }
        
    }
}
