//
//  UIView+Constraints.swift
//  aa2_notes
//
//  Created by elisabeth.mateu@enti.cat on 19/5/23.
//

import Foundation
import UIKit

extension UIView {
    
    public enum ConstraintType {
        case Lesser
        case Equal
        case Greater
    }
    
    @discardableResult func EnableConstraints() -> UIView {
        self.translatesAutoresizingMaskIntoConstraints = false
        return self
    }
    
    //MARK: Aligns
    
    @discardableResult func AlignLeftContraint(other: UIView, padding: CGFloat = 0, type: ConstraintType = .Equal, safeArea: Bool = true, activated: Bool = true) -> NSLayoutConstraint {
        
        let constraint: NSLayoutConstraint
        let otherLeadingAnchor = safeArea ? other.safeAreaLayoutGuide.leadingAnchor : other.leadingAnchor
        
        switch(type)
        {
        case .Lesser:
            constraint = self.leadingAnchor.constraint(lessThanOrEqualTo: otherLeadingAnchor, constant: padding)
        case .Equal:
            constraint = self.leadingAnchor.constraint(equalTo: otherLeadingAnchor, constant: padding)
        case .Greater:
            constraint = self.leadingAnchor.constraint(greaterThanOrEqualTo: otherLeadingAnchor, constant: padding)
        }
        
        constraint.isActive = activated
        
        return constraint
    }
    
    @discardableResult func AlingLeftTo(_ other: UIView, padding: CGFloat = 0, type: ConstraintType = .Equal, safeArea: Bool = true) -> UIView {
        AlignLeftContraint(other: other, padding: padding, type: type,safeArea: safeArea, activated: true)
        return self
    }
    
    @discardableResult func AlingRightContraint(other: UIView, padding: CGFloat = 0, type: ConstraintType = .Equal, safeArea: Bool = true , activated: Bool = true) -> NSLayoutConstraint {
        
        let constraint: NSLayoutConstraint
        let otherTrailingAnchor = safeArea ? other.safeAreaLayoutGuide.trailingAnchor : other.trailingAnchor
        
        switch(type)
        {
        case .Lesser:
            constraint = self.trailingAnchor.constraint(lessThanOrEqualTo: otherTrailingAnchor, constant: -padding)
        case .Equal:
            constraint = self.trailingAnchor.constraint(equalTo: otherTrailingAnchor, constant: -padding)
        case .Greater:
            constraint = self.trailingAnchor.constraint(greaterThanOrEqualTo: otherTrailingAnchor, constant: -padding)
        }
        
        constraint.isActive = activated
        
        return constraint
    }
    
    @discardableResult func AlingRightTo(_ other: UIView, padding: CGFloat = 0, type: ConstraintType = .Equal, safeArea: Bool = true) -> UIView {
        AlingRightContraint(other: other, padding: padding, type: type, safeArea: safeArea, activated: true)
        return self
    }
    
    @discardableResult func AlignTopContraint(other: UIView, padding: CGFloat = 0, type: ConstraintType = .Equal, safeArea: Bool = true, activated: Bool = true) -> NSLayoutConstraint {
        
        let constraint: NSLayoutConstraint
        let otherTopAnchor = safeArea ? other.safeAreaLayoutGuide.topAnchor : other.topAnchor
        
        switch(type)
        {
        case .Lesser:
            constraint = self.topAnchor.constraint(lessThanOrEqualTo: otherTopAnchor, constant: padding)
        case .Equal:
            constraint = self.topAnchor.constraint(equalTo: otherTopAnchor, constant: padding)
        case .Greater:
            constraint = self.topAnchor.constraint(greaterThanOrEqualTo: otherTopAnchor, constant: padding)
        }
        
        constraint.isActive = activated
        
        return constraint
    }
    
    @discardableResult func AlingTopTo(_ other: UIView, padding: CGFloat = 0, type: ConstraintType = .Equal, safeArea: Bool = true) -> UIView {
        AlignTopContraint(other: other, padding: padding, type: type, safeArea: safeArea, activated: true)
        return self
    }
    
