({
    handleRecordUpdated: function(component, event, helper) {
       var eventParams = event.getParams();
       if(eventParams.changeType === "LOADED") { 
           var statuss= component.get("v.postRecord.Status__c");
           helper.markStatus(component,statuss); 
       }else if(eventParams.changeType === "ERROR") {
           var er = "record can not be leaded";
           helper.ErrorMessageOnLoadRecord(component,er);
       }else if(eventParams.changeType === "CHANGED"){
           component.find('postRecordLoader').reloadRecord(true); 
       }
   },
    onPicklistChange: function(component, event, helper) {
        var statuss= component.get("v.postRecord.Status__c");
        try{ 
            if(statuss=="Draft"){
                var newStatus="Under Review";
                component.set("v.postRecord.Status__c",newStatus);
                component.find("postRecordLoader").saveRecord($A.getCallback(function(saveResult) {
                    if (saveResult.state === "SUCCESS" || saveResult.state === "DRAFT"){
                        helper.markStatus(component, newStatus);
                    }else if (saveResult.state === "ERROR") {
                        helper.sendMessage(component,saveResult);   
                    }
                }));               
            }else{
                if(statuss=="Ready"){
                    var newStatus="Published";
                    component.set("v.postRecord.Status__c",newStatus);
                    component.find("postRecordLoader").saveRecord($A.getCallback(function(saveResult) {
                        if (saveResult.state === "SUCCESS" || saveResult.state === "DRAFT"){
                            helper.markStatus(component, newStatus);
                        }else if (saveResult.state === "ERROR") {
                            helper.sendMessage(component,saveResult);                      
                        }
                    }));
                }
            }
            
        }catch(exception){
            helper.sendMessage(component,saveResult);   
        }
    },
})