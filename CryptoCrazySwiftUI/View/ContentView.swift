//
//  ContentView.swift
//  CryptoCrazySwiftUI
//
//  Created by Bekir Geriş on 2.10.2023.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var cryptoListViewModel : CryptoListViewModel
    
    init() {
        self.cryptoListViewModel = CryptoListViewModel()
    }
    
    var body: some View {
        
        NavigationView {
            List(cryptoListViewModel.cryptoList, id: \.id) { crypto in
                VStack {
                    Text(crypto.currency)
                        .font(.title)
                        .fontWeight(.bold)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    Text(crypto.price)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
            }
            .toolbar(content: {
                Button(
                    action: {
                        Task.init {
                            await cryptoListViewModel.downloadCryptosContinuation(url: URL(string: "https://raw.githubusercontent.com/atilsamancioglu/K21-JSONDataSet/master/crypto.json")!)
                        }
                    },
                    label: {
                        Text("Refresh")
                    })
                }
            )
            .navigationTitle("Crypto Crazy")
        }
        .task {
            await cryptoListViewModel.downloadCryptosContinuation(url: URL(string: "https://raw.githubusercontent.com/atilsamancioglu/K21-JSONDataSet/master/crypto.json")!)
        }
//        .task {
//            await cryptoListViewModel.downloadCryptosAsync(url: URL(string: "https://raw.githubusercontent.com/atilsamancioglu/K21-JSONDataSet/master/crypto.json")!)
//        }
//        .onAppear {
//            cryptoListViewModel.downloadCryptos(url: URL(string: "https://raw.githubusercontent.com/atilsamancioglu/K21-JSONDataSet/master/crypto.json")!)
//        }
    }
}

#Preview {
    ContentView()
}
