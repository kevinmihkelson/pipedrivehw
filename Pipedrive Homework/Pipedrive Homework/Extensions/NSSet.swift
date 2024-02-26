//
//  NSSet.swift
//  Pipedrive Homework
//
//  Created by Kevin Mihkelson on 25.02.2024.
//

import Foundation

extension NSSet {
  func toArray<T>() -> [T] {
    let array = self.map({ $0 as! T})
    return array
  }
}
