//
//  CollectionViewController.swift
//  DynamicHeightCells
//
//  Created by Volodymyr Rykhva on 24.01.2021.
//

import UIKit
import AlignedCollectionViewFlowLayout

final class CollectionViewController: UICollectionViewController {

    private let collectionLayout = AlignedCollectionViewFlowLayout(horizontalAlignment: .justified,
                                                                   verticalAlignment: .top)

    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.register(UINib(nibName: "Cell", bundle: nil),
                                forCellWithReuseIdentifier: Cell.reuseIdentifier)
        collectionView.collectionViewLayout = collectionLayout
        collectionLayout.itemSize = UICollectionViewFlowLayout.automaticSize
        collectionLayout.minimumLineSpacing = 32
        collectionLayout.minimumInteritemSpacing = 32
        collectionLayout.sectionInset = UIEdgeInsets(top: 20, left: 20, bottom: 0, right: 20)
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        data.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Cell.reuseIdentifier, for: indexPath) as? Cell
        cell?.render(props: data[indexPath.row])
        return cell ?? UICollectionViewCell()
    }
}

extension CollectionViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let contentHorizontalSpaces = collectionLayout.minimumInteritemSpacing
            + collectionLayout.sectionInset.left
            + collectionLayout.sectionInset.right
        let newCellWidth = (collectionView.bounds.width - contentHorizontalSpaces) / 2
        let newHeight = Cell.getProductHeightForWidth(props: data[indexPath.row], width: newCellWidth)
        return CGSize(width: newCellWidth, height: newHeight)
    }
}

