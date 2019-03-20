//
//  Module.swift
//  reviewsatron
//
//  Created by Hobayier Sallam on 19.03.19.
//  Copyright © 2019 Hobs. All rights reserved.
//

import Foundation
import UIKit

protocol Dependencies {
    
}

protocol Module {
    associatedtype Dependencies
    static func assemble(dependencies: Dependencies) -> UIViewController
}
