//
//  ContentView.swift
//  DogAgeApp
//
//  Created by Sunku Bhanu Kedhar Nath - Z1974769.
//  Created by Yaswanth Raj Varikunta - Z1973107

import SwiftUI
//import KeyboardAvoiding

struct ContentView: View {
    
    //    @State private var age = ""
    @StateObject private var viewModel = DogAgeViewModel()
    
    //    @State private var showresult = false
    
    var body: some View {
        
        
//        KeyboardAvoiding(isBounceEnabled: false) {
        ScrollView{
            ZStack{
                LinearGradient(
                    gradient: Gradient(colors: [Color(red: 44/255, green: 62/255, blue: 80/255), Color(red: 41/255, green: 128/255, blue: 185/255)]),
                    startPoint: .top,
                    endPoint: .bottom)
                
                .ignoresSafeArea()
                VStack{
                    Text("How Old Is Your Dog?")
                        .font(.custom("LazyDog", size: 40))
                        .foregroundColor(.white)
                        .padding(.top,75)
                    Spacer().frame(height: 100)
                    TextField("Enter your dog's age", text: $viewModel.age )
                    //                        .padding(.horizontal)
                        .keyboardType(.numbersAndPunctuation)
                        .textFieldStyle(.roundedBorder)
                        .padding(.horizontal)
                    Spacer().frame(height: 100)
                    Image("dog")
                        .resizable()
                        .frame(width: 200, height: 200)
                        .clipShape(Circle())
                    Spacer()
                    //                Button(action: {
                    //                    viewModel.showresult = true
                    //                    viewModel.computehumanage()
                    //
                    //
                    //                }, label: {
                    //                    Color.black
                    //                        .frame(maxWidth: 150, maxHeight: 50)
                    //                        .cornerRadius(26)
                    //                        .mask(Text("Human Age")
                    //)
                    //                })
                    //                .padding()
                    //                .frame(width: 100, height : 20)
                    //                .background(.white)
                    Button(action: {
                        viewModel.showresult = true
                        viewModel.computehumanage()
                    }, label: {
                        Text("Human Age")
                            .foregroundColor(Color.init(red: 41/255, green: 128/255, blue: 185/255))
                    }
                    )
                    .padding(15)
                    .background(.white)
                    .cornerRadius(25)
                    
                    
                    Spacer()
                    
                }
                .frame(height: UIScreen.main.bounds.height)
                
                VStack{
                    Spacer()
                    if (viewModel.showresult == true && viewModel.showalert != true){
                        Text("In human years Your dog is \(viewModel.resultText)!")
                            .foregroundColor(.white)
                    }
                    Spacer()
                        .frame(height: 50)
                }
            }
            
        }
        .ignoresSafeArea()
            .alert(isPresented: $viewModel.showalert) {
                Alert(
                    title: Text("Error"),
                    message: Text(viewModel.errorMessage)
                )
            }
            .onAppear {
                
                // Code to print all of the available font
                // names when the view appears
                
                for fontFamily in UIFont.familyNames {
                    for fontName in UIFont.fontNames(forFamilyName: fontFamily) {
                        print("\(fontName)")
                    }
                }
                
            }
//        }
    }
    
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView()
        }
    }
}
