import SwiftUI

struct ImgPickCard: View {
    @Binding var imgStringItem: String?
    var frameWidth: CGFloat = 148
    var frameHeight: CGFloat = 148
    var adaptiveHeight: Bool = false
    var imgSFSize: CGFloat = 16
    var cornRadius: CGFloat = 14
    var imgSF: String = "plus"
    var foreColor: Color = .labelPrime
    var bgColor: Color = .cyanC
    
    var calcHeight: CGFloat { UIScreen.main.bounds.height / frameHeight }
    
    var image: UIImage {
        if let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent(imgStringItem ?? ""),
           let imageData = try? Data(contentsOf: url) {
            return UIImage(data: imageData) ?? UIImage(systemName: "photo")!
        }
        if let imgS = imgStringItem {
            return UIImage(imageLiteralResourceName: imgS)
        }
        return UIImage(systemName: "photo")!
    }
    var haveImage: Bool {
        imgStringItem ?? "" != ""
    }
    
    var body: some View {
        ZStack {
            if haveImage {
                VStack(spacing: 4) {
                    Image (uiImage: image)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .clipped()
                }
            } else {
                VStack(spacing: 17) {
                    Image(systemName: imgSF)
                        .font(Font.system(size: imgSFSize, weight: .medium))
                        .foregroundColor(foreColor)
                }
            }
        }
        .frame(maxWidth: frameWidth)
        .frame(height: adaptiveHeight ? CGFloat(Double(Int(UIScreen.main.bounds.height)) / calcHeight) : frameHeight) // 114 px
        .background(bgColor)
//        .overlay(RoundedRectangle(cornerRadius: cornRadius).stroke(Color.bgLight, lineWidth: haveImage ? 0 : 2))
        .cornerRadius(cornRadius)
        .clipped()
        .contentShape(Rectangle())
    }
}


#Preview {
    ImgPickCard(imgStringItem: .constant(""))
        
//    ImgPickCardEdit(imgStringItem: .constant(""))
//        .padding()
//        .background(Color.bgMain)
}

struct ImgPickCardEdit: View {
    @State private var isPickerShow = false
    @Binding var imgStringItem: String?
    var frameWidth: CGFloat = UIScreen.main.bounds.width - 32
    var frameHeight: CGFloat = 280
    var adaptiveHeight: Bool = false
    var cornRadius: CGFloat = 14
    
    var body: some View {
        ZStack {
            ImgPickCard(imgStringItem: $imgStringItem,
                        frameWidth: frameWidth,
                        frameHeight: frameHeight,
                        adaptiveHeight: adaptiveHeight,
                        cornRadius: cornRadius,
                        imgSF: "plus",
                        foreColor: .labelPrime,
                        bgColor: .cyanC
            )
                .onTapGesture {
                    isPickerShow.toggle()
                }
        }
        .sheet(isPresented: $isPickerShow) {
            ImagePicker(imageString: $imgStringItem)
        }
    }
}
