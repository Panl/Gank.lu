//
//  RootTabView.swift
//  Gank.lu
//
//  Created by Lei Pan on 2020/1/29.
//  Copyright © 2020 smartalker. All rights reserved.
//

import SwiftUI

struct RootTabView: View {

  var body: some View {
    TabView {
      TodayListView()
        .tabItem {
          VStack {
            Image(systemName: "paperplane")
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
