//
//  ViewMaker.swift
//  FavoritePlaces
//
//  Created by Kiarash Vosough on 9/5/1400 AP.
//

import UIKit
import GoogleMaps

final class ViewMaker {
    
    private var _view: UIView!
    
    public var button: ViewMaker {
        _view = UIButton(type: .system)
        return self
    }
    public var textField: ViewMaker {
        _view = UITextField(frame: .zero)
        return self
    }
    public var label: ViewMaker {
        _view = UILabel(frame: .zero)
        return self
    }
    public var view: ViewMaker {
        _view = UIView(frame: .zero)
        return self
    }
    public var imageView: ViewMaker {
        _view = UIImageView(frame: .zero)
        return self
    }
    public var groupedTableView: ViewMaker {
        _view = UITableView(frame: .zero, style: .grouped)
        return self
    }
    
    public var stackView: ViewMaker {
        _view = UIStackView()
        return self
    }
    
    public var markView: ViewMaker {
        _view = MarkView()
        return self
    }
    
    public var GMView: ViewMaker {
        _view = GMSMapView()
        return self
    }
    
    // style adding
    
    @discardableResult func getView() -> UIView {
        return _view
    }
    
    @discardableResult func with(style: UIViewStyle<GMSMapView>) -> GMSMapView {
        let view = _view as! GMSMapView
        style.apply(to: (view))
        return view
    }
    
    @discardableResult func with(style: UIViewStyle<MarkView>) -> MarkView {
        let view = _view as! MarkView
        style.apply(to: (view))
        return view
    }
    
    @discardableResult func with(style: UIViewStyle<UIStackView>) -> UIStackView {
        let view = _view as! UIStackView
        style.apply(to: (view))
        return view
    }
    
    @discardableResult func with(style: UIViewStyle<UIButton>) -> UIButton {
        let view = _view as! UIButton
        style.apply(to: (view))
        return view
    }
    
    @discardableResult func with(style: UIViewStyle<UITextField>) -> UITextField {
        let view = _view as! UITextField
        style.apply(to: (view))
        return view
    }
    
    @discardableResult func with(style: UIViewStyle<UILabel>) -> UILabel {
        let view = _view as! UILabel
        style.apply(to: (view))
        return view
    }
    
    @discardableResult func with(style: UIViewStyle<UIView>) -> UIView {
        let view = _view!
        style.apply(to: (view))
        return view
    }
    
    @discardableResult func with(style: UIViewStyle<UIImageView>) -> UIImageView {
        let view = _view as! UIImageView
        style.apply(to: (view))
        return view
    }
    
    @discardableResult func with(style: UIViewStyle<UITableView>) -> UITableView {
        let view = _view as! UITableView
        style.apply(to: (view))
        return view
    }
}
