//
//  Grid.swift
//  PetCS193pMemorize
//
//  Created by Sergey Borovkov on 07.05.2021.
//

import SwiftUI

struct Grid<Item, ItemView>: View where Item: Identifiable, ItemView: View{
    
    private var items: [Item]
    private var viewForItem: (Item) -> ItemView
    
    init(_ items : [Item], viewForItem: @escaping (Item) -> ItemView) {
        self.items = items
        self.viewForItem = viewForItem
    }
    var body: some View{
        GeometryReader{ geometry in
            self.body(for: GridLayout(itemsCount: self.items.count, gridSize: geometry.size))
        }
    }
    
    private func body(for layout: GridLayout) -> some View{
        ForEach(items){ item in self.body(for: item, in: layout) }
    }
    private func body(for item: Item, in layout: GridLayout) -> some View{
        let index = items.GetIndexByID(elem: item)!
        return viewForItem(item)
                        .frame(width: layout.itemSize.width, height: layout.itemSize.height)
                        .position(layout.location(ofItemAt: index))
    }
}

struct GridLayout {
    private(set) var size : CGSize
    private(set) var itemSize = CGSize(width: 0,height: 0)
    private(set) var rows = 0
    private(set) var cols = 0

    init( itemsCount : Int, gridSize: CGSize )
    {
        self.size = gridSize
        guard size.width != 0, size.height != 0, itemsCount > 0 else { return }

        var bestLayout: (rowCount: Int, columnCount: Int) = (1, itemsCount)

        let sizeAspectratio = abs(size.height/size.width)
        var bestVariance : CGFloat?
        var bestCardSize = CGSize()
        for rows in 1...itemsCount{
            let cols = (itemsCount / rows) + (itemsCount % rows > 0 ? 1 : 0)
            let potentialCardSize = CGSize(width: size.width / CGFloat(cols), height: size.height / CGFloat(rows))
            var variance = sizeAspectratio - abs(potentialCardSize.height/potentialCardSize.width)
            variance = variance < 0 ? variance * -1 : variance
            if bestVariance == nil || variance < bestVariance! {
                bestVariance = variance
                bestCardSize = potentialCardSize
                bestLayout = ( rows, cols )
            }
        }
        self.rows = bestLayout.rowCount
        self.cols = bestLayout.columnCount
        self.itemSize = bestCardSize
    }

    func location(ofItemAt index: Int) -> CGPoint {
        if rows == 0 || cols == 0 {
            return CGPoint.zero
        } else {
            return CGPoint(
                x: (CGFloat(index % cols) + 0.5) * itemSize.width,
                y: (CGFloat(index / cols) + 0.5) * itemSize.height
            )
        }
    }
}
