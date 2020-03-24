//
//  GirlsView.swift
//  Gank.lu
//
//  Created by Lei Pan on 2020/1/29.
//  Copyright © 2020 smartalker. All rights reserved.
//

import SwiftUI
import struct Kingfisher.KFImage

struct GirlView: View {
    var body: some View {
      VStack {
        HStack {
          Text("Meizi")
            .foregroundColor(.white)
            .font(.custom("", size: 12))
            .padding(EdgeInsets(top: 4, leading: 8, bottom: 4, trailing: 8))
            .background(Color.blue)
            .cornerRadius(4)
          Text("妹子图第29期")
          Spacer()
          Text("5天前")
        }.padding(EdgeInsets(top: 16, leading: 16, bottom: 4, trailing: 16)).shadow(radius: 4)
        KFImage(URL(string: "https://puui.qpic.cn/fans_admin/0/3_1680187318_1582642088791/0"))
        .resizable()
        .aspectRatio(contentMode: .fill)
        .frame(height: 280)
        .clipped()
        Text("如花美眷，似水流年，回得了过去，回不了当初。 by 鸢媛").padding(16).shadow(radius: 4)
      }
      .background(Color.white)
      .cornerRadius(16)
      .shadow(radius: 4)
    }
}

struct GirlsView_Previews: PreviewProvider {
    static var previews: some View {
        GirlView()
    }
}
