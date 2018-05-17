public class AccountHandler {

    public static Account insertNewAccount(String incPar){
        Account ret =null;
        if(incPar ==''){
            return ret;
        }
        try{
            ret = new Account(name = incPar);
            insert ret;
        }catch(DmlException e){
            System.debug('A DML exception has occurred: ' +  e.getMessage());
        }      
        return ret;
    }
}