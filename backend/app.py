from flask import Flask, request, jsonify
from flask_cors import CORS
import time
import os
from datetime import datetime
from dotenv import load_dotenv

# Load environment variables
load_dotenv()  # Load .env file
load_dotenv('.secrets')  # Load .secrets file

app = Flask(__name__)

# Configure CORS from environment
cors_origins = os.getenv('CORS_ORIGINS', '*')
CORS(app, origins=cors_origins)

# Load configuration from environment
HOST = os.getenv('HOST', '0.0.0.0')
PORT = int(os.getenv('PORT', 8000))
DEBUG = os.getenv('DEBUG', 'True').lower() == 'true'
PROCESSING_DELAY = int(os.getenv('PROCESSING_DELAY_SECONDS', 2))
LOG_LEVEL = os.getenv('LOG_LEVEL', 'INFO')

# Store video URLs temporarily (in production, use a database)
video_store = {}

# Logging helper functions
def log_info(message):
    """Print info level log with timestamp"""
    timestamp = datetime.now().strftime('%Y-%m-%d %H:%M:%S')
    print(f"[{timestamp}] [INFO] {message}")

def log_success(message):
    """Print success message with timestamp"""
    timestamp = datetime.now().strftime('%Y-%m-%d %H:%M:%S')
    print(f"[{timestamp}] [✓ SUCCESS] {message}")

def log_error(message):
    """Print error message with timestamp"""
    timestamp = datetime.now().strftime('%Y-%m-%d %H:%M:%S')
    print(f"[{timestamp}] [✗ ERROR] {message}")

def log_request(endpoint, method, data=None):
    """Log incoming request"""
    timestamp = datetime.now().strftime('%Y-%m-%d %H:%M:%S')
    print(f"\n{'='*60}")
    print(f"[{timestamp}] [REQUEST] {method} {endpoint}")
    if data:
        print(f"[{timestamp}] [DATA] {data}")
    print(f"{'='*60}")

def log_response(status_code, data=None):
    """Log outgoing response"""
    timestamp = datetime.now().strftime('%Y-%m-%d %H:%M:%S')
    status_emoji = "✓" if status_code < 400 else "✗"
    print(f"[{timestamp}] [RESPONSE {status_emoji}] Status: {status_code}")
    if data:
        print(f"[{timestamp}] [RESPONSE DATA] {data}")
    print(f"{'-'*60}\n")


@app.route('/api/video', methods=['POST'])
def receive_video():
    """
    Endpoint to receive video URL from Flutter app
    """
    try:
        data = request.get_json()
        log_request('/api/video', 'POST', data)
        
        video_url = data.get('video_url')
        
        if not video_url:
            log_error('No video URL provided in request')
            response = {
                'status': 'error',
                'message': 'No video URL provided'
            }
            log_response(400, response)
            return jsonify(response), 400
        
        # Store the video URL (simulate processing)
        video_id = str(hash(video_url))
        video_store[video_id] = video_url
        
        log_info(f"Received video URL: {video_url[:50]}...")
        log_info(f"Generated video ID: {video_id}")
        log_success(f"Video stored successfully (Total videos: {len(video_store)})")
        
        response = {
            'status': 'success',
            'message': 'Video received successfully',
            'video_id': video_id
        }
        log_response(200, response)
        return jsonify(response), 200
        
    except Exception as e:
        log_error(f"Exception in receive_video: {str(e)}")
        response = {
            'status': 'error',
            'message': str(e)
        }
        log_response(500, response)
        return jsonify(response), 500


@app.route('/api/analyze', methods=['POST'])
def analyze_video():
    """
    Endpoint to analyze video based on selected action
    """
    try:
        data = request.get_json()
        log_request('/api/analyze', 'POST', data)
        
        video_url = data.get('video_url')
        action = data.get('action')
        custom_question = data.get('custom_question')
        
        if not video_url or not action:
            log_error('Missing required parameters (video_url or action)')
            response = {
                'status': 'error',
                'message': 'Missing required parameters'
            }
            log_response(400, response)
            return jsonify(response), 400
        
        log_info(f"Starting analysis...")
        log_info(f"  - Video URL: {video_url[:50]}...")
        log_info(f"  - Action: {action}")
        if custom_question:
            log_info(f"  - Custom Question: {custom_question}")
        
        # Simulate processing time
        log_info(f"Processing... (simulating {PROCESSING_DELAY} second delay)")
        time.sleep(PROCESSING_DELAY)
        
        # Generate response based on action
        log_info("Generating response based on action type...")
        response_text = generate_response(action, custom_question)
        
        log_success(f"Analysis complete for action: {action}")
        log_info(f"Response length: {len(response_text)} characters")
        
        response = {
            'status': 'success',
            'action': action,
            'custom_question': custom_question,
            'response': response_text
        }
        log_response(200, {'status': 'success', 'action': action, 'response_length': len(response_text)})
        return jsonify(response), 200
        
    except Exception as e:
        log_error(f"Exception in analyze_video: {str(e)}")
        response = {
            'status': 'error',
            'message': str(e)
        }
        log_response(500, response)
        return jsonify(response), 500


