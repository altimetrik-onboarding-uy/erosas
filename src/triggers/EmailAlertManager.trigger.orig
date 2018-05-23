trigger EmailAlertManager on Post__c (after update) {
    List<Messaging.SingleEmailMessage> messages = new List<Messaging.SingleEmailMessage>(); 
    List<Approval.ProcessSubmitRequest> approvalReqList=new List<Approval.ProcessSubmitRequest>();
    id currentUserId = UserInfo.getUserId();
    User cUser = [SELECT id,managerId,Manager.Email FROM User where id=:currentUserId];    
    //manager users email list
    string[] mUserEmail = new List<string>();   
    if(String.isNotEmpty(cUser.ManagerId)){
    mUserEmail.add(cUser.Manager.Email);  
    try {
        for(Post__c p: Trigger.new){          
            if(trigger.oldMap.get(p.Id).Status__c != p.Status__c &&  p.Status__c == 'Under Review'){
            	//generate email
                Messaging.SingleEmailMessage sg = new Messaging.SingleEmailMessage();     		
                sg.setToAddresses(mUserEmail);
        		sg.setHtmlBody('Post ' + p.name + ' sent to Under Review');
        		sg.setSubject('New Post Under Review');
                messages.add(sg);
                //generate approval request 1
                Approval.ProcessSubmitRequest req = new Approval.ProcessSubmitRequest();  
   				req.setComments('Submitted for approval. Please approve.');
   				req.setObjectId(p.id);
                req.setNextApproverIds(new List<id>{cUser.ManagerId}); 
                approvalReqList.add(req);
            }
    	}
        //send emails
        Messaging.sendEmail(messages);
        // send record for approve    
        List<Approval.ProcessResult> resultList = Approval.process(approvalReqList);
        } catch (exception e) {
            Trigger.new[0].addError('text'+e.getMessage());
     }
    }
}