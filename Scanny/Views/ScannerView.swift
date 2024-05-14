//
//  ScannerView.swift
//  Scanny
//
//  Created by Ekaterina Livinska on 25/01/2024.
//

import SwiftUI
import CodeScanner
import SwiftData

struct ScannerView: View {
    @Environment(\.modelContext) private var context
    @State private var isPresentinBoxViewPopover = false
    @State private var scannedCode: PopoverModel?
    
    var body: some View {
        CodeScannerView(codeTypes: [.ean8, .ean13, .code128, .upce], simulatedData: "item2_sku") { response in
            switch response {
            case .success(let result):
                scannedCode = PopoverModel(code: result.string)
                //isPresentinBoxViewPopover = true
            case .failure(let error):
                print("Scanning failed: \(error.localizedDescription)")
            }
        }
        .sheet(item: $scannedCode, onDismiss: didDismiss) { detail in
            BoxView(scannedCode: detail.code)
        }
        .interactiveDismissDisabled() //Prevent people from dragging the sheet down to dismiss it.
    }
    
    func didDismiss() {
        
    }
}

struct PopoverModel: Identifiable {
    var id: String { code }
    let code: String
}

#Preview {
    ScannerView()
}
