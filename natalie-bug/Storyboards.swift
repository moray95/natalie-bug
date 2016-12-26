//
// Autogenerated by Natalie - Storyboard Generator
// by Marcin Krzyzanowski http://krzyzanowskim.com
//
import UIKit

//MARK: - Storyboards

extension UIStoryboard {
    func instantiateViewController<T: UIViewController>(ofType type: T.Type) -> T? where T: IdentifiableProtocol {
        let instance = type.init()
        if let identifier = instance.storyboardIdentifier {
            return self.instantiateViewController(withIdentifier: identifier) as? T
        }
        return nil
    }

}

protocol Storyboard {
    static var storyboard: UIStoryboard { get }
    static var identifier: String { get }
}

struct Storyboards {

    struct Main: Storyboard {

        static let identifier = "Main"

        static var storyboard: UIStoryboard {
            return UIStoryboard(name: self.identifier, bundle: nil)
        }

        static func instantiateInitialViewController() -> FirstViewController {
            return self.storyboard.instantiateInitialViewController() as! FirstViewController
        }

        static func instantiateViewController(withIdentifier: String) -> UIViewController {
            return self.storyboard.instantiateViewController(withIdentifier: identifier)
        }

        static func instantiateViewController<T: UIViewController>(ofType type: T.Type) -> T? where T: IdentifiableProtocol {
            return self.storyboard.instantiateViewController(ofType: type)
        }
    }
}

//MARK: - ReusableKind
enum ReusableKind: String, CustomStringConvertible {
    case TableViewCell = "tableViewCell"
    case CollectionViewCell = "collectionViewCell"

    var description: String { return self.rawValue }
}

//MARK: - SegueKind
enum SegueKind: String, CustomStringConvertible {    
    case Relationship = "relationship" 
    case Show = "show"                 
    case Presentation = "presentation" 
    case Embed = "embed"               
    case Unwind = "unwind"             
    case Push = "push"                 
    case Modal = "modal"               
    case Popover = "popover"           
    case Replace = "replace"           
    case Custom = "custom"             

    var description: String { return self.rawValue } 
}

//MARK: - IdentifiableProtocol

public protocol IdentifiableProtocol: Equatable {
    var storyboardIdentifier: String? { get }
}

//MARK: - SegueProtocol

public protocol SegueProtocol {
    var identifier: String? { get }
}

public func ==<T: SegueProtocol, U: SegueProtocol>(lhs: T, rhs: U) -> Bool {
    return lhs.identifier == rhs.identifier
}

public func ~=<T: SegueProtocol, U: SegueProtocol>(lhs: T, rhs: U) -> Bool {
    return lhs.identifier == rhs.identifier
}

public func ==<T: SegueProtocol>(lhs: T, rhs: String) -> Bool {
    return lhs.identifier == rhs
}

public func ~=<T: SegueProtocol>(lhs: T, rhs: String) -> Bool {
    return lhs.identifier == rhs
}

public func ==<T: SegueProtocol>(lhs: String, rhs: T) -> Bool {
    return lhs == rhs.identifier
}

public func ~=<T: SegueProtocol>(lhs: String, rhs: T) -> Bool {
    return lhs == rhs.identifier
}

//MARK: - ReusableViewProtocol
public protocol ReusableViewProtocol: IdentifiableProtocol {
    var viewType: UIView.Type? { get }
}

public func ==<T: ReusableViewProtocol, U: ReusableViewProtocol>(lhs: T, rhs: U) -> Bool {
    return lhs.storyboardIdentifier == rhs.storyboardIdentifier
}

//MARK: - Protocol Implementation
extension UIStoryboardSegue: SegueProtocol {
}

extension UICollectionReusableView: ReusableViewProtocol {
    public var viewType: UIView.Type? { return type(of: self) }
    public var storyboardIdentifier: String? { return self.reuseIdentifier }
}

extension UITableViewCell: ReusableViewProtocol {
    public var viewType: UIView.Type? { return type(of: self) }
    public var storyboardIdentifier: String? { return self.reuseIdentifier }
}

