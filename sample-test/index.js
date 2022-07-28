const cv = require('@u4/opencv4nodejs');
const classifier = new cv.CascadeClassifier(cv.HAAR_FRONTALFACE_ALT2);

const imgPath = './fakeFace.jpg'

const image = cv.imread(imgPath);
// detect faces
const { objects, numDetections } = classifier.detectMultiScale(image.bgrToGray());
console.log('faceRects:', objects);
console.log('confidences:', numDetections);