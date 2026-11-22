import SwiftUI
import WebKit

@main
struct RainPoemsApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .preferredColorScheme(.dark)
        }
    }
}

struct ContentView: View {
    @State private var entered = false
    @State private var isTransitioning = false
    private let targetURL = URL(string: "https://2dx8mzjcph-a11y.github.io/rain-poems/")!

    var body: some View {
        ZStack {
            WebView(url: targetURL)
                .ignoresSafeArea()
                .scaleEffect(entered ? 1.0 : 1.05)
                .opacity(entered ? 1.0 : 0.35)
                .animation(.easeInOut(duration: 1.3), value: entered)

            if !entered {
                ZStack {
                    RadialGradient(
                        gradient: Gradient(colors: [
                            Color(red: 0.09, green: 0.11, blue: 0.16),
                            Color.black
                        ]),
                        center: .center,
                        startRadius: 20,
                        endRadius: 520
                    )
                    .ignoresSafeArea()

                    VStack(spacing: 18) {
                        Text("أهلاً بك في عالم الكاطع عن الفرح")
                            .font(.system(size: 25, weight: .bold))
                            .foregroundColor(.white)
                            .multilineTextAlignment(.center)

                        Text("كاظم إسماعيل الگاطع")
                            .font(.system(size: 17, weight: .medium))
                            .foregroundColor(.white.opacity(0.75))

                        Button(action: {
                            guard !isTransitioning else { return }
                            isTransitioning = true
                            withAnimation(.easeInOut(duration: 1.25)) {
                                entered = true
                            }
                        }) {
                            Text("الدخول إلى المشهد")
                                .font(.system(size: 16, weight: .semibold))
                                .foregroundColor(.white)
                                .padding(.horizontal, 28)
                                .padding(.vertical, 12)
                                .background(Color.white.opacity(0.12))
                                .overlay(
                                    RoundedRectangle(cornerRadius: 24)
                                        .stroke(Color.white.opacity(0.32), lineWidth: 1)
                                )
                                .cornerRadius(24)
                        }
                        .padding(.top, 14)
                    }
                    .padding(.horizontal, 28)
                    .scaleEffect(isTransitioning ? 1.08 : 1.0)
                    .opacity(isTransitioning ? 0.0 : 1.0)
                    .animation(.easeInOut(duration: 1.1), value: isTransitioning)
                }
                .opacity(entered ? 0.0 : 1.0)
                .animation(.easeInOut(duration: 1.25), value: entered)
            }
        }
    }
}

struct WebView: UIViewRepresentable {
    let url: URL
    func makeUIView(context: Context) -> WKWebView {
        let config = WKWebViewConfiguration()
        config.allowsInlineMediaPlayback = true
        config.mediaTypesRequiringUserActionForPlayback = []
        let webView = WKWebView(frame: .zero, configuration: config)
        webView.isOpaque = false
        webView.backgroundColor = .black
        webView.scrollView.isScrollEnabled = false
        webView.load(URLRequest(url: url))
        return webView
    }
    func updateUIView(_ uiView: WKWebView, context: Context) {}
}
