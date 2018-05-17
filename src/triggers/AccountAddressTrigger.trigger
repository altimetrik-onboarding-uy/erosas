trigger AccountAddressTrigger on Account (before  insert, before  update) { 
    if (Trigger.isInsert) {
        for(Account a : Trigger.New) {
            if((a.BillingPostalCode != '') && (a.Match_Billing_Address__c)){
                a.ShippingPostalCode =a.BillingPostalCode;  
            }
            
        } 
    }
    if (Trigger.isUpdate) {
        for(Account a : Trigger.Old) {
            if((a.BillingPostalCode != '')&&(a.Match_Billing_Address__c)){
                a.ShippingPostalCode =a.BillingPostalCode;  
            }
            
        } 
    }
}