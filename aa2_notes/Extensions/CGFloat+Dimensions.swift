//
//  CGFloat+Dimensions.swift
//  aa2_notes
//
//  Created by elisabeth.mateu@enti.cat on 19/5/23.
//

import Foundation

extension CGFloat {
    
    static var space0: CGFloat { get { return 1 } }
    static var space1: CGFloat { get { return 2 } }
    static var space2: CGFloat { get { return .space1 * 2 } }
    static var space4: CGFloat { get { return .space1 * 4 } }
    static var space8: CGFloat { get { return .space1 * 8 } }
    
    static var separators: CGFloat { get { return 1 } }
    static var paddingLow: CGFloat { get { return .padding * 0.5 } }
    static var padding: CGFloat { get { return 8 } }
    static var padding2: CGFloat { get { return .padding * 2 } }
    static var padding4: CGFloat { get { return .padding * 4 } }
    
    static var buttonsWidth: CGFloat = 90
    static var titleWidth: CGFloat = 120
    static var titleViewHeight: CGFloat = 120
    static var floatingBtnSize: CGFloat = 40
    static var cornerRadius: CGFloat = 10
    
}

