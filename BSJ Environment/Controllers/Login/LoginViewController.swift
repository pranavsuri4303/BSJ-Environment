import Foundation
import UIKit
import Firebase
import GoogleSignIn




class LoginViewController: UIViewController, GIDSignInDelegate{
    
    
    
    var signInSuccessful = false
    
    
    let delegate = UIApplication.shared.delegate as! AppDelegate
    
    @IBOutlet weak var container: UIView!
    @IBOutlet weak var googleSigninButton: GIDSignInButton!
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var errorImage: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        GIDSignIn.sharedInstance()?.presentingViewController = self
        GIDSignIn.sharedInstance().delegate = self

        
        // Makes the buttons Rounded
        loginButton.layer.cornerRadius = 10
        container.layer.cornerRadius = 10
        
        // Makes the Error Label, Image and Spinner ivisibe.
        E.makeDisappear(this: spinner)
        E.makeDisappear(this: errorLabel)
        E.makeDisappear(this: errorImage)
        
        //
        googleSigninButton.style = GIDSignInButtonStyle(rawValue: 1)!
    }
    
    @IBAction func createAccountPressed(_ sender: UIButton) {
        performSegue(withIdentifier: "LoginToRegister",
        sender: self)
    }
    

    @IBAction func loginPressed(_ sender: UIButton) {
        if let email = emailTextField.text, let password = passwordTextField.text{
            E.removeErrorDisplay(display: errorLabel, with: emailTextField, and: passwordTextField, with: errorImage)
            E.makeAppear(this: spinner)
            Auth.auth().signIn(withEmail: email, password: password) {authResult, error in
                if error != nil{
                    E.makeDisappear(this: self.spinner)
                    E.displayError(display: self.errorLabel, with: self.emailTextField, and: self.passwordTextField, with: self.errorImage)
                } else{
                    E.makeDisappear(this: self.spinner)
                    
                    let VC1 = (self.storyboard?.instantiateViewController(withIdentifier: K.Home))!
                    self.present(VC1, animated: true, completion: nil)
                }
            }
        } else {
            E.makeDisappear(this: spinner)
            E.displayError(display: errorLabel, with: emailTextField, and: passwordTextField, with: errorImage)
        }
    }
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        if let error = error {
            print(error.localizedDescription)
            return
        }
        guard let auth = user.authentication else { return }
        let credentials = GoogleAuthProvider.credential(withIDToken: auth.idToken, accessToken: auth.accessToken)
        Auth.auth().signIn(with: credentials) { (authResult, error) in
            if let error = error {
                print(error.localizedDescription)
            } else {
                print("LoginSuccess")
                
                let VC1 = (self.storyboard?.instantiateViewController(withIdentifier: K.Home))!
                self.present(VC1, animated: true, completion: nil)
                //This is where you should add the functionality of successful login
                //i.e. dismissing this view or push the home view controller etc
            }
        }
    }
}
