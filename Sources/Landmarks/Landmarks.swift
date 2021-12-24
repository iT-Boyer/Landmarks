import SwiftUI
public struct Landmarks {
    public private(set) var text = "Hello, World!"

    public init() {
        
    }
}

public struct LandmarksApp:View {
    @StateObject private var modelData = ModelData()
    
    public init() {
        
    }
    
    public var body: some View{
        LandmarkList().environmentObject(modelData)
    }
}


struct LandmarksApp_Previews: PreviewProvider {
    static var previews: some View {
        LandmarksApp()
    }
}
