//
//  PageViewUI.swift
//  Gank.lu
//
//  Created by Lei Pan on 2020/3/24.
//  Copyright © 2020 smartalker. All rights reserved.
//

import SwiftUI
import UIKit
import struct Kingfisher.KFImage

struct PageViewUI: UIViewControllerRepresentable {
  var controllers: [UIViewController]
  @Binding var currentPage: Int

  func makeCoordinator() -> PageViewUI.Coordinator {
    Coordinator(self)
  }

  func makeUIViewController(context: Context) -> UIPageViewController {
    let pageViewController = UIPageViewController(
      transitionStyle: .scroll,
      navigationOrientation: .horizontal)
    pageViewController.dataSource = context.coordinator
    pageViewController.delegate = context.coordinator
    return pageViewController
  }

  func updateUIViewController(_ pageViewController: UIPageViewController, context: Context) {
    pageViewController.setViewControllers(
      [controllers[currentPage]], direction: .forward, animated: true)
  }

  class Coordinator: NSObject, UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    var parent: PageViewUI

    init(_ pageViewUI: PageViewUI) {
      self.parent = pageViewUI
    }

    func pageViewController(
      _ pageViewController: UIPageViewController,
      viewControllerBefore viewController: UIViewController) -> UIViewController?
    {
      guard let index = parent.controllers.firstIndex(of: viewController) else {
        return nil
      }
      if index == 0 {
        return parent.controllers.last
      }
      return parent.controllers[index - 1]
    }

    func pageViewController(
      _ pageViewController: UIPageViewController,
      viewControllerAfter viewController: UIViewController) -> UIViewController?
    {
      guard let index = parent.controllers.firstIndex(of: viewController) else {
        return nil
      }
      if index + 1 == parent.controllers.count {
        return parent.controllers.first
      }
      return parent.controllers[index + 1]
    }

    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
      if completed,
        let visibleViewController = pageViewController.viewControllers?.first,
        let index = parent.controllers.firstIndex(of: visibleViewController)
      {
        parent.currentPage = index
      }
    }
  }
}

struct BannerCard: View {
  var url: String
  var title: String
  init(url: String, title: String) {
    self.url = url
    self.title = title
  }

  var body: some View {
    HStack {
      ZStack(alignment: .bottomLeading) {
        KFImage(URL(string: url))
          .resizable()
          .aspectRatio(contentMode: .fill)
          .frame(height: 180)
        LinearGradient(gradient: Gradient(colors: [.clear, Color.black.opacity(0.6)]), startPoint: .top, endPoint: .bottom)
          .cornerRadius(16)
        Text(title).font(.headline)
          .fontWeight(.semibold)
          .padding(EdgeInsets.init(top: 0, leading: 16, bottom: 32, trailing: 16)).foregroundColor(.white)
      }
      .cornerRadius(16)
      .shadow(radius: 4)
    }.padding(.horizontal)

  }
}

struct PageView<Page: View>: View {
  var viewControllers: [UIHostingController<Page>]
  @State var currentPage = 0

  init(_ views: [Page]) {
    self.viewControllers = views.map { UIHostingController(rootView: $0) }
  }

  var body: some View {
    ZStack(alignment: .bottom) {
      PageViewUI(controllers: viewControllers, currentPage: $currentPage)
        .frame(height: 188)
      PageControl(numberOfPages: viewControllers.count, currentPage: $currentPage)
        .padding(.trailing)
    }
  }
}

var features = [1, 2, 3]

struct PageView_Previews: PreviewProvider {
  static var previews: some View {
    PageView(features.map { _ in BannerCard(url: "", title: "-念念不忘，必有回响, -念念不忘，必有回响") })
  }
}
