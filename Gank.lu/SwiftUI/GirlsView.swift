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

  let gank: GankData

  init(gank: GankData) {
    self.gank = gank
  }

  var body: some View {
    ZStack {
      KFImage(URL(string: gank.url))
        .resizable()
        .aspectRatio(contentMode: .fill)
        .frame(height: 340)
        .clipped()
      LinearGradient(gradient: Gradient(colors: [Color.black.opacity(0.3), Color.black.opacity(0.3)]), startPoint: .top, endPoint: .bottom)
      VStack(alignment: .leading) {
        HStack {
          Text(gank.type)
            .foregroundColor(.white)
            .font(.custom("", size: 12))
            .padding(EdgeInsets(top: 4, leading: 8, bottom: 4, trailing: 8))
            .background(Color.blue)
            .cornerRadius(4)
          Text(gank.title).foregroundColor(.white)
          Spacer()
          Text("5天前").foregroundColor(.white)
        }.padding(EdgeInsets(top: 16, leading: 16, bottom: 4, trailing: 16)).shadow(radius: 4)
        Spacer()
        Text("\(gank.desc) by \(gank.author)")
          .frame(maxWidth: .infinity)
          .foregroundColor(.white)
          .multilineTextAlignment(.leading)
          .padding(16)
          .shadow(radius: 4)
      }
    }
    .background(Color.white)
    .cornerRadius(16)
    .shadow(radius: 4)
  }
}
