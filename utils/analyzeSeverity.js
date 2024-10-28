// utils/analyzeSeverity.js
import fetch from 'node-fetch';

export async function analyzeSeverity(description) {
//    console.log('Analyzing severity for description:', description);
    const response = await fetch(`https://api.wit.ai/message?v=20241026&q=${encodeURIComponent(description)}`, {
        headers: {
            Authorization: `Bearer YDKLF6P5RRR7UJY42X74B2ONQIPGRPIT`
        }
    });

    const data = await response.json();
//    console.log('Wit.ai response:', JSON.stringify(data, null, 2)); // Log the full response

    if (data.entities && data.entities.severity && data.entities.severity.length > 0) {
   //     console.log('Detected severity:', data.entities.severity[0].value);
        return data.entities.severity[0].value; // Return the detected severity
    }
    return 'unknown'; // Return 'unknown' if no severity was found
}
