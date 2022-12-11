//
//  PerfilViewController.swift
//  Mensajitos
//

//

import UIKit
import FirebaseAuth
import FBSDKLoginKit

class PerfilViewController: UIViewController {

    @IBOutlet var tableView: UITableView!
    
    let data = ["Cerrar Sesión"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UITableViewCell.self,
                           forCellReuseIdentifier: "cell")
        tableView.delegate = self
        tableView.dataSource = self
    }
}

extension PerfilViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = data[indexPath.row]
        cell.textLabel?.textAlignment = .center
        cell.textLabel?.textColor = .black
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let actionSheet = UIAlertController(title: "",
                                      message: "",
                                      preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: "Cerrar Sesión",
                                      style: .destructive,
                                     handler: { [weak self] _ in
                                        guard let strongSelf = self else {
                                            return
                                        }
//            Logueado con Facebook
            FBSDKLoginKit.LoginManager().logOut()
                                        do {
                                            try FirebaseAuth.Auth.auth().signOut()
                                            
                                            let vc = LoginViewController()
                                            let nav = UINavigationController(rootViewController: vc)
                                            nav.modalPresentationStyle = .fullScreen
                                            strongSelf.present(nav, animated: true)
                                            
                                        }catch{
                                            print("Falló el cerrar sesión")
                                        }
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Cancelar",
                                            style: .cancel,
                                           handler: nil))
        
        present(actionSheet, animated: true)
    
    }
}
