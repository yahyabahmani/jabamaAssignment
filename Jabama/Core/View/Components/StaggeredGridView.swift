//
//  StaggeredGridView.swift
//  Xplorify
//
//  Created by Mohsen on 11/16/24.
//

import SwiftUI

@available(macOS 10.15, *)
public struct StaggeredView<T:Hashable, Content:View>: View {
    
    /// Binding to an array of hashable items to be displayed
    @Binding var data: [T]
    
    /// The number of columns in the grid
    let columns: Int
    
    /// Closure that takes as input a hashable item from the data array and its optional index, and returns a SwiftUI view that represents the item in the grid.
    let content: (_ item: T, _ index: Int?) -> Content
    
    /// A range representing the indices of the grid columns.
    let range: ClosedRange<Int>
    
    var splittedData: [[T]] {
        Helper.splitData(from: data, into: columns)
    }
    
    var rowSpacing: CGFloat
    
    var columnSpacing: CGFloat
    
    /**
     Creates a new StaggeredView with the specified data, number of columns, row and column spacing and content. If column is nil, 2 is the default value.
     */
    public init(_ data: Binding<[T]>, columns: Int = 2, rowSpacing: CGFloat = 8, columnSpacing: CGFloat = 8, @ViewBuilder content: @escaping (_ item: T,  _ index: Int?) -> Content) {
        self._data = data
        self.columns = columns
        self.rowSpacing = rowSpacing
        self.columnSpacing = columnSpacing
        self.range = 0...(columns + 1)
        self.content = content
    }
    
    /**
     Creates a new StaggeredView with the specified data, number of columns, vertical and horizontal spacing and content. If column is nil, 2 is the default value.
     */
    public init(_ data: Binding<[T]>, columns: Int = 2, spacing: CGFloat = 8, @ViewBuilder content: @escaping (_ item: T,  _ index: Int?) -> Content) {
        self._data = data
        self.columns = columns
        self.rowSpacing = spacing
        self.columnSpacing = spacing
        self.range = 0...(columns + 1)
        self.content = content
    }
    
    public var body: some View {
        HStack(alignment: .top, spacing: columnSpacing) {
            ForEach(range, id: \.self) { index in
                if index < splittedData.count {
                    VStack(spacing: rowSpacing) {
                        ForEach(splittedData[index], id: \.self) { item in
                            content(item, getIndexInList(for: item))
                                .transition(.identity)
                        }
                    }
                }
            }
        }
        .animation(.easeInOut, value: data)
    }
    private func getIndexInList(for item: T) -> Int? {
        data.firstIndex(where: { $0.hashValue == item.hashValue })
    }
}

class Helper {
    static func splitData<T>(from arr: [T], into columnNumber: Int = 2) -> [[T]] {
        guard !arr.isEmpty else { return [] }
        let columns = columnNumber > arr.count ? arr.count : columnNumber
        var result = [[T]](repeating: [], count: columns)
        
        for (index, item) in arr.enumerated() {
            let arrayIndex = index % columns
            result[arrayIndex].append(item)
        }
        return result
    }
}
