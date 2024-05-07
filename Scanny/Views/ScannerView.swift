//
//  ScannerView.swift
//  Scanny
//
//  Created by Ekaterina Livinska on 25/01/2024.
//

import SwiftUI
import CodeScanner

struct ScannerView: View {
    @State private var isPresentinBoxViewPopover = false
    @State private var scannedCode: PopoverModel?
    
    var body: some View {
        CodeScannerView(codeTypes: [.ean8, .ean13, .code128, .upce], simulatedData: "SomeEANvalue") { response in
            switch response {
            case .success(let result):
                scannedCode = PopoverModel(code: result.string)
                isPresentinBoxViewPopover = true
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        .popover(item: $scannedCode, content: { code in
            BoxView(scannedCode: code.code)
                .frame(width:300, height: 250)
                .presentationCompactAdaptation(.none)
        })
    }
}

struct PopoverModel: Identifiable {
    var id: String { code }
    let code: String
}

#Preview {
    ScannerView()
}
