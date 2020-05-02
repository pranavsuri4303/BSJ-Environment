import Foundation
import UIKit
import FirebaseAuth
import Firebase

class RegisterViewController: UIViewController, UITextFieldDelegate {
	
	var passwordValidity = false
	var emailValidity = false
	var repeatPasswordValidity = true
	var nameValidity = true
	
	lazy var validityType: String.ValidityType = .password
	
	
	@IBOutlet weak var container: UIView!
	@IBOutlet weak var registerButton: UIButton!
	
	
	// Text Fields
	@IBOutlet weak var nameTextField: UITextField!
	@IBOutlet weak var emailTextField: UITextField!
	@IBOutlet weak var passwordTextField: UITextField!
	@IBOutlet weak var repeatPasswordTextField: UITextField!
	
	// Error images
	@IBOutlet weak var nameErrorImage: UIImageView!
	@IBOutlet weak var emailErrorImage: UIImageView!
	@IBOutlet weak var passwordErrorImage: UIImageView!
	@IBOutlet weak var repeatPasswordErrorImage: UIImageView!
	
	@IBOutlet weak var spinner: UIActivityIndicatorView!

	override func viewDidLoad() {
		super.viewDidLoad()
		// Make buttons rounded
		container.layer.cornerRadius = 10
		registerButton.layer.cornerRadius = 10
		emailTextField.delegate = self
		passwordTextField.delegate = self
		repeatPasswordTextField.delegate = self
		spinner.alpha = 0
		Display.displayError(for: repeatPasswordTextField, with: repeatPasswordErrorImage)
	}
	
	@IBAction func registerPressed(_ sender: UIButton) {
		if errorDisplayer(){
			Display.spinning(this: spinner)
				Auth.auth().createUser(withEmail: emailTextField.text! , password: passwordTextField.text!) { (result, err) in
					if err != nil{
						print(err?.localizedDescription ?? "hi")
					}
					else{
						Display.noSpinning(this: self.spinner)
						let db = Firestore.firestore()
						db.collection("users").addDocument(data: ["Name" : self.nameTextField.text!, "uid": result!.user.uid])
					}
				}
		}
	}
	func errorDisplayer()-> Bool{
		if nameValidity == false{
			Display.displayError(for: nameTextField, with: nameErrorImage)
		}
		if emailValidity == false{
			Display.displayError(for: emailTextField, with: emailErrorImage)
		}
		if passwordValidity == false{
			Display.displayError(for: passwordTextField, with: passwordErrorImage)
		}
		if repeatPasswordValidity == false{
			Display.displayError(for: repeatPasswordTextField, with: repeatPasswordErrorImage)
		}
		if repeatPasswordValidity == true && nameValidity == true && emailValidity == true && passwordValidity == true {
			return true
		} else{
			return false
		}
	}
	
	func textFieldDidEndEditing(_ textField: UITextField) {
		if textField == self.emailTextField{
			self.validityType = .email
			guard let text = textField.text else { return }
			if text.isValid(validityType) {
				Display.tickAppear(this: emailErrorImage)
				Display.boxDisappear(this: emailTextField)
				emailValidity = true
			} else {
				Display.displayError(for: textField, with: emailErrorImage)
				emailValidity = false
			}
		}
		if textField == passwordTextField{
			validityType = .password
			guard let text = textField.text else { return }
			if text.isValid(validityType) {
				Display.tickAppear(this: passwordErrorImage)
				Display.boxDisappear(this: passwordTextField)
				passwordValidity = true
			} else {
				Display.displayError(for: textField, with: passwordErrorImage)
				passwordValidity = false
			}
		}
		if textField == repeatPasswordTextField{
			if textField.text! == passwordTextField.text! && passwordValidity == true{
				repeatPasswordValidity = true
			} else{
				repeatPasswordValidity = false
			}
		}
		if textField == nameTextField{
			if textField.text != nil{
				nameValidity = true
			} else{
				nameValidity = false
			}
		}
		
	}

}
