import Foundation
import UIKit
public class Display{
    // Utilizes appear methods to display error to user
    static func displayError(for textField: UITextField, with errorImage: UIImageView){
        boxAppear(this: textField)
        errorAppear(this: errorImage)
    }
    static func errorDisappear(for textField: UITextField, with errorImage: UIImageView){
		tickAppear(this: errorImage)
		boxDisappear(this: textField)
    }
    

    
    static func tickAppear(this object: UIImageView){
        object.image = UIImage(systemName: K.correctSign)
        object.tintColor = UIColor.green
        UIImageView.animate(withDuration: 0.5){
            object.alpha = 1
        }
    }
    
        // Overloading makeDissapear to make the object invisible to the user.


    static func boxDisappear(this object: UITextField){
        object.layer.borderWidth = 0
        object.layer.borderColor = UIColor.clear.cgColor
    }
    
    
    
    
        // Overloading makeAppear to make the object visible to the user.
    static func spinning(this object: UIActivityIndicatorView){
        object.alpha = 1
        object.startAnimating()
    }
	static func noSpinning(this object: UIActivityIndicatorView){
		object.alpha = 0
		object.stopAnimating()
	}
    
    static func boxAppear(this object: UITextField){
        object.layer.borderWidth = 2
        object.layer.borderColor = UIColor.red.cgColor
    }
    
	static func errorAppear(this object: UIImageView){
        object.image = UIImage(systemName: K.errorSign)
		object.tintColor = UIColor.red
		object.alpha = 1
    }
}