//MARK: - UIViewController extension
extension UIViewController {
    func perform<T: SegueProtocol>(segue: T, sender: AnyObject?) {
        if let identifier = segue.identifier {
            performSegue(withIdentifier: identifier, sender: sender)
        }
    }

    func perform<T: SegueProtocol>(segue: T) {
        perform(segue: segue, sender: nil)
    }
}

//MARK: - UICollectionView

extension UICollectionView {

    func dequeue<T: ReusableViewProtocol>(reusable: T, for: IndexPath) -> UICollectionViewCell? {
        if let identifier = reusable.storyboardIdentifier {
            return dequeueReusableCell(withReuseIdentifier: identifier, for: `for`)
        }
        return nil
    }

    func register<T: ReusableViewProtocol>(reusable: T) {
        if let type = reusable.viewType, let identifier = reusable.storyboardIdentifier {
            register(type, forCellWithReuseIdentifier: identifier)
        }
    }

    func dequeueReusableSupplementaryViewOfKind<T: ReusableViewProtocol>(elementKind: String, withReusable reusable: T, for: IndexPath) -> UICollectionReusableView? {
        if let identifier = reusable.storyboardIdentifier {
            return dequeueReusableSupplementaryView(ofKind: elementKind, withReuseIdentifier: identifier, for: `for`)
        }
        return nil
    }

    func register<T: ReusableViewProtocol>(reusable: T, forSupplementaryViewOfKind elementKind: String) {
        if let type = reusable.viewType, let identifier = reusable.storyboardIdentifier {
            register(type, forSupplementaryViewOfKind: elementKind, withReuseIdentifier: identifier)
        }
    }
}
//MARK: - UITableView

extension UITableView {

    func dequeue<T: ReusableViewProtocol>(reusable: T, for: IndexPath) -> UITableViewCell? {
        if let identifier = reusable.storyboardIdentifier {
            return dequeueReusableCell(withIdentifier: identifier, for: `for`)
        }
        return nil
    }

    func register<T: ReusableViewProtocol>(reusable: T) {
        if let type = reusable.viewType, let identifier = reusable.storyboardIdentifier {
            register(type, forCellReuseIdentifier: identifier)
        }
    }

    func dequeueReusableHeaderFooter<T: ReusableViewProtocol>(_ reusable: T) -> UITableViewHeaderFooterView? {
        if let identifier = reusable.storyboardIdentifier {
            return dequeueReusableHeaderFooterView(withIdentifier: identifier)
        }
        return nil
    }

    func registerReusableHeaderFooter<T: ReusableViewProtocol>(_ reusable: T) {
        if let type = reusable.viewType, let identifier = reusable.storyboardIdentifier {
             register(type, forHeaderFooterViewReuseIdentifier: identifier)
        }
    }
}


//MARK: - FirstViewController
extension UIStoryboardSegue {
    func selection() -> FirstViewController.Segue? {
        if let identifier = self.identifier {
            return FirstViewController.Segue(rawValue: identifier)
        }
        return nil
    }
}

extension FirstViewController { 

    enum Segue: String, CustomStringConvertible, SegueProtocol {
        case segue = "segue"

        var kind: SegueKind? {
            switch (self) {
            case .segue:
                return SegueKind(rawValue: "show")
            }
        }

        var destination: UIViewController.Type? {
            switch (self) {
            case .segue:
                return SecondViewController.self
            }
        }

        var identifier: String? { return self.description } 
        var description: String { return self.rawValue }
    }

}

//MARK: - SecondViewController
extension UIStoryboardSegue {
    func selection() -> SecondViewController.Segue? {
        if let identifier = self.identifier {
            return SecondViewController.Segue(rawValue: identifier)
        }
        return nil
    }
}

extension SecondViewController { 

    enum Segue: String, CustomStringConvertible, SegueProtocol {
        case secondSegue = "secondSegue"

        var kind: SegueKind? {
            switch (self) {
            case .secondSegue:
                return SegueKind(rawValue: "show")
            }
        }

        var destination: UIViewController.Type? {
            switch (self) {
            case .secondSegue:
                return FirstViewController.self
            }
        }

        var identifier: String? { return self.description } 
        var description: String { return self.rawValue }
    }

}

