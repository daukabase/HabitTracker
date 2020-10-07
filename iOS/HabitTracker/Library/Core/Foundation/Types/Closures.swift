//
//  Closures.swift
//  Unicredit
//
//  Created by Ivan Smetanin on 31/01/2019.
//  Copyright © 2019 Surf. All rights reserved.
//

import Foundation

public typealias Closure<T> = (T) -> Void

public typealias EmptyClosure = () -> Void

public typealias BoolClosure = (Bool) -> Void

public typealias ErrorClosure = (Error) -> Void
