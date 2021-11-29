import Firebase

struct AuthenticationApi {
    func login(mail: String, password: String, completion: @escaping (Bool) -> Void) {
        Auth.auth().signIn(withEmail: mail, password: password) {authResult, error in
            guard let _ = authResult?.user, error == nil else {
                // ...print("Signed in")
                completion(false)
                return
            }
            //print("Logged In")
            completion(true)
        }
    }
    
    func signIn(signInEmail: String, signInPassword: String, signInPasswordRepeat: String, completion: @escaping (Bool) -> Void) {
        Auth.auth().createUser(withEmail: signInEmail, password: signInPassword) { authResult, error in
            // ...
            guard let _ = authResult?.user, error == nil else {
                //strongSelf.showMessagePrompt(error!.localizedDescription)
                print("Login error: \(error)")
                completion(false)
                return
            }
            //print("\(user.email!) created")
            completion(true)
        }
    }
    
    func logOut() -> Bool {
        do {
            try Auth.auth().signOut()
        } catch let err {
            print(err)
            return false
        }
        return true
    }
    
    func controlUserIsSignedIn() -> Bool {
        let user = Auth.auth().currentUser
        if let _ = user {
            return true
        }
        return false
    }
    
}
