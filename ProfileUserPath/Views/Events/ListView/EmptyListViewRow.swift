import SwiftUI

struct EmptyListViewRow: View {
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Spacer()
                HStack {
                    Spacer()
                    Text("Looks like you don't have any events!")
                        .padding(.bottom, 25)
                    Spacer()
                }
                HStack {
                    Spacer()
                    NavigationLink(destination: EventsListView()) {
                        Text("Make one")
                }
                    .foregroundColor(.blue)
                    Spacer()
                
                }
               Spacer()
            }.padding()
            Spacer()
            
        }
    }
}

struct EmptyListViewRow_Previews: PreviewProvider {
    static var previews: some View {
        EmptyListViewRow()
    }
}
