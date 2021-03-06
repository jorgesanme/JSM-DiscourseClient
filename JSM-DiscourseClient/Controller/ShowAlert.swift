//
//  ShowAlert.swift
//  JSM-DiscourseClient
//
//  Created by Jorge Sanchez on 05/03/2021.
//
import UIKit

extension UIViewController {
    /// Muestra un alertcontroller con una única acción
    /// - Parameters:
    ///   - alertMessage: Mensaje del alert
    ///   - alertTitle: Título del alert
    ///   - alertActionTitle: Título de la acción
    //    - Handler: Para ejecutar una acción al pulsar botón
    func showAlert(_ alertMessage: String,
                   _ alertTitle: String = NSLocalizedString("Success", comment: ""),
                   _ alertActionTitle: String = NSLocalizedString("OK", comment: ""),
                   handler: ((UIAlertAction) -> Void)?) {
        
        let alertController = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: alertActionTitle, style: .default, handler: handler))
        present(alertController, animated: true, completion: nil)
    }
}
