//
//  EmailExporterTests.swift
//  VandelayTests
//
//  Created by Daniel Saidi on 2018-09-12.
//  Copyright © 2018 Daniel Saidi. All rights reserved.
//

#if !os(macOS)
import Quick
import Nimble
import Vandelay
import UIKit

class EmailExporterTests: QuickSpec {
    
    override func spec() {
    
        var exporter: Exporter!
        
        beforeEach {
            exporter = EmailExporter(fromViewController: UIViewController(), fileName: "foo")
        }
        
        describe("export method") {
            
            it("is correct") {
                expect(exporter.exportMethod).to(equal(.email))
            }
        }
    }
}
#endif
