//
//  RootTabView.swift
//  Gank.lu
//
//  Created by Lei Pan on 2020/1/29.
//  Copyright © 2020 smartalker. All rights reserved.
//

import SwiftUI

struct RootTabView: View {
  @ObservedObject var observed = BannerObserver()
  @ObservedObject var gankObserved = GankObserver()

  var body: some View {
    ScrollView {
      ZStack(alignment: .bottomLeading) {
        if observed.banners.isEmpty {
          Text("loading...").frame(maxWidth: .infinity)
        } else {
          PageView(observed.banners.map { BannerCard(url: $0.image, title: $0.title)})
        }
      }.onAppear {
        self.observed.fetchBanners()
        self.gankObserved.fetchGanks()
      }
      ForEach(gankObserved.ganks, id: \.self) { gank in
        HStack {
          if gank.type == "Girl" {
            GirlView(gank: gank).frame(height: 340)
          } else {
            GankView(gank: gank).frame(height: 120)
          }
        }.padding(EdgeInsets(top: 12, leading: 16, bottom: 0, trailing: 16))
      }
      if !gankObserved.ganks.isEmpty {
        Button(action: self.gankObserved.fetchGanks) {
          Text("load more")
        }.padding(16)
      }
    }
  }
}

struct RootTabView_Previews: PreviewProvider {
  static var previews: some View {
    RootTabView()
  }
}
