import Foundation
import SwiftUI

struct ScannerView: View {
    @ObservedObject var viewModel = ScannerViewModel()
    
    var body: some View {
        VStack {
            ZStack {
                QrCodeScannerView()
                .found(r: self.viewModel.onFoundQrCode)
                .torchLight(isOn: self.viewModel.torchIsOn)
                .interval(delay: self.viewModel.scanInterval)
                
                VStack {
                    Spacer()
                    VStack {
                        Text("Keep scanning for QR-codes")
                            .font(.subheadline)
                    }
                    .padding(.vertical, 20)
                }.padding()
            }

            HStack {
                Image(systemName: "quote.bubble")
                Text("Profile Description")
                    .bold()
                    .font(.system(Font.TextStyle.subheadline,design: .rounded))
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding([.bottom])
            
            VStack {
                HStack {
                    Text(self.viewModel.lastQrCode)
                        .bold()
                        .padding()
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            }
        }
    }
}
