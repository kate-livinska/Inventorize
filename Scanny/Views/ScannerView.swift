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
    //@Environment(\.modelContext) private var context
    
    var orderID: Int
    @State var showScanner: Bool = true
    @State private var scannedCode: String?
    
//    init(orderID: Int, showScanner: Bool) {
//        self.orderID = orderID
//        self.showScanner = showScanner
//    }
    
    var body: some View {
        VStack {
            if let code = scannedCode {
                ScanResults(for: orderID, searchText: code)
            }
            if !showScanner {
                Button(action: {
                    scannedCode = nil
                    showScanner = true
                }, label: {
                    Text("Start Scan".localized)
                })
            }
        }
        .sheet(isPresented: $showScanner) {
            CodeScannerView(codeTypes: [.ean8, .ean13, .code128, .upce], simulatedData: "7589679780") { response in
                switch response {
                case .success(let result):
                    scannedCode = result.string
                    showScanner = false
                case .failure(let error):
                    print("Scanning failed: \(error.localizedDescription)")
                }
            }
        }
        .interactiveDismissDisabled() //Prevent people from dragging the sheet down to dismiss it.
        .onAppear {
            scannedCode = nil
            showScanner = true
        }
    }
}

#Preview {
    ScannerView(orderID: 1)
        .modelContainer(SampleData.shared.modelContainer)
        .environmentObject(NavigationManager())
}
