//
//  File.swift
//  
//
//  Created by boyer on 2021/12/24.
//

import Foundation
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
