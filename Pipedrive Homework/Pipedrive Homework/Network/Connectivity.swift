//
//  Connectivity.swift
//  Pipedrive Homework
//
//  Created by Kevin Mihkelson on 23.02.2024.
//

import Foundation
import Alamofire

struct Connectivity {
  static let sharedInstance = NetworkReachabilityManager()!
  static var isConnectedToInternet:Bool {
      return self.sharedInstance.isReachable
    }
}
