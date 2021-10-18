//
//  CompositionalLayout.swift
//  WeatherForecast
//
//  Created by tae hoon park on 2021/10/18.
//

import UIKit

enum ScrollDirection {
    case horizontal
    case vertical
}

struct CompositionalLayout {
    func create(
        portraitHorizontalNumber: Int,
        landscapeHorizontalNumber: Int,
        cellVerticalSize: NSCollectionLayoutDimension,
        headerVerticalSize: NSCollectionLayoutDimension,
        scrollDirection: ScrollDirection,
        cellMargin: NSDirectionalEdgeInsets?,
        viewMargin: NSDirectionalEdgeInsets?) -> UICollectionViewLayout {
        var horizontalNumber: Int {
            UIDevice.current.orientation.isLandscape ? landscapeHorizontalNumber : portraitHorizontalNumber
        }
        
        let layout =
            UICollectionViewCompositionalLayout { (_, _) -> NSCollectionLayoutSection? in
                let itemSize = NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1.0),
                    heightDimension: .fractionalHeight(1.0))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                item.contentInsets = cellMargin
                    ?? NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: cellVerticalSize)
                let group = NSCollectionLayoutGroup.horizontal(
                    layoutSize: groupSize, subitem: item, count: horizontalNumber)
                let section = NSCollectionLayoutSection(group: group)
                let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                        heightDimension: headerVerticalSize)
                let header = NSCollectionLayoutBoundarySupplementaryItem(
                    layoutSize: headerSize,
                    elementKind: UICollectionView.elementKindSectionHeader,
                    alignment: .top)
                
                section.boundarySupplementaryItems = [header]
                if scrollDirection == .horizontal {
                    section.orthogonalScrollingBehavior = .continuous
                }
                
                section.contentInsets = viewMargin
                    ?? NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
                return section
            }
        return layout
    }
    
    func margin(top: CGFloat, leading: CGFloat,
                bottom: CGFloat, trailing: CGFloat) -> NSDirectionalEdgeInsets {
        return NSDirectionalEdgeInsets(
            top: top, leading: leading, bottom: bottom, trailing: trailing)
    }
}