    @discardableResult func AlignBotContraint(other: UIView, padding: CGFloat = 0, type: ConstraintType = .Equal, safeArea: Bool = true, activated: Bool = true) -> NSLayoutConstraint {
        
        let constraint: NSLayoutConstraint
        let otherBottomAnchor = safeArea ? other.safeAreaLayoutGuide.bottomAnchor : other.bottomAnchor
        
        switch(type)
        {
        case .Lesser:
            constraint = self.bottomAnchor.constraint(lessThanOrEqualTo: otherBottomAnchor, constant: -padding)
        case .Equal:
            constraint = self.bottomAnchor.constraint(equalTo: otherBottomAnchor, constant: -padding)
        case .Greater:
            constraint = self.bottomAnchor.constraint(greaterThanOrEqualTo: otherBottomAnchor, constant: -padding)
        }
        
        constraint.isActive = activated
        
        return constraint
    }
    
    @discardableResult func AlingBotTo(_ other: UIView, padding: CGFloat = 0, type: ConstraintType = .Equal, safeArea: Bool = true) -> UIView {
        AlignBotContraint(other: other, padding: padding, type: type, safeArea: safeArea, activated: true)
        return self
    }
    
    
    //MARK: Relatives
    
    @discardableResult func AlignBotConstraintToTop(other: UIView, padding: CGFloat = 0, type: ConstraintType = .Equal, safeArea: Bool = true, activated: Bool = true) -> NSLayoutConstraint {
        
        let constraint: NSLayoutConstraint
        let otherTopAnchor = safeArea ? other.safeAreaLayoutGuide.topAnchor : other.topAnchor
        
        switch(type)
        {
        case .Lesser:
            constraint = self.bottomAnchor.constraint(lessThanOrEqualTo: otherTopAnchor, constant: -padding)
        case .Equal:
            constraint = self.bottomAnchor.constraint(equalTo: otherTopAnchor, constant: -padding)
        case .Greater:
            constraint = self.bottomAnchor.constraint(greaterThanOrEqualTo: otherTopAnchor, constant: -padding)
        }
        
        constraint.isActive = activated
        
        return constraint
    }
    
    @discardableResult func AlignBotToTop(_ other: UIView, padding: CGFloat = 0, type: ConstraintType = .Equal, safeArea: Bool = true) -> UIView {
        AlignBotConstraintToTop(other: other, padding: padding, type: type, safeArea: safeArea, activated: true)
        return self
    }
    
    @discardableResult func AlignTopConstraintToBot(other: UIView, padding: CGFloat = 0, type: ConstraintType = .Equal, safeArea: Bool = true, activated: Bool = true) -> NSLayoutConstraint {
        
        let constraint: NSLayoutConstraint
        let otherBotAnchor = safeArea ? other.safeAreaLayoutGuide.bottomAnchor : other.bottomAnchor
        
        switch(type)
        {
        case .Lesser:
            constraint = self.topAnchor.constraint(lessThanOrEqualTo: otherBotAnchor, constant: -padding)
        case .Equal:
            constraint = self.topAnchor.constraint(equalTo: otherBotAnchor, constant: -padding)
        case .Greater:
            constraint = self.topAnchor.constraint(greaterThanOrEqualTo: otherBotAnchor, constant: -padding)
        }
        
        constraint.isActive = activated
        
        return constraint
    }
    
    @discardableResult func AlignTopToBot(_ other: UIView, padding: CGFloat = 0, type: ConstraintType = .Equal, safeArea: Bool = true) -> UIView {
        AlignTopConstraintToBot(other: other, padding: padding, type: type, safeArea: safeArea, activated: true)
        return self
    }
    
