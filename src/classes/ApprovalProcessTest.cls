@isTest
public class ApprovalProcessTest {
	
    Static testMethod void sendForApproveTest(){
        Post__c p = new Post__c();
        p.Name = 'Post name 678';
        insert p;
        Test.startTest();
        p.Status__c = 'Under Review';
        update p;
        List<ProcessInstance> processInstances = [select Id, Status from ProcessInstance where TargetObjectId = :p.id];
        System.assertEquals(processInstances.size(),1);       
        Test.stopTest();  
    }
        
        
        
}