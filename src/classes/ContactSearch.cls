public class ContactSearch {
    public static List<Contact> searchForContacts(String name, String postalCode){
        
        List<Contact> ret =[SELECT Id,Name 
                            FROM Contact
        				    WHERE(LastName =: name AND
                                  MailingPostalCode =: postalCode)];  
       
        return ret;       
    }
}