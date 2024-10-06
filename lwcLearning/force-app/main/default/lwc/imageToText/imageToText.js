import { LightningElement, track } from 'lwc';
import getImageAsBase64 from '@salesforce/apex/ImageToTextController.getImageAsBase64';
import getTextFromImage from '@salesforce/apex/ImageToTextController.getTextFromImage';

export default class ImageToText extends LightningElement {
    @track extractedText = '';
    @track error = '';
    @track isLoading = false;

    recordId;

    // Handle file upload and call the Apex method
    handleUploadFinished(event) {
        const uploadedFiles = event.detail.files;
        if (uploadedFiles.length > 0) {
            const fileId = uploadedFiles[0].documentId;

            // Convert image to base64 via Apex
            this.isLoading = true;
            this.convertImageToBase64(fileId);
        }
    }

    // Convert the uploaded file to base64 by calling Apex method
    convertImageToBase64(fileId) {
        getImageAsBase64({ documentId: fileId })
            .then((base64Image) => {
                // Once base64 is retrieved, extract text
                this.extractText(base64Image);
            })
            .catch((error) => {
                this.isLoading = false;
                this.error = 'Error retrieving image as base64: ' + error.body.message;
            });
    }

    // Call Apex method to extract text
    extractText(base64Image) {
        getTextFromImage({ base64Image: base64Image })
            .then((result) => {
                console.log('Extracted Text: ', result);  // Debug: Print the result
                this.extractedText = result;  // Assign the result to the extractedText tracked variable
                this.isLoading = false;
            })
            .catch((error) => {
                console.error('Error extracting text: ', error.body.message);
                this.error = 'Error extracting text from image: ' + error.body.message;
                this.isLoading = false;
            });
    }
}
