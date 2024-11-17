// Array of uplifting quotes for bullying victims
const quotes = [
    '"No one can make you feel inferior without your consent." - Eleanor Roosevelt',
    '"We rise by lifting others." - Robert Ingersoll',
    '"You can’t control how other people treat you, but you can control how you respond to it." - Brian Tracy',
    '"Bullying is not a reflection of your worth, but of the bully’s insecurities." - Anonymous',
    '"Courage is fire, and bullying is smoke." - Benjamin Disraeli',
    '"In a world where you can be anything, be kind." - Jennifer Dukes Lee',
    '"The greatest glory in living lies not in never falling, but in rising every time we fall." - Nelson Mandela'
];

// Function to set a random quote
function setRandomQuote() {
    const randomIndex = Math.floor(Math.random() * quotes.length);
    document.getElementById("quote").innerText = quotes[randomIndex];
}

// Set a random quote when the page loads
window.onload = setRandomQuote;




// Chatbot responses with follow-up questions
const chatbotResponses = {
    greeting: [
        "Hello! I'm here to listen. How are you feeling today?",
        "Hi there! You can talk to me anytime. How are you doing?",
        "Hey! I’m here to support you. What’s on your mind?",
        "Hello! I’m always here to help you. How are things going today?"
    ],
    mild: [
        "It's important to remember that your feelings are valid. How about we discuss ways to cope with this?",
        "Talking about it can really help. You're not alone in this! What have you tried so far to address this?",
        "I understand how that can feel. Do you want to talk about what's been going on?",
        "Sometimes, little things can build up. What’s been bothering you the most?",
        "It’s okay to feel frustrated. Let’s see if we can find a way to make things easier.",
        "Everyone goes through tough moments. How can I help you get through this?",
        "It can be helpful to talk things out. Do you want to share more with me?",
        "I can tell you're going through something. Would you like to discuss it?"
    ],
    severe: [
        "I'm really sorry to hear you're experiencing this. It's vital to talk to someone who can help. Would you like to report this situation?",
        "Your safety matters. If you want to discuss reporting this, I'm here to support you. Is there someone you trust that you can reach out to?",
        "I’m concerned about what you’re going through. Do you need help right away? I can assist with reporting if needed.",
        "It sounds like this has really impacted you. Would you feel comfortable getting help for this?",
        "I’m really sorry you're going through this. Do you want to reach out to someone who can help right now?",
        "Your well-being is the most important thing. Would you like assistance in finding someone to talk to?",
        "I'm here for you. Please let me know if you need help in getting support or reporting anything.",
        "It must be incredibly tough. Let me know if you'd like help in reporting or seeking professional support."
    ],
    neutral: [
        "Thank you for sharing your thoughts. Can you tell me more about what's been bothering you?",
        "It's okay to talk about it. What's on your mind right now?",
        "I'm here to listen. What would help you feel better right now?",
        "Feel free to share as much or as little as you like. I’m here to listen.",
        "It sounds like you have a lot on your mind. Can you tell me more about it?",
        "I understand you're going through a lot. Would you like to talk more about it?",
        "Sometimes, just talking things through can be helpful. What’s been happening?",
        "I’m here to listen whenever you're ready. What’s on your mind today?"
    ],
    encouraging: [
        "You’re doing your best, and that’s enough. Take things one step at a time.",
        "It’s okay to feel what you’re feeling. You’re stronger than you think.",
        "Remember, it’s okay to ask for help. Everyone needs support sometimes.",
        "You’re not alone in this. Take your time, and we’ll figure it out together.",
        "You’re doing great, even if it doesn’t always feel that way.",
        "No matter what you're facing, you're capable of handling it. Take it one day at a time.",
        "It’s okay to go slow. What matters is that you’re moving forward.",
        "Take a deep breath. You're making progress, even if it doesn’t seem like it."
    ]
};


let messageCount = 0;
let awaitingReportResponse = false; 
let inactivityTimer; 
const conversationHistory = [];

function classifySeverity(message) {
    const mildKeywords = [
        "tease", "joke", "annoy", "ignore", "biru-biruan", "pang-aasar", 
        "ini-ignore", "maliit na bagay", "nanghihirang", "peste", "biro", 
        "huwag seryosohin", "just kidding", "lighthearted", "playful", "not serious", 
        "masama lang ang loob", "huwag pansinin"
    ];
    
    const severeKeywords = [
        "hit", "threaten", "cyberbully", "harass", "attack", "saktan", 
        "banta", "pambu-bully", "pangha-harass", "inaatake", "suicide", 
        "self-harm", "abuse", "kill", "hurt", "stalk", "violent", "slap", 
        "beaten", "punch", "danger", "trauma", "bullying", "rape", "torture",
        "papatay", "takot", "patayin", "mangharrass", "bantang mamatay"
    ];
    
    const neutralKeywords = [
        "confused", "help", "sad", "lonely", "depressed", "frustrated", 
        "feeling down", "isolated", "stressed", "troubled", "annoyed", 
        "okay", "good", "bad", "normal", "unsure", "okay lang", "hindi masyado okay",
        "medyo okay", "gusto ko ng tulong", "nakakalungkot", "hindi ko alam", 
        "saan na ako pupunta", "how can I fix this?", "I’m okay", "nothing special"
    ];
    
    const lowerCaseMessage = message.toLowerCase();
    
    // Check for mild severity
    if (mildKeywords.some(keyword => lowerCaseMessage.includes(keyword))) return "mild";
    
    // Check for severe severity
    if (severeKeywords.some(keyword => lowerCaseMessage.includes(keyword))) return "severe";
    
    // Check for neutral severity
    if (neutralKeywords.some(keyword => lowerCaseMessage.includes(keyword))) return "neutral";
    
    return "neutral"; // Default to neutral if no keywords match
}



