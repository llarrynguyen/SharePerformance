//
//  CollectionViewCellCommand.swift
//  StockPerformance
//
//  Created by Larry Nguyen on 3/3/19.
//  Copyright © 2019 Larry. All rights reserved.
//

import UIKit


// MARK: - Command pattern for collection view cell
protocol CollectionViewCellCommand {
    func triggerAction(for cell: UICollectionViewCell)
}

enum CollectionViewCellCommandKey {
    case config
    case cancel
    case select
}

struct CollectionViewCellModel {
    let identifier: String
    let size: CGSize
    
    // MARK: - This command dict hold all the actions to a cell
    let commands:[CollectionViewCellCommandKey: CollectionViewCellCommand]
}
