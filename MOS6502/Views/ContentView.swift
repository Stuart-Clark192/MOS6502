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
        VStack {
            HStack(alignment: .top) {
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
                }.padding()
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
                        
                        HStack {
                            Button("Run"){
                                viewModel.run()
                            }.buttonStyle(OutlineButton())
                            
                            Button("Step"){
                                viewModel.step()
                            }.buttonStyle(OutlineButton())
                            
                            Button("Reset"){
                                viewModel.reset()
                            }.buttonStyle(OutlineButton())
                        }
                    }
                }.padding()
            }
            
            VStack(alignment: .leading) {
                Text("Registers").padding(0.1)
                Text("PC      AC    XR  YR  SR  SP      NV-BDIZC").padding(0.1)
                Text("\(viewModel.registerString)").padding(0.1)
            }.font(.custom("PrintChar21", size: 10))
            .foregroundColor(.green)
            .padding()
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
            .padding(4)
            .background(
                RoundedRectangle(
                    cornerRadius: 8,
                    style: .continuous
                ).stroke(Color.green)
            )
    }
}
