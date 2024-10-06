public class ImageToTextController {

    @AuraEnabled
    public static String getImageAsBase64(String documentId) {
        try {
            // Query ContentVersion using the ContentDocumentId
            ContentVersion content = [SELECT VersionData FROM ContentVersion WHERE ContentDocumentId = :documentId LIMIT 1];
            
            // Convert Blob data to Base64
            String base64Image = EncodingUtil.base64Encode(content.VersionData);
            return base64Image;
        } catch (Exception e) {
            throw new AuraHandledException('Error retrieving image: ' + e.getMessage());
        }
    }

    @AuraEnabled
    public static String getTextFromImage(String base64Image) {
        try {
            String extractedText = OCRSpaceService.extractTextFromImage(base64Image);
            return extractedText;
        } catch (Exception e) {
            throw new AuraHandledException('Error processing the image: ' + e.getMessage());
        }
    }
}
