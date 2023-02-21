//
//  ProductCellView.swift
//  StoreApp
//
//  Created by Felipe Lima on 16/02/23.
//

import SwiftUI

struct ProductCellView: View {
    let product: Product
    
    var body: some View {
        HStack(alignment: .top) {
            VStack (alignment: .leading, spacing: 10) {
                Text(product.title).bold()
                Text(product.description)
            }
            Spacer()
            Text(product.price, format: .currency(code: Locale.currencyCode))
                .bold()
                .padding(.vertical, 5)
                .padding(.horizontal, 10)
                .background {
                    Color.green
                }
                .foregroundColor(.white)
                .clipShape(Capsule())
        }
    }
}

struct ProductCellView_Previews: PreviewProvider {
    static var previews: some View {
        ProductCellView(product: Product(title: "Hadnmade Fresh Table", price: 345, description: "Andy shoes are designed to keeping in", images: [URL(string: "https://placeimg.com/640/480/any?r=0.9178516507833767")!], category: Category(id: 1, name: "Clothes", image: "https://placeimg.com/640/480/any?r=0.9178516507833767")))
    }
}
