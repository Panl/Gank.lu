//
//  GirlsView.swift
//  Gank.lu
//
//  Created by Lei Pan on 2020/1/29.
//  Copyright © 2020 smartalker. All rights reserved.
//

import SwiftUI
import struct Kingfisher.KFImage
import struct Kingfisher.DownsamplingImageProcessor

extension View {
  func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
    clipShape( RoundedCorner(radius: radius, corners: corners) )
  }
}

struct RoundedCorner: Shape {

  var radius: CGFloat = .infinity
  var corners: UIRectCorner = .allCorners

  func path(in rect: CGRect) -> Path {
    let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
    return Path(path.cgPath)
  }
}

struct GirlView: View {

  let gank: GankData

  init(gank: GankData) {
    self.gank = gank
  }

  var body: some View {
    ZStack(alignment: .topLeading) {
      KFImage(URL(string: gank.url),options: [
          .transition(.fade(0.8)),
          .processor(
            DownsamplingImageProcessor(size: CGSize(width: 375 * 1.5, height: 340 * 1.5))
          ),
          .cacheOriginalImage
      ])
        .resizable()
        .aspectRatio(contentMode: .fill)
        .frame(height: 340)
        .clipped()
      LinearGradient(gradient: Gradient(colors: [Color.black.opacity(0.3), Color.black.opacity(0.3)]), startPoint: .top, endPoint: .bottom)
      Text(gank.type)
      .foregroundColor(.white)
      .font(.custom("", size: 12))
      .padding(EdgeInsets(top: 6, leading: 12, bottom: 6, trailing: 8))
      .background(Color.blue)
        .cornerRadius(8, corners: .bottomRight)
      VStack(alignment: .leading) {
        Spacer()
        Text("\(gank.desc) by \(gank.author)")
          .frame(maxWidth: .infinity)
          .foregroundColor(.white)
          .multilineTextAlignment(.leading)
          .padding(12)
          .shadow(radius: 4)
        HStack {
          Text(gank.title).foregroundColor(.white)
          Spacer()
          Text(DateUtil.stringToRelative(gank.publishedAt)).font(.system(size: 12)).foregroundColor(.white)
        }.padding(EdgeInsets(top: 8, leading: 16, bottom: 16, trailing: 16)).shadow(radius: 4)
      }
    }
    .background(Color.white)
    .cornerRadius(16)
    .shadow(radius: 4)
  }
}

struct GankView: View {
  let gank: GankData

  init(gank: GankData) {
    self.gank = gank
  }

  var body: some View {
    HStack {
      ZStack(alignment: .topLeading){
        KFImage(URL(string: gank.images.first ?? gank.url),options: [
            .transition(.fade(0.2)),
            .processor(
              DownsamplingImageProcessor(size: CGSize(width: 120 * 3, height: 120 * 3))
            ),
            .cacheOriginalImage
        ])
          .resizable()
          .aspectRatio(contentMode: .fill)
          .frame(width: 120, height: 120)
          .background(Color.gray)
          .clipped()
        Text(gank.type)
          .foregroundColor(.white)
          .font(.custom("", size: 12))
          .padding(EdgeInsets(top: 6, leading: 12, bottom: 6, trailing: 8))
          .background(Color.blue)
          .cornerRadius(8, corners: .bottomRight)

      }
      VStack(alignment: .leading) {
        Text(gank.title).font(.system(size: 16)).padding(EdgeInsets(top: 8, leading: 4, bottom: 8, trailing: 12))
        Text(gank.desc)
          .font(.system(size: 13))
          .foregroundColor(.gray)
          .frame(maxWidth: .infinity)
          .multilineTextAlignment(.leading)
          .padding(EdgeInsets(top: 0, leading: 4, bottom: 4, trailing: 12))
        Spacer()
        HStack {
          Text(gank.author).font(.system(size: 13))
          Spacer()
          Text(DateUtil.stringToRelative(gank.publishedAt)).font(.system(size: 12)).foregroundColor(.gray)
        }.padding(EdgeInsets(top: 0, leading: 4, bottom: 8, trailing: 12))
      }
    }
    .background(Color.white)
    .cornerRadius(16)
    .shadow(radius: 4)
  }
}
