//
//  ScannerView.swift
//  Scanny
//
//  Created by Ekaterina Livinska on 25/01/2024.
//

import SwiftUI
import CodeScanner

struct ScannerView: View {
    @State private var isPresentingScanner = true
    @State private var scannedCode: String?
    
    var body: some View {
        VStack(spacing: 10) {
            if let code = scannedCode {
                BoxView(scannedCode: code)
            }
        }
        .sheet(isPresented: $isPresentingScanner) {
            CodeScannerView(codeTypes: [.ean8, .ean13, .code128, .upce], simulatedData: "Paul Hudson") { response in
                switch response {
                case .success(let result):
                    scannedCode = result.string
                    isPresentingScanner = false
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }
}

#Preview {
    ScannerView()
}
