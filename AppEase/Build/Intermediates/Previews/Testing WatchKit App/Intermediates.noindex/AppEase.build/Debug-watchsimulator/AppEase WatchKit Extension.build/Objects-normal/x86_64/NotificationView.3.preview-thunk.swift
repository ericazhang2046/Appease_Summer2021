@_private(sourceFile: "NotificationView.swift") import AppEase_WatchKit_Extension
import SwiftUI
import SwiftUI

extension NotificationView_Previews {
    @_dynamicReplacement(for: previews) private static var __preview__previews: some View {
        #sourceLocation(file: "/Users/taehyo/Documents/GitHub/AppEase/AppEase/AppEase WatchKit Extension/NotificationView.swift", line: 18)
        AnyView(__designTimeSelection(NotificationView(), "#3979.[2].[0].property.[0].[0]"))
    #sourceLocation()
    }
}

extension NotificationView {
    @_dynamicReplacement(for: body) private var __preview__body: some View {
        #sourceLocation(file: "/Users/taehyo/Documents/GitHub/AppEase/AppEase/AppEase WatchKit Extension/NotificationView.swift", line: 12)
        AnyView(__designTimeSelection(Text(__designTimeString("#3979.[1].[0].property.[0].[0].arg[0].value", fallback: "Hello, World!")), "#3979.[1].[0].property.[0].[0]"))
    #sourceLocation()
    }
}

import struct AppEase_WatchKit_Extension.NotificationView
import struct AppEase_WatchKit_Extension.NotificationView_Previews