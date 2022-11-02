//
//  Color.swift
//  Uber
//
//  Created by Mariusz Zając on 02/11/2022.
//

import SwiftUI

extension Color {
    static let theme = ColorTheme()
}
struct ColorTheme {
    let backgroundColor = Color("BackgroundColor")
    let secondaryBackgroundColor = Color("SecondaryBackgroundColor")
    let primaryTextColour = Color("PrimaryTextColor")
}

