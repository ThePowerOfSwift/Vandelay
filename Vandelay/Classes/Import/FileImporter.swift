//
//  FileImporter.swift
//  Vandelay
//
//  Created by Daniel Saidi on 2016-06-22.
//  Copyright © 2016 Daniel Saidi. All rights reserved.
//

/*
 
 This exporter can import strings and data from a file
 in the app's document directory.
 
 Use the fileName initializer if your file should have
 the same name at all times. Use the fileNameGenerator
 initializer if you require dynamic file names.
 
 */


import UIKit

public class FileImporter: NSObject, DataImporter, StringImporter {
    
    
    // MARK: Initialization
    
    public convenience init(fileName: String) {
        self.init(fileNameGenerator: StaticFileNameGenerator(fileName: fileName))
    }
    
    public init(fileNameGenerator: FileNameGenerator) {
        self.fileNameGenerator = fileNameGenerator
        super.init()
    }
    
    
    
    // MARK: Properties
    
    public private(set) var importMethod = "File"
    
    public var errorMessageForInvalidFilePath = "FileImporter could not retrieve a valid file path."
    
    private var fileNameGenerator: FileNameGenerator
    
    
    
    // MARK: Public functions
    
    public func importData(completion: ((_ result: ImportResult) -> ())?) {
        guard let url = getFileUrl() else {
            completion?(getResult(withErrorMessage: errorMessageForInvalidFilePath))
            return
        }
        
        do {
            let data = try Data(contentsOf: url, options: .uncachedRead)
            completion?(getResult(withData: data))
        } catch {
            completion?(self.getResult(withError: error))
        }
    }
    
    public func importString(completion: ((_ result: ImportResult) -> ())?) {
        guard let path = getFilePath() else {
            completion?(getResult(withErrorMessage: errorMessageForInvalidFilePath))
            return
        }
        
        do {
            let string = try String(contentsOfFile: path, encoding: .utf8)
            completion?(getResult(withString: string))
        } catch {
            completion?(self.getResult(withError: error))
        }
    }
    
    
    // MARK: Private functions
    
    private func getFilePath() -> String? {
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        guard let path = paths.first else { return nil }
        let fileName = fileNameGenerator.getFileName()
        return "\(path)/\(fileName)"
    }
    
    private func getFileUrl() -> URL? {
        guard let path = getFilePath() else { return nil }
        return URL(string: "file://\(path)")
    }
}
