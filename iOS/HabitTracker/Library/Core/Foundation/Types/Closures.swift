//
//  Closures.swift
//  Unicredit
//
//  Created by Ivan Smetanin on 31/01/2019.
//  Copyright © 2019 Surf. All rights reserved.
//

import Foundation

typealias Closure<T> = (T) -> Void

typealias EmptyClosure = () -> Void

typealias BoolClosure = (Bool) -> Void

typealias ErrorClosure = (Error) -> Void
