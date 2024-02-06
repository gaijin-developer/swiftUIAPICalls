//
//  ContentView.swift
//  SwiftUIAPICalls
//
//  Created by Frank Entsie on 2024/02/04.
//

import SwiftUI

struct URLImage:View {
    let urlString:String
    
    @State var data: Data?
    
    var body:some View {
        if let data = data, let uiimage = UIImage(data: data) {
            Image(uiImage: uiimage)
                .resizable()
                .frame(width: 130,height: 70)
                .aspectRatio(contentMode: .fill)
                .background(Color.gray)
            
        }else {
            Image(systemName: "video")
                .resizable()
                .frame(width: 130,height: 70)
                .aspectRatio(contentMode: .fill)
                .background(Color.gray)
                .onAppear{
                    fetchData()
                }
        }
      
    }
    
    private func fetchData(){
        guard let url = URL(string:urlString) else {
            return
        }
        let task = URLSession.shared.dataTask(with: url) { data, res, error in
            self.data = data
        }
        task.resume()
    }
}


struct ContentView: View {
    @StateObject var viewModel = ViewModel()
    
    var body: some View {
        NavigationView{
            List{
                ForEach(viewModel.courses,id:\.self){
                    course in
                    HStack{                       
                        URLImage(urlString: course.image)
                          
                        Text(course.name)
                            .bold()
                    }.padding(3)
                }
            }
            .navigationTitle("Courses")
            .onAppear{
                viewModel.fetch()
            }
        }
    }
}

#Preview {
    ContentView()
}
