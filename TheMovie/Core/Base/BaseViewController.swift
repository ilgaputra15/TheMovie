//
//  BaseViewController.swift
//  TheMovie
//
//  Created by Ilga Putra on 26/11/20.
//

import UIKit

class BaseViewController: UIViewController {
    
    func showLoadingDialog() {
        showLoading {}
    }
        
    func showLoadingDialog(completion: @escaping () -> Void) {
        showLoading(completion: completion)
    }
    
    func hideLoadingDialog() {
        hideLoading {}
    }
    
    func hideLoadingDialog(completion: @escaping () -> Void) {
        hideLoading(completion: completion)
    }
    
    func errorAlert(message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: {action in
            self.dismiss(animated: true, completion: nil)
        }))
        present(alert,animated: true,completion: nil)
    }

    
    @objc private func showLoading(completion:@escaping ()->Void){
        let alert = UIAlertController(title: nil, message: "Please wait...", preferredStyle: .alert)
        
        let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.style = .medium
        loadingIndicator.startAnimating();
        
        alert.view.addSubview(loadingIndicator)
        present(alert, animated: true, completion: completion)
        }
    
    @objc private func hideLoading(completion:@escaping () -> Void){
        UIView.animate(withDuration: 1, animations: {}, completion: {isComplete in
            self.dismiss(animated: true, completion: completion)
        })
    }
}
