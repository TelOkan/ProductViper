//
//  URL+Extensions.swift
//  ProductViper
//
//  Created by Okan on 6.09.2024.
//

import Foundation

extension String {
    func toURL() -> URL? {
        return URL(string: self)
    }
}
