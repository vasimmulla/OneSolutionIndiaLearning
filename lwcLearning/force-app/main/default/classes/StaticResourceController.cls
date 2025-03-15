public with sharing class StaticResourceController {
    @AuraEnabled(cacheable=true)
    public static List<Map<String, String>> getStaticResources() {
        List<Map<String, String>> resourceList = new List<Map<String, String>>();
        
        for (StaticResource sr : [SELECT Name, BodyLength, ContentType FROM StaticResource]) {
            Map<String, String> resourceData = new Map<String, String>();
            resourceData.put('name', sr.Name);
            resourceData.put('size', String.valueOf(sr.BodyLength)); // Size in bytes
            resourceData.put('type', sr.ContentType); // MIME Type
            resourceList.add(resourceData);
        }
        
        return resourceList;
    }
}
