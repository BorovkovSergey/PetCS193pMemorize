//
//  4Array.swift
//  PetCS193pMemorize
//
//  Created by Sergey Borovkov on 18.05.2021.
//

import Foundation

extension Array where Element: Identifiable {
    func GetIndexByID( elem: Element ) -> Int? {
        for i in self.indices {
            if self[i].id == elem.id {
                return i
            }
        }
        return nil
    }
}

extension Array{
    var only: Element? {
        count == 1 ? first : nil
    }
}
