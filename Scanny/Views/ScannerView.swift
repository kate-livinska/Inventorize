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
    
    @State private var isPresentinBoxViewPopover = false
    
    var body: some View {
        CodeScannerView(codeTypes: [.ean8, .ean13, .code128, .upce], simulatedData: "item2_sku") { response in
            switch response {
            case .success(let result):
                viewModel.searchText = result.string
                isPresentinBoxViewPopover = true
            case .failure(let error):
                print("Scanning failed: \(error.localizedDescription)")
            }
        }
        .sheet(isPresented: $isPresentinBoxViewPopover) {
            ScanResults()
        }
        .interactiveDismissDisabled() //Prevent people from dragging the sheet down to dismiss it.
    }
}

#Preview {
    ScannerView()
        .environment(ViewModel())
        .modelContainer(SampleData.shared.modelContainer)
}
