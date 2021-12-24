import SwiftUI
public struct Landmarks:View {
    public private(set) var text = "Hello, World!"

    // 注解为存储器状态属性，便于装载swiftUI环境。
    @StateObject private var modelData = ModelData()
    
    // 构造器必须public
    public init() {
        
    }
    
    // 属性必须public
    public var body: some View{
        LandmarkList().environmentObject(modelData)
    }
}


struct LandmarksApp_Previews: PreviewProvider {
    static var previews: some View {
        Landmarks()
    }
}
