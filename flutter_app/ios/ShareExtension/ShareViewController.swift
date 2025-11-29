import UIKit
import Social
import MobileCoreServices
import UniformTypeIdentifiers

class ShareViewController: UIViewController {
    
    // MARK: - Properties
    private var sharedURL: String?
    private let backendURL = "http://10.10.131.31:8000" // TODO: Change to your computer's IP
    private let appGroupName = "group.com.videoanalyzer.shared"
    
    // UI Elements
    private var containerView: UIView!
    private var titleLabel: UILabel!
    private var activityIndicator: UIActivityIndicatorView!
    private var optionsStackView: UIStackView!
    private var resultTextView: UITextView!
    private var closeButton: UIButton!
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        extractSharedContent()
    }
    
    // MARK: - UI Setup
    private func setupUI() {
        // Background
        view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        
        // Container (bottom sheet style)
        containerView = UIView()
        containerView.backgroundColor = UIColor(red: 0.04, green: 0.05, blue: 0.15, alpha: 1.0) // #0A0E27
        containerView.layer.cornerRadius = 30
        containerView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        containerView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(containerView)
        
        // Title
        titleLabel = UILabel()
        titleLabel.text = "Analyze Video"
        titleLabel.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        titleLabel.textColor = .white
        titleLabel.textAlignment = .center
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(titleLabel)
        
        // Activity Indicator
        activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.color = UIColor(red: 0.42, green: 0.39, blue: 1.0, alpha: 1.0) // #6C63FF
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.hidesWhenStopped = true
        containerView.addSubview(activityIndicator)
        
        // Options Stack
        optionsStackView = UIStackView()
        optionsStackView.axis = .vertical
        optionsStackView.spacing = 16
        optionsStackView.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(optionsStackView)
        
        // Create option buttons
        createOptionButton(title: "🛡️ Hoax Check", subtitle: "Verify authenticity", action: #selector(hoaxCheckTapped), color: UIColor(red: 1.0, green: 0.42, blue: 0.42, alpha: 1.0))
        createOptionButton(title: "💡 Explain This", subtitle: "Get detailed explanation", action: #selector(explainThisTapped), color: UIColor(red: 1.0, green: 0.85, blue: 0.24, alpha: 1.0))
        createOptionButton(title: "🌟 Expand This Idea", subtitle: "Explore related concepts", action: #selector(expandIdeaTapped), color: UIColor(red: 0.31, green: 0.80, blue: 0.77, alpha: 1.0))
        
        // Result Text View (hidden initially)
        resultTextView = UITextView()
        resultTextView.backgroundColor = UIColor(red: 0.10, green: 0.12, blue: 0.33, alpha: 1.0) // #1A1E3E
        resultTextView.textColor = .white
        resultTextView.font = UIFont.systemFont(ofSize: 14)
        resultTextView.layer.cornerRadius = 12
        resultTextView.isEditable = false
        resultTextView.isHidden = true
        resultTextView.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(resultTextView)
        
        // Close Button
        closeButton = UIButton(type: .system)
        closeButton.setTitle("Done", for: .normal)
        closeButton.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        closeButton.setTitleColor(.white, for: .normal)
        closeButton.backgroundColor = UIColor(red: 0.42, green: 0.39, blue: 1.0, alpha: 1.0)
        closeButton.layer.cornerRadius = 12
        closeButton.addTarget(self, action: #selector(closeTapped), for: .touchUpInside)
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(closeButton)
        
        // Constraints
        NSLayoutConstraint.activate([
            containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            containerView.heightAnchor.constraint(equalToConstant: 500),
            
            titleLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 24),
            titleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 24),
            titleLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -24),
            
            activityIndicator.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            
            optionsStackView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 32),
            optionsStackView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 24),
            optionsStackView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -24),
            
            resultTextView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 24),
            resultTextView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 24),
            resultTextView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -24),
            resultTextView.heightAnchor.constraint(equalToConstant: 300),
            
            closeButton.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 24),
            closeButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -24),
            closeButton.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -40),
            closeButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    private func createOptionButton(title: String, subtitle: String, action: Selector, color: UIColor) {
        let button = UIButton(type: .system)
        button.backgroundColor = UIColor(red: 0.10, green: 0.12, blue: 0.33, alpha: 1.0)
        button.layer.cornerRadius = 16
        button.layer.borderWidth = 2
        button.layer.borderColor = color.withAlphaComponent(0.3).cgColor
        button.contentHorizontalAlignment = .left
        button.contentEdgeInsets = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        button.addTarget(self, action: action, for: .touchUpInside)
        
        let titleLabel = UILabel()
        titleLabel.text = title
        titleLabel.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        titleLabel.textColor = .white
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let subtitleLabel = UILabel()
        subtitleLabel.text = subtitle
        subtitleLabel.font = UIFont.systemFont(ofSize: 13)
        subtitleLabel.textColor = UIColor.white.withAlphaComponent(0.7)
        subtitleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        button.addSubview(titleLabel)
        button.addSubview(subtitleLabel)
        
        NSLayoutConstraint.activate([
            button.heightAnchor.constraint(equalToConstant: 80),
            titleLabel.topAnchor.constraint(equalTo: button.topAnchor, constant: 16),
            titleLabel.leadingAnchor.constraint(equalTo: button.leadingAnchor, constant: 16),
            subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4),
            subtitleLabel.leadingAnchor.constraint(equalTo: button.leadingAnchor, constant: 16)
        ])
        
        optionsStackView.addArrangedSubview(button)
    }
    
    // MARK: - Extract Shared Content
    private func extractSharedContent() {
        guard let extensionItem = extensionContext?.inputItems.first as? NSExtensionItem,
              let attachments = extensionItem.attachments else {
            showError("No content shared")
            return
        }
        
        print("[SHARE EXTENSION] Processing \(attachments.count) attachments")
        
        for attachment in attachments {
            // Check for URL
            if attachment.hasItemConformingToTypeIdentifier(UTType.url.identifier) {
                attachment.loadItem(forTypeIdentifier: UTType.url.identifier, options: nil) { [weak self] (item, error) in
                    if let url = item as? URL {
                        print("[SHARE EXTENSION] ✓ Received URL: \(url.absoluteString)")
                        DispatchQueue.main.async {
                            self?.sharedURL = url.absoluteString
                            self?.sendVideoToBackend()
                        }
                    }
                }
                return
            }
            
            // Check for text/URL as string
            if attachment.hasItemConformingToTypeIdentifier(UTType.plainText.identifier) {
                attachment.loadItem(forTypeIdentifier: UTType.plainText.identifier, options: nil) { [weak self] (item, error) in
                    if let text = item as? String {
                        print("[SHARE EXTENSION] ✓ Received text: \(text)")
                        DispatchQueue.main.async {
                            self?.sharedURL = text
                            self?.sendVideoToBackend()
                        }
                    }
                }
                return
            }
        }
        
        showError("Couldn't extract URL from shared content")
    }
    
    // MARK: - Backend Communication
    private func sendVideoToBackend() {
        guard let urlString = sharedURL else {
            showError("No URL to process")
            return
        }
        
        print("[SHARE EXTENSION] Sending to backend: \(backendURL)/api/video")
        activityIndicator.startAnimating()
        
        guard let url = URL(string: "\(backendURL)/api/video") else {
            showError("Invalid backend URL")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let body: [String: Any] = ["video_url": urlString]
        request.httpBody = try? JSONSerialization.data(withJSONObject: body)
        
        URLSession.shared.dataTask(with: request) { [weak self] data, response, error in
            DispatchQueue.main.async {
                self?.activityIndicator.stopAnimating()
                
                if let error = error {
                    print("[SHARE EXTENSION] ✗ Error: \(error.localizedDescription)")
                    self?.showError("Failed to connect to backend: \(error.localizedDescription)")
                    return
                }
                
                guard let httpResponse = response as? HTTPURLResponse,
                      httpResponse.statusCode == 200 else {
                    print("[SHARE EXTENSION] ✗ Invalid response")
                    self?.showError("Backend returned error")
                    return
                }
                
                print("[SHARE EXTENSION] ✓ Video received by backend")
                // Options are already visible, user can now tap one
            }
        }.resume()
    }
    
    private func analyzeVideo(action: String) {
        guard let urlString = sharedURL else { return }
        
        print("[SHARE EXTENSION] Analyzing with action: \(action)")
        
        // Hide options, show loading
        optionsStackView.isHidden = true
        titleLabel.text = "Analyzing..."
        activityIndicator.startAnimating()
        
        guard let url = URL(string: "\(backendURL)/api/analyze") else {
            showError("Invalid backend URL")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let body: [String: Any] = [
            "video_url": urlString,
            "action": action,
            "custom_question": NSNull()
        ]
        request.httpBody = try? JSONSerialization.data(withJSONObject: body)
        
        print("[SHARE EXTENSION] Waiting for backend response...")
        
        URLSession.shared.dataTask(with: request) { [weak self] data, response, error in
            DispatchQueue.main.async {
                self?.activityIndicator.stopAnimating()
                
                if let error = error {
                    print("[SHARE EXTENSION] ✗ Error: \(error.localizedDescription)")
                    self?.showError("Analysis failed: \(error.localizedDescription)")
                    return
                }
                
                guard let data = data,
                      let httpResponse = response as? HTTPURLResponse,
                      httpResponse.statusCode == 200 else {
                    print("[SHARE EXTENSION] ✗ Invalid response")
                    self?.showError("Backend returned error")
                    return
                }
                
                do {
                    if let json = try JSONSerialization.jsonObject(with: data) as? [String: Any],
                       let responseText = json["response"] as? String {
                        print("[SHARE EXTENSION] ✓ Analysis complete (\(responseText.count) chars)")
                        self?.showResult(responseText)
                    }
                } catch {
                    print("[SHARE EXTENSION] ✗ JSON parse error: \(error)")
                    self?.showError("Failed to parse response")
                }
            }
        }.resume()
    }
    
    // MARK: - UI Updates
    private func showResult(_ text: String) {
        titleLabel.text = "✓ Analysis Complete"
        resultTextView.text = text
        resultTextView.isHidden = false
        optionsStackView.isHidden = true
    }
    
    private func showError(_ message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Close", style: .default) { [weak self] _ in
            self?.closeTapped()
        })
        present(alert, animated: true)
    }
    
    // MARK: - Actions
    @objc private func hoaxCheckTapped() {
        analyzeVideo(action: "hoax_check")
    }
    
    @objc private func explainThisTapped() {
        analyzeVideo(action: "explain_this")
    }
    
    @objc private func expandIdeaTapped() {
        analyzeVideo(action: "expand_idea")
    }
    
    @objc private func closeTapped() {
        print("[SHARE EXTENSION] Closing extension")
        extensionContext?.completeRequest(returningItems: nil, completionHandler: nil)
    }
}


