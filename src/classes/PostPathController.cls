public class PostPathController {
 @AuraEnabled
 public static List < String > getPostStatus() {  
  List < String > status = new list < String > ();    
  //Get object info 
  Schema.DescribeSObjectResult ObjInfo = Schema.Post__c.getSObjectType().getDescribe(); 
  // Get a map of fields for the SObject
  map < String, Schema.SObjectField > fieldMap = ObjInfo.fields.getMap(); 
  // Get the list of picklist values for this field.
  list < Schema.PicklistEntry > values = fieldMap.get('Status__c').getDescribe().getPickListValues(); 
  // Add these values to the selectoption list.
  for (Schema.PicklistEntry a: values) {
   status.add(a.getValue());
  }
  system.debug('allOpts ---->' + status);
  status.sort();     
  return status;
 }
}