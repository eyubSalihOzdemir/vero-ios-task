//
//  DrawerView.swift
//  vero-ios-task
//
//  Created by Salih Özdemir on 22.11.2023.
//

import SwiftUI

struct Drawer<Menu: View, Content: View>: View {
  @Binding private var isOpened: Bool
  private let menu: Menu
  private let content: Content

  // MARK: - Init
  public init(
    isOpened: Binding<Bool>,
    @ViewBuilder menu:  () -> Menu,
    @ViewBuilder content: () -> Content
  ) {
    _isOpened = isOpened
    self.menu = menu()
    self.content = content()
  }

  // MARK: - Body
  public var body: some View {
    ZStack(alignment: .trailing) {
      content

      if isOpened {
        Color.clear.contentShape(Rectangle())
              .onTapGesture {
                  if isOpened {
                      isOpened.toggle()
                  }
              }
          
        menu
              .transition(.move(edge: .trailing))
              .zIndex(1)
      }
    }
    .animation(.spring(), value: isOpened)
  }
}
