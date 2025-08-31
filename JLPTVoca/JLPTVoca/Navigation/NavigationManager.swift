//
//  NavigationManager.swift
//  JLPTVoca
//
//  Created by Rama on 8/31/25.
//

import SwiftUI

@Observable
final class NavigationManager<Route: Hashable> {
    var path = NavigationPath()
    
    func navigate(_ route: Route) {
        path.append(route)
    }
    
    func pop() {
        path.removeLast()
    }
    
    func popToRoot() {
        path.removeLast(path.count)
    }
}
