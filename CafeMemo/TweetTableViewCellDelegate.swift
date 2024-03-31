//
//  TweetTableViewCellDelegate.swift
//  CafeMemo
//
//  Created by misaki on 2024/03/16.
//

import Foundation

protocol TweetTableViewCellDelegate: AnyObject {
    func minusButtonTapped(in cell: TweetTableViewCell)
}

