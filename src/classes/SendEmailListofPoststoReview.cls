global class SendEmailListofPoststoReview implements Database.Batchable<sObject>, Database.Stateful  {
    global Map<User,String> mails = new Map<User,String>();
    global Database.QueryLocator start(Database.BatchableContext bc) {
        return Database.getQueryLocator('SELECT ID,ownerid FROM Post__c Where Status__c = \'Under Review\'');
    }
    global void execute(Database.BatchableContext bc, List<sObject> scope ){
        set<id> ownersIds;
        for (sObject post : scope){ 
            Post__c p = (Post__c)post;
            ownersIds.add(p.OwnerId);                 
        }
        List<User> managerUsers = [SELECT Id,managerId FROM User where Id IN:ownersIds];
        for (User u : managerUsers) {
        	String body = 'Records Under Review: \n' ;
            mails.put(u,body);
        }
        for (sObject post : scope) {
            Post__c p = (Post__c)post;
             for (User u : managerUsers) {
                if(p.Status__c == 'Under review'){
                    String bodyM = mails.get(u)+ p.Name + '\n';
                    mails.put(u, bodyM);
                }
            }
        }
    }    
    global void finish(Database.BatchableContext bc){
        List<String> toAddresses = new List<String>();
        List<Messaging.SingleEmailMessage> messages = new List<Messaging.SingleEmailMessage>();      
        for(User u : mails.keySet()){ 
            String address1 = u.SenderEmail;            
            Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
            mail.setToAddresses(new List<String>{address1});
            mail.setHtmlBody(mails.get(u));
            messages.add(mail); 
        }      
        Messaging.sendEmail( messages );
    }    
}