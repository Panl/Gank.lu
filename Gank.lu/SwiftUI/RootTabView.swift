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

  init() {
    UITableView.appearance().tableFooterView = UIView()
    UITableView.appearance().separatorStyle = .none
    self.observed.fetchBanners()
    self.gankObserved.fetchGanks()
  }

  var body: some View {
    List {
      ZStack(alignment: .bottomLeading) {
        if observed.banners.isEmpty {
          Text("loading...").frame(maxWidth: .infinity)
        } else {
          PageView(observed.banners.map { BannerCard(url: $0.image, title: $0.title)})
        }
      }.listRowInsets(EdgeInsets())
      ForEach(gankObserved.ganks, id: \.self) { gank in
        HStack {
          if gank.type == "Girl" {
            GirlView(gank: gank).frame(height: 340)
          } else {
            GankView(gank: gank).frame(height: 120)
          }
          }.padding(EdgeInsets(top: 6, leading: 16, bottom: 6, trailing: 16))
          .listRowInsets(EdgeInsets())
      }
      if !gankObserved.ganks.isEmpty {
        Rectangle()
          .fill(Color.clear).onAppear {
          self.gankObserved.fetchGanks()
        }
      }
    }
  }

}

struct RootTabView_Previews: PreviewProvider {
  static var previews: some View {
    RootTabView()
  }
}
