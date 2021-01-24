//
//  Cell.swift
//  DynamicHeightCells
//
//  Created by Volodymyr Rykhva on 24.01.2021.
//

import UIKit

final class Cell: UICollectionViewCell {
    static let reuseIdentifier = "Cell"

    struct Props {
        let title: String
        let priceView: PriceView; struct PriceView {
            let price: String
            let type: String
        }
        let imageName: String
    }

    // MARK: - Outlets

    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var actualPriceLabel: UILabel!
    @IBOutlet private weak var actualPriceType: UILabel!

    private var props = Props.defaultValue

    func render(props: Props) {
        self.props = props

        imageView.image = UIImage(named: props.imageName)
        titleLabel.text = props.title
        actualPriceLabel.text = props.priceView.price
        actualPriceType.text = props.priceView.type
    }
}

extension Cell {

    class func getProductHeightForWidth(props: Props, width: CGFloat) -> CGFloat {
        // magic numbers explanation:
        // 16 - offset between image and price
        // 22 - height of price
        // 8 - offset between price and title
        var resultingHeight: CGFloat = 16 + 22 + 8
        // get image height based on width and aspect ratio
        let imageHeight = width * 2 / 3
        resultingHeight += imageHeight

        let titleHeight = props.title.getHeight(

            font: .systemFont(ofSize: 12), width: width
        )
        resultingHeight += titleHeight

        return resultingHeight
    }
}

extension Cell.Props {

    static let defaultValue = Cell.Props(title: "",
                                         priceView: PriceView(price: "", type: ""),
                                         imageName: "")
}

extension String {

    func getHeight(font: UIFont, width: CGFloat) -> CGFloat {
        let attributes: [NSAttributedString.Key: Any] = [
            .font: font
        ]
        let attributedText = NSAttributedString(string: self, attributes: attributes)
        let constraintBox = CGSize(width: width, height: .greatestFiniteMagnitude)
        let textHeight = attributedText.boundingRect(
            with: constraintBox, options: [.usesLineFragmentOrigin, .usesFontLeading], context: nil)
            .height.rounded(.up)
        return textHeight
    }
}

