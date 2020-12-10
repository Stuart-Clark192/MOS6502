//
//  ContentView.swift
//  MOS6502
//
//  Created by Stuart on 15/11/2020.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel: CPUViewModel
    
    var body: some View {
        
        HStack {
            VStack {
                Text("Memory").font(.custom("PrintChar21", size: 10))
                    .foregroundColor(.green)
                    .padding()
        VStack(alignment: .leading) {
            ForEach(viewModel.memory, id: \.self) {
                Text("\($0)")
            }.font(.custom("PrintChar21", size: 10))
            .foregroundColor(.green)
            .padding(0.1)
            
            HStack {
                Button("Prev Page"){
                    viewModel.getNextMemoryBlock(getPrevious: true)
                }.buttonStyle(OutlineButton())
                
                Button("Next Page"){
                    viewModel.getNextMemoryBlock(getPrevious: false)
                }.buttonStyle(OutlineButton())
            }
        }
            }
            VStack {
                Text("Dissasembly").font(.custom("PrintChar21", size: 10))
                    .foregroundColor(.green)
                    .padding()
            VStack(alignment: .leading) {
                
                ForEach(viewModel.dissasembly, id: \.self) {
                    Text("\($0)")
                }.font(.custom("PrintChar21", size: 10))
                .foregroundColor(.green)
                .padding(0.1)
            }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        
        let mem = Memory(memorySize: 65535)
        let cpu2 = CPU(with: mem)
        let viewModel = CPUViewModel(with: cpu2)
        ContentView(viewModel: viewModel)
    }
}

struct OutlineButton: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration
            .label
            .foregroundColor(configuration.isPressed ? .gray : .green)
            .padding(2)
            .background(
                RoundedRectangle(
                    cornerRadius: 8,
                    style: .continuous
                ).stroke(Color.green)
            )
    }
}
