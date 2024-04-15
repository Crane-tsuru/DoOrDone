//
//  DateFormat.swift
//  DoOrDone
//
//  Created by 鶴見駿 on 2024/04/16.
//

import SwiftUI

var dateFormat: DateFormatter {
    let df = DateFormatter()
    df.locale = Locale(identifier: "ja_JP")
    df.dateStyle = .full
    df.timeStyle = .short
    return df
}

