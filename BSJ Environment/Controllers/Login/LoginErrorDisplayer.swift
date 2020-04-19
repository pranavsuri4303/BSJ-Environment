import Foundation
import UIKit


public class E{
    
    
    // Utilizes appear methods to display error to user
    static func displayError(display errorLabel: UILabel, with emailError: UITextField, and passwordError: UITextField, with errorImage: UIImageView){
        makeAppear(this: errorLabel)
        makeAppear(this: errorImage)
        makeAppear(this: emailError)
        makeAppear(this: passwordError)
    }
    
    
    // Utilizes disappear methods to remove the error displayed to the user.
    static func removeErrorDisplay(display errorLabel: UILabel, with emailError: UITextField, and passwordError: UITextField, with errorImage: UIImageView){
        makeDisappear(this: errorLabel)
        makeDisappear(this: errorImage)
        makeDisappear(this: emailError)
        makeDisappear(this: passwordError)
    }
    
    
    
        // Overloading makeDissapear to make the object invisible to the user.
    static func makeDisappear(this object: UIActivityIndicatorView){
        object.alpha = 0
        object.stopAnimating()
    }
    static func makeDisappear(this object: UIButton){
        object.alpha = 0
    }
    static func makeDisappear(this object: UIImageView){
        object.alpha = 0
    }
    static func makeDisappear(this object: UILabel){
        object.alpha = 0
    }
    static func makeDisappear(this object: UITextField){
        object.layer.borderWidth = 0
        object.layer.borderColor = UIColor.clear.cgColor
    }
    
        // Overloading makeAppear to make the object visible to the user.
    static func makeAppear(this object: UIActivityIndicatorView){
        object.alpha = 1
        object.startAnimating()
    }
    static func makeAppear(this object: UIImageView){
        object.alpha = 1
    }
    static func makeAppear(this object: UIButton){
        object.alpha = 1
    }
    static func makeAppear(this object: UILabel){
        object.alpha = 1
    }
    static func makeAppear(this object: UITextField){
        object.layer.borderWidth = 2
        object.layer.borderColor = UIColor.red.cgColor
    }
    
}
