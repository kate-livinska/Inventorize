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
    @Environment(ViewModel.self) private var viewModel
    @Environment(\.modelContext) private var context
    var orderID: Int
    @State private var isPresentingScanner = true
    @State private var scannedCode: String?
    
    var body: some View {
        VStack {
            if let code = scannedCode {
                ScanResults(orderID: orderID, searchText: code)
            }
        }
        .sheet(isPresented: $isPresentingScanner) {
            CodeScannerView(codeTypes: [.ean8, .ean13, .code128, .upce], simulatedData: "7589679780") { response in
                switch response {
                case .success(let result):
                    scannedCode = result.string
                    isPresentingScanner = false
                case .failure(let error):
                    print("Scanning failed: \(error.localizedDescription)")
                }
            }
        }
        .interactiveDismissDisabled() //Prevent people from dragging the sheet down to dismiss it.
    }
}

#Preview {
    ScannerView(orderID: 1)
        .environment(ViewModel())
        .modelContainer(SampleData.shared.modelContainer)
}

//struct ScannerView: View {
//    @Environment(ViewModel.self) private var viewModel
//    @Environment(\.modelContext) private var context
//    
//    @State private var isPresentinBoxViewPopover = false
//    
//    var body: some View {
//        CodeScannerView(codeTypes: [.ean8, .ean13, .code128, .upce], simulatedData: "item2_sku") { response in
//            switch response {
//            case .success(let result):
//                viewModel.searchText = result.string
//                isPresentinBoxViewPopover = true
//            case .failure(let error):
//                print("Scanning failed: \(error.localizedDescription)")
//            }
//        }
//        .sheet(isPresented: $isPresentinBoxViewPopover) {
//            ScanResults(orderID: viewModel.selectedOrder!.id)
//                .environment(viewModel)
//        }
//        .interactiveDismissDisabled() //Prevent people from dragging the sheet down to dismiss it.
//    }
//}
