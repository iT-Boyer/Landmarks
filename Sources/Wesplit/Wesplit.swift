//
//  ContentView.swift
//  Wesplit
//
//  Created by boyer on 2021/4/11.
//
import SwiftUI
/*
 需求：通过人数，小费比率，和总额，来计算发票的实际额度
 新增三个变量：存储三个属性值，小费比率用数组来存储。
 第一步先总额输入框：
 第二步创建选择器：显示人数
 第三步添加百分比控件
 第四步计算总数：
 挑战
 最好的学习方法之一是尽可能频繁地编写自己的代码，因此，您应该尝试以下三种方式扩展此应用程序，以确保您完全了解正在发生的事情：

 在第三部分中添加标题，即“每人的金额”
 添加另一部分以显示支票的总金额，即原始金额加小费值，而不用人数来划分。
 将“人数”选择器更改为文本字段，确保使用正确的键盘类型。
 */
public struct Wesplit: View {
    @State private var checkAmount = ""
    @State private var numberOfPeople = 2
    @State private var tipPercentage = 2
    private var tipPercentages = [10,15,20,30,50,0]
    
    // 构造器必须public
    public init() {}
    
    var totalPerPerson: Double {
        let peopleCount = Double(numberOfPeople + 2)
        let tipSelection = Double(tipPercentages[tipPercentage])
        let orderAmount = Double(checkAmount) ?? 0

        let tipValue = orderAmount / 100 * tipSelection
        let grandTotal = orderAmount + tipValue
        let amountPerPerson = grandTotal / peopleCount

        return amountPerPerson
    }

    public var body: some View {
        VStack
        {
            NavigationView {
                Form {
                    Section {
                        TextField("菜单总价：", text: $checkAmount)
                            .keyboardType(.decimalPad)
                    }
                    Section {
                        Picker("用餐人数：", selection: $numberOfPeople) {
                            ForEach(2..<100) {
                                Text("\($0)个人")
                            }
                        }
                    }
                    Section(header: Text("你想给多少小费？")) {
                        Picker("小费：", selection: $tipPercentage) {
                            ForEach(0..<tipPercentages.count) {
                                Text("\(self.tipPercentages[$0])%")
                            }
                        }.pickerStyle(SegmentedPickerStyle())
                    }
                    
                    Section {
                        Text("总金额：\(totalPerPerson,specifier: "%.2f")")
                            .foregroundColor(self.tipPercentage==self.tipPercentages.count-1 ? .red:.black)
                    }
                }
                .navigationBarTitle("Wesplit")
                //.onAppear(perform: UIApplication.shared.addTapGestureRecognizer)
            }
        }
    }
}

struct Wesplit_Previews: PreviewProvider {
    static var previews: some View {
        Wesplit()
    }
}


#if canImport(UIKit)
extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
#endif
