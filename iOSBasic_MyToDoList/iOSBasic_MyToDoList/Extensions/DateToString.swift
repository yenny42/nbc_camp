//
//  DateToString.swift
//  iOSBasic_MyToDoList
//
//  Created by t2023-m0035 on 12/18/23.
//

import Foundation

extension Date {
    // MARK: - 기본 & 짧은 날짜 표시
    public var basic: String {
        return toString("yyyy년 M월 d일")
    }
    // MARK: - Date -> String
      public func toString(_ dateFormat: String) -> String {
        return DateFormatter
          .convertToKoKR(dateFormat: dateFormat)
          .string(from: self)
      }
}

extension DateFormatter {
  public static func convertToKoKR(dateFormat: String) -> DateFormatter {
    let dateFormatter = createKoKRFormatter()
    dateFormatter.dateFormat = dateFormat
    return dateFormatter
  }
}

private func createKoKRFormatter() -> DateFormatter {
  let dateFormatter = DateFormatter()
  dateFormatter.locale = Locale(identifier: "ko_KR")
  dateFormatter.timeZone = TimeZone(abbreviation: "KST")
  return dateFormatter
}
