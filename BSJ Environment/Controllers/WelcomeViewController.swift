import Foundation
import UIKit
import CoreLocation

class WelcomeViewController: UIViewController {
    
    @IBOutlet weak var signupButton: UIButton!
    @IBOutlet weak var loginButton: UIButton!
    
    
    let locationManager = CLLocationManager()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Making the buttons rounded
        signupButton.layer.cornerRadius = 10
        loginButton.layer.cornerRadius = 10
		locationManager.requestWhenInUseAuthorization()
        
    }
	@IBAction func registerPressed(_ sender: Any) {
		performSegue(withIdentifier: "WelcomeToRegister", sender: self)
		
	}
	override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: animated);
        super.viewWillDisappear(animated)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
}

