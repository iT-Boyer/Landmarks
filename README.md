# apple官方demo练习总结
https://developer.apple.com/tutorials/swiftui

## 把列表中的数据传入详情页展示
1. 地址信息 -- 更新地图
2. 头像信息 -- 更新头像
3. 姓名 -- 更新姓名
...

在View视图中添加接收参数的属性，并更新UI展示。
1. 头像：图片实例
2. 地图：坐标 

https://developer.apple.com/sf-symbols/

### 视图创建 创建View和多个视图组合布局
1. body视图结构和xcode即时预览
2. Text/Label 视图使用修改器定制样式
3. HStack/VStack/ZStack 视图布局容器
4. Group等 修改器会作用到所有的子视图上

### 列表和导航使用
1. 列表组合/ForEach数据对象返回视图组
    List() 视图 struct init构造器的入参：Identifiable
2. 给视图添加点击事件的控件
    NavigationLink：点击事件
3. 系统导航栏+标题实现
    NavigationView：导航条
### 用户交互
1. 仅展示收藏列表
    1. 修改@state属性，视图使用$语法监听属性变更，出发视图刷新。响应式UI刷新。
2. 详情页面收藏+更新列表状态

## 官方习题

### Which of the following passes data downward in the view hierarchy?

You use this attribute in views that are lower down in the view hierarchy to receive data from views that are higher up.

You apply this modifier so that views further down in the view hierarchy can read data objects passed down through the environment.


### What’s the role of a binding?
绑定的作用是什么？

It’s a value and a way to change that value.
A binding controls the storage for a value, so you can pass data around to different views that need to read or write it.

It’s a way to link a pair of views together to ensure that they receive the same data.

You can use bindings to plumb data throughout your app’s views; bindings aren’t limited to just two views.


It’s a way to freeze a value temporarily so that other views don’t update during state transitions.

A binding doesn’t prevent updates. Instead, it propagates updates to different views in your app.


### Which is the correct way to create state for a view?

@State var showFavoritesOnly = false
Always mark state properties as private because state should be specific to a view and its child views.

@State private var showFavoritesOnly = false
Use the @State property wrapper to mark a value as state, declare the property as private, and give it a default value.


## 封装Package相关问题

### 创建swiftPM库
```sh
swift package init --type library
```
初始化无法在iOS设备或模拟器上编译，需要设置Package支持平台： `platforms: [.iOS(.v15)],`。

### 构造器public
```swift
public struct LandmarksApp:View {
    @StateObject private var modelData = ModelData()
    
    public init() {
        
    }
    
    public var body: some View{
        LandmarkList().environmentObject(modelData)
    }
}
```




### SwiftPM资源管理
https://www.jianshu.com/p/44560fd214d2#f35b6207-3e44-ab92-ee76-769d436721ba
```
            resources: [
                .copy("Resources/landmarkData.json")
            ]
```
1. 对于 Media.xcasset 和 main.storyboard 文件，Xcode 能明确知道它代表什么，所以不需要在这个配置文件中标记
2. internal Note.txt 文件和 Artwork Creation 文件夹是模块内部文件，所以写在 target 的 exclude 属性中，这样 Xcode 就不会把它编译到包里
3. 其他不能自动识别的类型并且需要被加载到 package 里的文件则配置在 resource 属性中。

### 访问swiftPM内部资源

`Bundle.module`: 为当前Package的bundle资源库

1. 加载图片
```swift
Image("turtlerock", bundle: Bundle.module)
```

1. 加载文件 json
```swift
guard let file = Bundle.module.url(forResource: filename, withExtension: nil)
else{
    fatalError("加载 \(filename)失败")
}
```



### 详情页面预览崩溃
 订阅存储器时，无法通过LandmarkDetail_Previews单独预览,必须在预览中装载环境数据.environmentObject(ModelData())或通过点击列表进入详情，否则会崩溃。


## 集成Quick进行单元测试
 在SwiftPM管理项目时，不需要生成xcodeproj功能文件，也可以进行单元测试。
 在Package.swift文件中添加以来库
 ```swift
        .package(name: "Quick", path: "/Users/boyer/hsg/Quick"),
        .package(name: "Nimble", path: "/Users/boyer/hsg/Nimble"),
 ```
 添加targetTest依赖
 ```swift
         .testTarget(
            name: "LandmarksTests",
            dependencies: ["Landmarks","Quick","Nimble"]),
 ``` 
 然后在新建一个Quick模版测试类,引入Quick和@testable impor 测试库
 ```swift
 import Quick

@testable import Landmarks

class QuickTests: QuickSpec {
    override func spec() {
        describe("文件加载方式验证") {
            fit("加载app中的json文件") {
                let json:[Landmark] = loadT("landmarkData.json")
                print("json:\(json[0])")
            }
        }
    }
}
 ```
 这样就可以轻松测试了。
