import SwiftUI

// Swift + SwiftUI sample
struct User: Identifiable, Codable {
    let id: UUID
    var name: String
    var age: Int = 0
}

enum LoadState {
    case idle
    case loading
    case loaded([User])
    case failed(Error)
}

@MainActor
final class UserViewModel: ObservableObject {
    @Published private(set) var state: LoadState = .idle
    private let maxCount = 10

    func load() async {
        state = .loading
        do {
            let users = try await fetchUsers(limit: maxCount)
            state = .loaded(users)
        } catch {
            state = .failed(error)
        }
    }

    private func fetchUsers(limit: Int) async throws -> [User] {
        guard limit > 0 else { return [] }
        return [User(id: UUID(), name: "Alex", age: 21)]
    }
}

struct ContentView: View {
    @StateObject private var viewModel = UserViewModel()
    @State private var count = 0

    var body: some View {
        VStack(spacing: 12) {
            Text("Count: \(count)")
                .font(.title)
                .foregroundColor(.blue)
            Button("Add") {
                count += 1
            }
            .padding()
        }
        .task { await viewModel.load() }
    }
}
