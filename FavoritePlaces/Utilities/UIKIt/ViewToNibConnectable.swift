//
//  ViewToNibConnectable.swift
//  FavoritePlaces
//
//  Created by Kiarash Vosough on 9/4/1400 AP.
//

import UIKit

protocol ViewToNibConnectable { }

extension ViewToNibConnectable where Self: UIView {
    func connectView() {
        let bundle = Bundle(for: type(of: self))
        let name = getName()
        let nib = UINib(nibName: name, bundle: bundle)
        let views = nib.instantiate(withOwner: self, options: nil)
        guard let view = views.first as? UIView else { return }
        addExpletiveSubView(view: view)
    }
    
    // MARK: - ByPass Generic Names
    private func getName() -> String {
        var name = String(describing: Self.self)
        if let genericTypeRange = name.range(of: "<") {
          name.removeSubrange(genericTypeRange.lowerBound..<name.endIndex)
        }
        return name
    }
}

extension UIView {
    public func addExpletiveSubView (view: UIView) {
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        view.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        view.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        view.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        view.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
    }
}