    @discardableResult func AlignLeftConstraintToRight(other: UIView, padding: CGFloat = 0, type: ConstraintType = .Equal, safeArea: Bool = true, activated: Bool = true) -> NSLayoutConstraint {
        
        let constraint: NSLayoutConstraint
        let otherRightAnchor = safeArea ? other.safeAreaLayoutGuide.rightAnchor : other.rightAnchor
        
        switch(type)
        {
        case .Lesser:
            constraint = self.leftAnchor.constraint(lessThanOrEqualTo: otherRightAnchor, constant: -padding)
        case .Equal:
            constraint = self.leftAnchor.constraint(equalTo: otherRightAnchor, constant: -padding)
        case .Greater:
            constraint = self.leftAnchor.constraint(greaterThanOrEqualTo: otherRightAnchor, constant: -padding)
        }
        
        constraint.isActive = activated
        
        return constraint
    }
    
    @discardableResult func AlignLeftToRight(_ other: UIView, padding: CGFloat = 0, type: ConstraintType = .Equal, safeArea: Bool = true) -> UIView {
        AlignLeftConstraintToRight(other: other, padding: padding, type: type, safeArea: safeArea, activated: true)
        return self
    }
    
    @discardableResult func AlignRightConstraintToLeft(other: UIView, padding: CGFloat = 0, type: ConstraintType = .Equal, safeArea: Bool = true, activated: Bool = true) -> NSLayoutConstraint {
        
        let constraint: NSLayoutConstraint
        let otherLeftAnchor = safeArea ? other.safeAreaLayoutGuide.leftAnchor : other.leftAnchor
        
        switch(type)
        {
        case .Lesser:
            constraint = self.rightAnchor.constraint(lessThanOrEqualTo: otherLeftAnchor, constant: -padding)
        case .Equal:
            constraint = self.rightAnchor.constraint(equalTo: otherLeftAnchor, constant: -padding)
        case .Greater:
            constraint = self.rightAnchor.constraint(greaterThanOrEqualTo: otherLeftAnchor, constant: -padding)
        }
        
        constraint.isActive = activated
        
        return constraint
    }

    @discardableResult func AlignRightToLeft(_ other: UIView, padding: CGFloat = 0, type: ConstraintType = .Equal, safeArea: Bool = true) -> UIView {
        AlignRightConstraintToLeft(other: other, padding: padding, type: type, safeArea: safeArea, activated: true)
        return self
    }
    
    
    //MARK: Helpers
    
    @discardableResult func PinTo(other: UIView, padding: CGFloat = 0, safeArea: Bool = true) -> UIView
    {
        self.EnableConstraints()
            .AlingTopTo(other, padding: padding)
            .AlingLeftTo(other, padding: padding)
            .AlingRightTo(other, padding: padding)
            .AlingBotTo(other, padding: padding)
        return self
    }
    
    @discardableResult func SetHeight(_ height: CGFloat) -> UIView {
        self.heightAnchor.constraint(equalToConstant: height).isActive = true
        return self
    }
    @discardableResult func SetHeight(_ heightConstraint: NSLayoutAnchor<NSLayoutDimension>, constant: CGFloat = 0.0) -> UIView {
        self.heightAnchor.constraint(equalTo: heightConstraint, constant: constant).isActive = true
        return self
    }
    
    @discardableResult func SetWidth(_ width: CGFloat) -> UIView {
        self.widthAnchor.constraint(equalToConstant: width).isActive = true
        return self
    }
    @discardableResult func SetWidth(_ widthConstraint: NSLayoutAnchor<NSLayoutDimension>, constant: CGFloat = 0.0) -> UIView {
        self.widthAnchor.constraint(equalTo: widthConstraint, constant: constant).isActive = true
        return self
    }
    
    @discardableResult func CenterXTo(_ centerXConstraint: NSLayoutAnchor<NSLayoutXAxisAnchor>, constant: CGFloat = 0.0) -> UIView {
        self.centerXAnchor.constraint(equalTo: centerXConstraint, constant: constant).isActive = true
        return self
    }
    
    @discardableResult func CenterYTo(_ centerYConstraint: NSLayoutAnchor<NSLayoutYAxisAnchor>, constant: CGFloat = 0.0) -> UIView {
        self.centerYAnchor.constraint(equalTo: centerYConstraint, constant: constant).isActive = true
        return self
    }
}
