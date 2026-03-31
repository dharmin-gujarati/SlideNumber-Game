import SwiftUI

struct ContentView: View {
    @State var box : Int = 0
    @State var array : [[String]] = []
    @State var win = false
    
    
    var body: some View {
        GeometryReader { geo in
            
            let size = (min(geo.size.width, geo.size.height) - (CGFloat(box) * 5.0)) / CGFloat(box + 2)
            
            
            VStack {
                HStack {
                    Spacer()
                    ForEach (3..<8) { i in
                        Button(action: {
                            box = i
                            win = false
                            array = makeGrid2(size: i)
                            
                        }, label: {
                            Text("\(i)X\(i)")
                        })
                        
                        .background(.blue)
                    }
                    
                    Spacer()
                }
                .padding(.top, 4.0)
                .foregroundColor(/*@START_MENU_TOKEN@*/.white/*@END_MENU_TOKEN@*/)
                Spacer()
                VStack(spacing: 5) {
                    ForEach(0..<box, id: \.self) { r in
                        HStack(spacing: 5) {
                            ForEach(0..<box, id: \.self) { c in
                                Button {
                                    
                                    ButtonClick(r,c)
                                } label: {
                                    Text("\(array[r][c])")
                                        .frame(width: size, height: size)
                                        .background(Color.blue)
                                        .foregroundColor(.white)
                                        .cornerRadius(12)
                                }
                            }
                        }
                    }
                    if win {
                        Label("you won",systemImage: "")
                            .frame(maxWidth: .infinity , maxHeight: 50)
                            .background(.gray)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                            .font(.largeTitle)
                    }
                }
                
                Spacer()
            }
        }
    }
    
    
   
    func makeGrid2(size: Int) -> [[String]] {
        // Create values 1...(size*size - 1) as Strings
        var values = (1...(size * size - 1)).map { "\($0)" }
        values.append("")          // empty tile
        
        // Shuffle for random order
        values.shuffle()
        
        // Create 2D grid
        var grid: [[String]] = []
        
        for r in 0..<size {
            let startIndex = r * size
            let endIndex = startIndex + size
            let row = Array(values[startIndex..<endIndex])
            grid.append(row)
        }
        
        return grid
    }
    func ButtonClick(_ r : Int , _ c : Int) {
        var check = false
        var s = 0
        
        if win {}else{
// right
            for i in c ..< box {
                if array[r][i] == ""{
                    check = true
                    s = i
                    
                }
                
            }
            if check {
                for i in stride(from: s, through: c, by: -1){
                    if i == c{
                        array[r][i] = ""
                    }else{
                        array[r][i] = array[r][i-1]
                    }
                }
            }
// left
            for i in stride(from: c, through: 0, by: -1) {
                if array[r][i] == ""{
                    check = true
                    s = i
                    
                }
                
            }
            if check {
                for i in s ..< c + 1{
                    if i == c{
                        array[r][i] = ""
                    }else{
                        array[r][i] = array[r][i+1]
                    }
                }
            }
// down
            for i in r ..< box {
                if array[i][c] == ""{
                    check = true
                    s = i
                    
                }
                
            }
            if check {
                for i in stride(from: s, through: r, by: -1){
                    if i == r{
                        array[i][c] = ""
                    }else{
                        array[i][c] = array[i-1][c]
                    }
                }
            }
// up
            for i in stride(from: r, through: 0, by: -1) {
                if array[i][c] == ""{
                    check = true
                    s = i
                    
                }
                
            }
            if check {
                for i in s ..< r + 1{
                    if i == r{
                        array[i][c] = ""
                    }else{
                        array[i][c] = array[i+1][c]
                    }
                }
            }
        }
        var a = "0"
        var b = 0
        for i in 0 ..< box {
            for j in 0 ..< box {
                if array[i][j] == a {
                    a = String(Int(a)! + 1)
                    b = b + 1
                }
            }
        }
        if b == (box * box) - 1 {
            win = true
        }
        
    }
}

#Preview {
    ContentView()
}
//swip = array[r][c]
//array[r][c] = ""
//array[r] [c+1] = swip