function toggleChatbot() {
    const chatbot = document.getElementById("chatbot");
    chatbot.style.display = chatbot.style.display === "none" || chatbot.style.display === "" ? "flex" : "none";

    // If this is the first time the chatbot is opened, send a greeting
    if (messageCount === 0) {
        const greetingResponse = chatbotResponses.greeting[Math.floor(Math.random() * chatbotResponses.greeting.length)];
        showTypingIndicator();
        setTimeout(() => {
            hideTypingIndicator();
            addMessage("bot", greetingResponse);
        }, 1000);
    }
}

// Enhanced function to simulate AI by analyzing previous inputs
async function respondToMessage(userMessage) {
    conversationHistory.push(userMessage); // Add the user's message to history

    if (messageCount < 20) {
        const severity = classifySeverity(userMessage);
        let response;

        if (awaitingReportResponse) {
            handleReportResponse(userMessage);
            return;
        }

        showTypingIndicator();

        // Get response based on severity and dynamically select an appropriate quote
        response = chatbotResponses[severity][Math.floor(Math.random() * chatbotResponses[severity].length)];

        setTimeout(() => {
            hideTypingIndicator();
            addMessage("bot", response);
        }, 1500); // Simulate delay for typing

        setRandomQuote(severity); // Set a relevant uplifting quote based on severity
        messageCount++;

        // Offer report option after 5 messages or if keywords related to reporting are mentioned
        if (messageCount === 5 || userMessage.toLowerCase().includes("report") || userMessage.toLowerCase().includes("i-report")) {
            awaitingReportResponse = true;
            setTimeout(() => {
                addMessage("bot", "Would you like to report this situation? (yes/no)");
            }, 1000);
        }
    } else {
        setTimeout(() => {
            addMessage("bot", "You will now be redirected to a real person for further assistance. Please hold on a moment...");
            setTimeout(() => window.location.href = "http://localhost:3000/report", 2000); // Redirect to Google Form
        }, 1000);
    }
}

// Function to handle reporting response
async function handleReportResponse(userMessage) {
    const lowerCaseMessage = userMessage.toLowerCase();
    if (lowerCaseMessage === "yes" || lowerCaseMessage === "oo" || lowerCaseMessage.includes("report")) {
        addMessage("bot", "Thank you for your willingness to report this. You will be redirected to the reporting form.");
        setTimeout(() => {
            window.location.href = "http://localhost:3000/report"; // Redirect to Google Form
        }, 2000);
    } else if (lowerCaseMessage === "no" || lowerCaseMessage === "hindi") {
        addMessage("bot", "That's okay! If you need to talk about it or need any help, I'm here.");
    } else {
        addMessage("bot", "I didn't quite get that. Would you like to report this situation? (yes/no)");
    }
    awaitingReportResponse = false; // Reset flag
}

// Function to handle sending messages
function sendMessage() {
    const input = document.getElementById("chatbot-input");
    const userMessage = input.value.trim();
    if (userMessage) {
        addMessage("user", userMessage);
        respondToMessage(userMessage);
        input.value = ""; // Clear the input field
        resetInactivityTimer(); // Reset inactivity timer on new message
    }
}

// Add message to chatbot
function addMessage(sender, text, isClickable = false) {
    const chatbotBody = document.getElementById("chatbot-body");
    const messageElement = document.createElement("div");
    messageElement.classList.add("message", sender);

    if (isClickable) {
        const clickableElement = document.createElement("span");
        clickableElement.innerText = text;
        clickableElement.classList.add("clickable");
        clickableElement.onclick = () => handleClickableMessage(text);
        messageElement.appendChild(clickableElement);
    } else {
        messageElement.innerText = text;
    }

    chatbotBody.appendChild(messageElement);
    chatbotBody.scrollTop = chatbotBody.scrollHeight; // Scroll to the bottom
}

// Add keydown event listener for the input field
document.getElementById("chatbot-input").addEventListener("keydown", function(event) {
    if (event.key === "Enter") {
        event.preventDefault();
        sendMessage(); // Call the sendMessage function
    }
});

// Timer functions for inactivity
function resetInactivityTimer() {
    clearTimeout(inactivityTimer); // Clear the previous timer
    inactivityTimer = setTimeout(() => {
        clearConversation(); // Call function to clear conversation after 30 seconds
    }, 30000); // 30 seconds
}

function clearConversation() {
    const chatbotBody = document.getElementById("chatbot-body");
    chatbotBody.innerHTML = ""; // Clear the chat history
    messageCount = 0; // Reset message count
    addMessage("bot", "The conversation has been cleared due to inactivity. Please feel free to start a new conversation.");
}

// Hamburger menu toggle for mobile navigation
const hamburger = document.getElementById('hamburger');
const navLinks = document.getElementById('nav');

hamburger.addEventListener('click', () => {
    navLinks.classList.toggle('active');
});

// Typing indicator functions
function showTypingIndicator() {
    const chatbotBody = document.getElementById("chatbot-body");
    const typingElement = document.createElement("div");
    typingElement.classList.add("message", "bot", "typing");
    typingElement.setAttribute("id", "typing-indicator");
    typingElement.innerText = "Safepath AI is typing...";
    chatbotBody.appendChild(typingElement);
    chatbotBody.scrollTop = chatbotBody.scrollHeight; // Scroll to the bottom
}

function hideTypingIndicator() {
    const typingElement = document.getElementById("typing-indicator");
    if (typingElement) {
        typingElement.remove();
    }
}
