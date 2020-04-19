import Foundation
import UIKit

class RegisterViewController: UIViewController, UITextFieldDelegate {
    
    
    var validityType: String.ValidityType = .password
    
    
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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Make buttons rounded
        container.layer.cornerRadius = 10
        registerButton.layer.cornerRadius = 10
        emailTextField.delegate = self
        passwordTextField.delegate = self
    }

    @IBAction func registerPressed(_ sender: UIButton) {
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        switch textField{
        case emailTextField:
            validityType = .email
            guard let text = textField.text else { return }
            if text.isValid(validityType) {
                Display.tickAppear(this: emailErrorImage)
                Display.boxDisappear(this: emailTextField)
            } else {
                Display.displayError(for: textField, with: emailErrorImage)
            }
        case passwordTextField:
            validityType = .password
            guard let text = textField.text else { return }
            if text.isValid(validityType) {
                print("Hi")
            } else {
                print("Bye")
                
            }
        default:
            return
        }

    }}
