//
//  AspectRatioVGrid.swift
//  stanfordCourse
//
//  Created by Yury Regis on 18/10/2023.
//

import SwiftUI

struct AspectRatioVGrid<Item, ItemView>: View where Item: Identifiable, ItemView: View {
    var items: [Item]
    var aspectRatio: CGFloat
    var content: (Item) -> ItemView
    
    init (items: [Item], aspectRatio: CGFloat, @ViewBuilder content: @escaping (Item) -> ItemView) {
        self.items = items
        self.content = content
        self.aspectRatio = aspectRatio
    }
    
    var body: some View {
        GeometryReader { geometry in
            let itemWidth = adaptiveWidthElement(itemCount: items.count, in: geometry.size, itemAspect: aspectRatio)
            VStack {
                LazyVGrid(columns: [adaptiveGridItem(itemWidth)], spacing: 0, content: {
                    ForEach(items) { item in
                        content(item)
                            .aspectRatio(aspectRatio, contentMode: .fit)
                    }
                })
                Spacer(minLength: 0)
            }
        }
    }
    
    private func adaptiveGridItem(_ width: CGFloat) -> GridItem {
        var gridItem = GridItem(.adaptive(minimum: width))
        gridItem.spacing = 0
        return gridItem
    }
    
    private func adaptiveWidthElement(itemCount: Int, in size: CGSize, itemAspect: CGFloat) -> CGFloat {
        var columnCount = 1
        var rowCount    = itemCount
        
        repeat {
            let itemWidth = size.width / CGFloat(columnCount)
            let itemHeight = itemWidth / itemAspect
            if (CGFloat(rowCount) * itemHeight) < size.height {
                break
            }
            columnCount += 1
            rowCount = (itemCount + (columnCount-1)) / columnCount
            
        } while columnCount < itemCount
        
        if columnCount > itemCount {
            columnCount = itemCount
        }
        return floor(size.width / CGFloat(columnCount))
    }
}

//#Preview {
//    AspectRatioVGrid()
//}
