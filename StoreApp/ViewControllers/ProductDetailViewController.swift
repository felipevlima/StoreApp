//
//  ProductDetailViewController.swift
//  StoreApp
//
//  Created by Felipe Lima on 21/02/23.
//

import UIKit
import SwiftUI

class ProductDetailViewController: UIViewController {
    let product: Product
    let client = StoreHTTPClient()
    
    lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var priceLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    lazy var deleteProductButton: UIButton = {
        let button = UIButton(type: .roundedRect)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Delete", for: .normal)
        return button
    }()
    
    lazy var loadingIndicatorView: UIActivityIndicatorView = {
        let activityIndicatorView = UIActivityIndicatorView()
        activityIndicatorView.style = .large
        return activityIndicatorView
    }()
    
    init(product: Product) {
        self.product = product
        super.init(nibName: nil, bundle: nil)
        UILabel.appearance(whenContainedInInstancesOf: [UINavigationBar.self]).adjustsFontSizeToFitWidth = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = product.title
        setupUI()
        // Do any additional setup after loading the view.
    }
    
    @objc private func deleteProductButtonPressed(_ sender: UIButton) {
        Task {
            do {
                guard let productId = product.id else { return }

                let isDeleted: Bool = try await client.load(Resource(url: .deleteProduct(productId), method: .delete))
                
                if isDeleted {
                    let _ = navigationController?.popViewController(animated: true)
                }
            } catch {
//                showAlert(title: "Error", message: "Unable to delete the product.")
                showMessage(title: "Error", message: "Unable to delete the product.", messageType: .error)
//                print("Show error")
            }
        }
        
    }
    
    private func setupUI() {
        let stackView = UIStackView()
        stackView.spacing = 10
        stackView.axis = .vertical
        stackView.alignment = .top
        stackView.layoutMargins = UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 20)
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        descriptionLabel.text = product.description
        priceLabel.text = product.price.formatAsCurrency()
        
        Task {
            loadingIndicatorView.startAnimating()
            var images: [UIImage] = []
            for imageUrl in (product.images ?? []) {
                guard let downloadedImage = await ImageLoader.load(url: imageUrl) else { return }
                images.append(downloadedImage)
            }
            
            let productImageListVC = UIHostingController(rootView: ProductImageListView(images: images))
            guard let productImageListView = productImageListVC.view else { return }
            stackView.insertArrangedSubview(productImageListView, at: 0)
            addChild(productImageListVC)
            productImageListVC.didMove(toParent: self)
            loadingIndicatorView.stopAnimating()
        }
        
        deleteProductButton.addTarget(self, action: #selector(deleteProductButtonPressed), for: .touchUpInside)
        
        stackView.addArrangedSubview(loadingIndicatorView)
        stackView.addArrangedSubview(descriptionLabel)
        stackView.addArrangedSubview(priceLabel)
        stackView.addArrangedSubview(deleteProductButton)
        
        view.addSubview(stackView)
        
        stackView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
    }
}
//
//struct ProductDetailViewControllerRepresentable: UIViewControllerRepresentable {
//    func makeUIViewController(context: Context) -> some UIViewController {
//        UINavigationController(rootViewController: ProductDetailViewController(product: Product(title: "Hadnmade Fresh Table", price: 345, description: "Andy shoes are designed to keeping in to make all things you want and break the fucking line.", images: [URL(string: "https://placeimg.com/640/480/any?r=0.9178516507833767")!], category: Category(id: 1, name: "Clothes", image: "https://placeimg.com/640/480/any?r=0.9178516507833767"))))
//    }
//
//    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
//
//    }
//}
//
//
//struct ProductDetailViewController_Previews: PreviewProvider {
//    static var previews: some View {
//        ProductDetailViewControllerRepresentable()
//    }
//}
