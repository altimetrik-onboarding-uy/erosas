public  class StringArrayTest {

    public static List<String> generateStringArray(Integer vari){
        List<String> listReturn= new List<String>();
        
        for(Integer i=0; i<vari; i++){
            listReturn.add('Test ' +i);
        }
        return listReturn;
    }
}