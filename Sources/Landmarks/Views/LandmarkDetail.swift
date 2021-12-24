//
//  LandmarkDetail.swift
//  iHacker
//
//  Created by boyer on 2021/12/22.
//

import SwiftUI
import MapKit
import Combine

struct LandmarkDetail: View {
    
    var landmark:Landmark
    
    // 访问环境对象，便于$绑定操作
    @EnvironmentObject var modelData:ModelData
    
    // 已知一个对象，求在数组中的索引
    var landmarkIndex:Int{
        modelData.landmarks.firstIndex(where: { $0.id == landmark.id})!
    }
    
    var body: some View {
        ScrollView {
            MapView(coordinate: landmark.locationCoordinate)
                .frame(height: 300, alignment: .top)
                .ignoresSafeArea()
            CircleImage(image: landmark.image)
                .offset(y: -120)
                .padding(.bottom,-120)
            
            VStack(alignment: .leading){
                
                HStack{
                    Text(landmark.name)
                        .font(.title)
                    // 订阅存储器时，无法通过LandmarkDetail_Previews单独预览,
                    //必须在预览中装载环境数据.environmentObject(ModelData())或通过点击列表进入详情，否则会崩溃。
                    FavoriteButton(isSet: $modelData.landmarks[landmarkIndex].isFavorite)
//                    FavoriteButton(isSet:.constant(false))
                }
                
                HStack{
                    Text(landmark.park)
                    Spacer()
                    Text(landmark.state)
                }
                .font(.subheadline)
                .foregroundColor(.secondary)
                
                Divider()
                
                Text("关于\(landmark.name)")
                    .font(.title2)
                Text(landmark.description)
            }.padding()
            
        }
        .navigationTitle(landmark.name)
        .navigationBarTitleDisplayMode(.inline)
        
    }
}

struct LandmarkDetail_Previews: PreviewProvider {
    static var previews: some View {
        LandmarkDetail(landmark: ModelData().landmarks[1]).environmentObject(ModelData())
    }
}
