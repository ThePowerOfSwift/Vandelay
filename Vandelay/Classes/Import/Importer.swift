//
//  Importer.swift
//  Pods
//
//  Created by Daniel Saidi on 2016-06-22.
//
//

/*
 
 This protocol gives Vandelay importers access to some
 basic importer functions. You should not implement it
 directly, if you create your own importer.
 
 */

import UIKit

public protocol Importer {
    
    var importMethod: String? { get }
}

public extension Importer {
    
    public func getResultWithError(error: NSError) -> ImportResult {
        let result = ImportResult(state: .Failed)
        result.error = error
        result.importMethod = importMethod
        return result
    }
    
    public func getResultWithErrorMessage(message: String) -> ImportResult {
        let domain = "Vandelay"
        let userInfo = ["Description" : message]
        let error = NSError(domain: domain, code: -1, userInfo: userInfo)
        return getResultWithError(error)
    }
    
    public func getResultWithState(state: ImportState) -> ImportResult {
        let result = ImportResult(state: state)
        result.importMethod = importMethod
        return result
    }
    
    public func getTopmostViewController() -> UIViewController? {
        if var vc = UIApplication.sharedApplication().keyWindow?.rootViewController {
            while let presentedViewController = vc.presentedViewController {
                vc = presentedViewController
            }
            return vc
        }
        return nil
    }
}