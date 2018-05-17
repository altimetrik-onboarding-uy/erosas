public class ContactAndLeadSearch {
    public static List<List< SObject>> searchContactsAndLeads(string str){
        System.debug('---------------');
        List<List< SObject>> ret;
        try{
        System.debug('bbbbbbbbbb');
        Account ac= new Account(Name ='Smith',
                               	Phone='(415)555-1212',
                                NumberOfEmployees = 50,
                                BillingCity='Smith');
        upsert ac;
        ID acID = ac.ID;
        Contact c = new Contact(FirstName='Smith',
            					LastName='Smith',
                                Phone ='(415)555-1212',
                                Department ='Smith',
                                AccountId = acID);
        upsert c;
        Lead l = new Lead(LastName='Smith');
        upsert l;
       
        ret= [FIND :str IN ALL FIELDS  RETURNING Contact,Lead];
        }catch(DmlException e) {
            System.debug('aaaaaaaaaaa');
        }
		  
        
        return ret;
    }
}