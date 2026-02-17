import SwiftUI

struct GratefulnessView: View {
    @StateObject private var viewModel = GratefulnessViewModel()
    @State private var showAddModal = false
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        ZStack {
            // Gradient background
            
            LinearGradient(
                gradient: Gradient(colors: [Color.purple.opacity(0.8), Color.teal.opacity(0.6), Color.blue.opacity(0.4)]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
         
            .ignoresSafeArea()
            
            VStack {
                // Header close button
                HStack {
                    Button(action: {
                        AudioManager.shared.stopBackgroundMusic()
                        dismiss()
                    }) {
                        Image(systemName: "xmark")
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.white.opacity(0.2))
                            .clipShape(Circle())
                    }
                    Spacer()
                }
                VStack {
                    HStack {
        
                        Text("Moments of Gratitude")
                            .font(.title)
                            .bold()
                            .foregroundColor(.white)
                        Spacer()
                        Button(action: { showAddModal.toggle() }) {
                            Image(systemName: "plus.circle.fill")
                                .font(.title)
                                .foregroundColor(.white)
                        }
                    }
                    .padding()
                    
                    // List with swipe-to-delete
                    List {
                        ForEach(viewModel.gratitudes, id: \.self) { item in
                            Text(" \(item)")
                                .padding()
                                .background(Color.white.opacity(0.2))
                                .foregroundColor(.white)
                                .bold()
                                .cornerRadius(15)
                                .listRowBackground(Color.clear) // Keep gradient visible
                                .listRowSeparator(.hidden)
                        }
                        .onDelete(perform: viewModel.deleteGratitude)
                    }
                    .listStyle(PlainListStyle())
                }
            }
            .sheet(isPresented: $showAddModal) {
                VStack(spacing: 20) {
                    Text("Add Gratitude")
                        .font(.title2)
                        .bold()
                    
                    TextField("I am grateful for...", text: $viewModel.newGratitudeText)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()
                    
                    Button(action: {
                        viewModel.addGratitude()
                        showAddModal = false
                    }) {
                        Text("Save")
                            .bold()
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.purple)
                            .foregroundColor(.white)
                            .cornerRadius(12)
                            .padding(.horizontal)
                    }
                    
                    Spacer()
                }
                .padding()
            }
            .onAppear(){
                AudioManager.shared.startBackgroundMusic(named: "lofi.mp3",loop: true,volume: 0.05)
            }
        }
    }
}

#Preview {
    GratefulnessView()
}
