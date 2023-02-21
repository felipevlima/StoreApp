//
//  ProductImageListView.swift
//  StoreApp
//
//  Created by Felipe Lima on 21/02/23.
//

import SwiftUI
import UIKit

struct ProductImageListView: View {
    let images: [UIImage]
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: true) {
            HStack {
                ForEach(images, id: \.self) { image in
                    Image(uiImage: image)
                        .resizable()
                        .frame(width: 100, height: 100)
                        .aspectRatio(contentMode: .fit)
                        .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
                }
            }
        }
    }
}

struct ProductImageListView_Previews: PreviewProvider {
    static var previews: some View {
        ProductImageListView(images: [])
    }
}
