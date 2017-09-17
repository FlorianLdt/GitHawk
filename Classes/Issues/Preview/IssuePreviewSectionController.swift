//
//  IssuePreviewViewController.swift
//  Freetime
//
//  Created by Ryan Nystrom on 8/1/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import UIKit
import IGListKit

final class IssuePreviewSectionController: ListBindingSectionController<IssuePreviewModel>,
ListBindingSectionControllerDataSource {

    private lazy var webviewCache: WebviewCellHeightCache = {
        return WebviewCellHeightCache(sectionController: self)
    }()

    override init() {
        super.init()
        dataSource = self
    }

    // MARK: ListBindingSectionControllerDataSource

    func sectionController(
        _ sectionController: ListBindingSectionController<ListDiffable>,
        viewModelsFor object: Any
        ) -> [ListDiffable] {
        return self.object?.models ?? []
    }

    func sectionController(
        _ sectionController: ListBindingSectionController<ListDiffable>,
        sizeForViewModel viewModel: Any,
        at index: Int
        ) -> CGSize {
        guard let width = collectionContext?.containerSize.width else { fatalError("Missing context") }
        let height = BodyHeightForComment(viewModel: viewModel, width: width, webviewCache: webviewCache)
        return CGSize(width: width, height: height)
    }

    func sectionController(
        _ sectionController: ListBindingSectionController<ListDiffable>,
        cellForViewModel viewModel: Any,
        at index: Int
        ) -> UICollectionViewCell {
        guard let context = self.collectionContext else { fatalError("Missing context") }

        let cellClass: AnyClass = CellTypeForComment(viewModel: viewModel)
        let cell = context.dequeueReusableCell(of: cellClass, for: self, at: index)

        ExtraCommentCellConfigure(
            cell: cell,
            imageDelegate: nil,
            htmlDelegate: webviewCache,
            htmlNavigationDelegate: nil,
            attributedDelegate: nil,
            issueAttributedDelegate: nil
        )
        
        return cell
    }
    
}
