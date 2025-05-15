
import SwiftUI

struct ContentView: View {
    @State private var inputText: String = ""
    @State private var result: SymbolicResponse?
    @State private var isLoading = false
    @State private var errorMessage: String?

    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                Text("SEIF-View Symbolic Drift Analyzer")
                    .font(.title2)
                    .bold()
                    .padding(.bottom)

                TextEditor(text: $inputText)
                    .frame(height: 150)
                    .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.gray))
                    .padding(.bottom)

                Button(action: analyzeText) {
                    Text("Analyze Symbolic Drift")
                        .bold()
                        .frame(maxWidth: .infinity)
                }
                .disabled(inputText.trimmingCharacters(in: .whitespaces).isEmpty)
                .padding()
                .background(inputText.isEmpty ? Color.gray : Color.blue)
                .foregroundColor(.white)
                .cornerRadius(10)

                if isLoading {
                    ProgressView("Analyzing...")
                        .padding()
                }

                if let result = result {
                    VStack(alignment: .leading, spacing: 10) {
                        Text("**Drift Score (H):** \(String(format: "%.2f", result.drift))")
                        Text("**Clarity (C):** \(String(format: "%.2f", result.clarity))")
                        Text("**Relational Coherence (R):** \(String(format: "%.2f", result.coherence))")
                        Text("**Ω Stability:** \(String(format: "%.1f", result.omega))%")
                    }
                    .padding(.top)
                }

                if let errorMessage = errorMessage {
                    Text("Error: \(errorMessage)")
                        .foregroundColor(.red)
                        .padding(.top)
                }

                Spacer()
            }
            .padding()
        }
    }

    func analyzeText() {
        isLoading = true
        errorMessage = nil

        guard let url = URL(string: "http://127.0.0.1:5000/analyze") else {
            errorMessage = "Invalid API URL"
            isLoading = false
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

        let body: [String: String] = ["text": inputText]
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: body)
        } catch {
            errorMessage = "Failed to encode request"
            isLoading = false
            return
        }

        URLSession.shared.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                isLoading = false
            }

            if let error = error {
                DispatchQueue.main.async {
                    errorMessage = error.localizedDescription
                }
                return
            }

            guard let data = data else {
                DispatchQueue.main.async {
                    errorMessage = "No data received"
                }
                return
            }

            do {
                let decoded = try JSONDecoder().decode(SymbolicResponse.self, from: data)
                DispatchQueue.main.async {
                    result = decoded
                }
            } catch {
                DispatchQueue.main.async {
                    errorMessage = "Failed to decode response: \(error.localizedDescription)"
                }
            }
        }.resume()
    }
}

struct SymbolicResponse: Codable {
    let drift: Double
    let clarity: Double
    let coherence: Double
    let omega: Double
}

@main
struct SEIFViewApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
