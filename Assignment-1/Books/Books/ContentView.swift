//
//  ContentView.swift
//  Books
//
//  Created by Sunku Bhanu Kedhar Nath on
// team :
// Bhanu Kedhaar Nath Sunku (Z1974769)
// Yashwanth Raj Varikunta (Z1973107)

import SwiftUI

struct ContentView: View {
    let book = bookData
    var formatter: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        return formatter
    }
    var out = "Buy for"
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: 20) {
                VStack{
                    Image("cover")
                        .resizable()
                        .frame(width: 200, height : 250)
                        .cornerRadius(15)
                        .shadow(color: .black, radius: 7, x:5, y:5)
                    Spacer().frame(height : 30)
                    Text(book.authors)
                        .font(.system(size :20, weight: .semibold))
                        .foregroundColor(.gray)
                    Text(book.title)
                        .font(.title)
                        .bold()
                    Text(book.edition)
                        .font(.system(size:20, weight: .heavy))
                    Spacer().frame(height:30)
                    Text(book.description)
                        .foregroundColor(.gray)
                }.frame(alignment: .top)
                HStack(spacing: 20){
                    ForEach(book.categories, id: \.self){item in
                        Text(item)
                            .padding(8)
                            
                              .overlay(
                                        RoundedRectangle(cornerRadius: 20)
                                            .stroke(Color.black, lineWidth: 2)
                                    )
                    }
                }
                Divider()
                Text("\(out) \(NSNumber(value: book.price), formatter: formatter)")
                    .padding()
                    .background(.black)
                    .cornerRadius(25)
                    .foregroundColor(.white)
//                    .padding()
//                    .background(.green)
//                    .cornerRadius(30)

//                    .overlay(RoundedRectangle(cornerRadius: 25).fill(.black))
//                    .foregroundColor(.red)
            }
            .padding()
        }
//        .showsIndicators(false)
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
