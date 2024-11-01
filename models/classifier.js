// import * as tf from '@tensorflow/tfjs';
// import trainingData from '../data/trainingData.js';

// // Step 1: Prepare vocabulary and tokenize
// const vocab = new Set();
// trainingData.forEach(item => {
//     item.input.toLowerCase().split(" ").forEach(word => vocab.add(word));
// });
// const wordIndex = {};
// Array.from(vocab).forEach((word, i) => wordIndex[word] = i + 1);

// // Convert text to tensor-friendly sequence
// function textToTensor(text) {
//     const words = text.toLowerCase().split(" ");
//     const sequence = words.map(word => wordIndex[word] || 0);
//     return sequence;
// }

// // Prepare the data
// const xs = trainingData.map(item => textToTensor(item.input));
// const ys = trainingData.map(item => {
//     if (item.output === "severe") return [1, 0, 0];
//     if (item.output === "mild") return [0, 1, 0];
//     return [0, 0, 1];
// });

// // Optional: Pad sequences
// const maxLen = Math.max(...xs.map(seq => seq.length));
// const paddedXs = xs.map(seq => {
//     while (seq.length < maxLen) seq.push(0);
//     return seq;
// });

// // Convert data to tensors
// const xsTensor = tf.tensor2d(paddedXs);
// const ysTensor = tf.tensor2d(ys);

// // Define and compile model
// const model = tf.sequential();
// model.add(tf.layers.embedding({ inputDim: vocab.size + 1, outputDim: 16, inputLength: maxLen }));
// model.add(tf.layers.flatten());
// model.add(tf.layers.dense({ units: 16, activation: 'relu' }));
// model.add(tf.layers.dense({ units: 3, activation: 'softmax' }));

// model.compile({
//     optimizer: 'adam',
//     loss: 'categoricalCrossentropy',
//     metrics: ['accuracy']
// });

// // Train model
// async function train() {
//     await model.fit(xsTensor, ysTensor, {
//         epochs: 100,
//         batchSize: 8,
//         shuffle: true
//     });
//     console.log('Model training complete');
// }

// // Classification function
// async function classifySeverity(message) {
//     const inputTensor = tf.tensor2d([textToTensor(message).concat(Array(maxLen - textToTensor(message).length).fill(0))]);
//     const prediction = model.predict(inputTensor);
//     const result = await prediction.data();

//     const labels = ["severe", "mild", "neutral"];
//     const maxIndex = result.indexOf(Math.max(...result));
    
//     // Dispose of tensors to free memory
//     inputTensor.dispose();
//     return labels[maxIndex];
// }

// // Export functions
// export { train, classifySeverity };