def generate_response(action, custom_question=None):
    """
    Generate simulated response based on the selected action
    """
    log_info(f"Generating response for action: {action}")
    
    responses = {
        'hoax_check': """🔍 HOAX CHECK ANALYSIS

Selected Option: Hoax Check

Simulation of conversation text:

After analyzing the video content, cross-referencing with reliable sources, and checking metadata:

✓ Video authenticity: Likely authentic
✓ Source credibility: Medium to High
✓ Content verification: No major red flags detected
⚠️ Recommendation: Always verify information from multiple sources

This is a simulated response. In production, this would include detailed fact-checking results, source verification, and AI-powered content analysis.""",
        
        'explain_this': """💡 CONTENT EXPLANATION

Selected Option: Explain This

Simulation of conversation text:

Based on the video content analysis:

The video discusses [topic]. Here's a breakdown of the key points:

1. Main Concept: The video presents information about a specific subject matter
2. Context: This relates to broader themes in [field/domain]
3. Key Takeaways:
   • Point 1: Important information presented
   • Point 2: Supporting details and evidence
   • Point 3: Conclusions or implications

This is a simulated response. In production, this would provide comprehensive explanations using AI video analysis, transcript processing, and context-aware summarization.""",
        
        'expand_idea': """🌟 IDEA EXPANSION

Selected Option: Expand This Idea

Simulation of conversation text:

Building upon the concepts in the video, here are related ideas and extensions:

🔹 Related Concepts:
   • Concept A: How this connects to broader themes
   • Concept B: Alternative perspectives to consider
   • Concept C: Future implications and developments

🔹 Further Exploration:
   • Research directions
   • Practical applications
   • Critical thinking questions

🔹 Resources for Deep Dive:
   • Academic perspectives
   • Industry insights
   • Real-world examples

This is a simulated response. In production, this would use AI to generate relevant expansions, suggest related content, and provide personalized learning paths.""",
        
        'custom_question': f"""❓ CUSTOM QUESTION RESPONSE

Selected Option: Custom Question
Your Question: {custom_question or 'No question provided'}

Simulation of conversation text:

Thank you for your question! Here's a detailed response:

Based on the video content and your specific inquiry, here's what I can provide:

1. Direct Answer: [Response tailored to your question]
2. Additional Context: [Relevant background information]
3. Related Points: [Connected ideas worth considering]

Key insights:
• Insight 1: Relevant information addressing your question
• Insight 2: Supporting details and examples
• Insight 3: Practical takeaways

This is a simulated response. In production, this would use advanced AI to understand your question, analyze the video content, and provide accurate, contextual answers."""
    }
    
    response = responses.get(action, "Simulation of conversation text - Unknown action type")
    log_success(f"Response generated successfully ({len(response)} chars)")
    return response


@app.route('/health', methods=['GET'])
def health_check():
    """
    Health check endpoint
    """
    log_request('/health', 'GET')
    
    response = {
        'status': 'healthy',
        'message': 'Backend is running',
        'version': os.getenv('API_VERSION', 'v1'),
        'timestamp': datetime.now().isoformat(),
        'port': PORT,
        'debug_mode': DEBUG
    }
    
    log_success("Health check passed")
    log_response(200, response)
    return jsonify(response), 200


if __name__ == '__main__':
    print("\n" + "="*60)
    print("🚀 Starting Video Analyzer Backend...")
    print("="*60)
    log_info(f"Loading configuration from .env and .secrets files")
    log_info(f"Server Host: {HOST}")
    log_info(f"Server Port: {PORT}")
    log_info(f"Debug Mode: {DEBUG}")
    log_info(f"Processing Delay: {PROCESSING_DELAY}s")
    log_info(f"CORS Origins: {cors_origins}")
    log_info(f"Log Level: {LOG_LEVEL}")
    print("="*60)
    print(f"📡 Server running on http://localhost:{PORT}")
    print(f"🔗 Health check: http://localhost:{PORT}/health")
    print(f"📝 API Endpoints:")
    print(f"   - POST /api/video")
    print(f"   - POST /api/analyze")
    print(f"   - GET  /health")
    print("="*60)
    log_success("Backend server starting...\n")
    app.run(debug=DEBUG, host=HOST, port=PORT)
