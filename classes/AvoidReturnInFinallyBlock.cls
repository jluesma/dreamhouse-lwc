public class AvoidReturnInFinallyBlock {
    
    @future
    public static void processRecords()
    {   
         // Get those records based on the IDs
         List<Account> accts;
         // Process records
    }
    
    
    public void databaseMethodInsideOfLoop(List<Account> accounts) {
        for (Account a : accounts) {
            Database.insert(a);
        }
    }

    public void dmlInsideOfLoop() {
        for (Integer i = 0; i < 151; i++) {
            Account account;
            // ...
            insert account;
        }
    }

    public void soqlInsideOfLoop() {
        for (Integer i = 0; i < 10; i++) {
            List<Account> accounts = [SELECT Id FROM Account];
        }
    }

    public void soslInsideOfLoop() {
        for (Integer i = 0; i < 10; i++) {
            List<List<SObject>> searchList = [FIND 'map*' IN ALL FIELDS RETURNING Account (Id, Name), Contact, Opportunity, Lead];
        }
    }

    public void messageInsideOfLoop() {
        for (Integer i = 0; i < 10; i++) {
            Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
            Messaging.sendEmail(new Messaging.SingleEmailMessage[]{email});
        }
    }
    
    public void futureInsideOfLoop() {
        for (Integer i = 0; i < 10; i++) {
            processRecords();
        }
    }

    public void approvalInsideOfLoop(Account[] accs) {
        for (Integer i = 0; i < 10; i++) {
            Account acc = accs[i];
            Approval.ProcessSubmitRequest req = new Approval.ProcessSubmitRequest();
            req.setObjectId(acc.Id);
            Approval.process(req);
            Approval.lock(acc);
            Approval.unlock(acc);
        }
        
        try {
                  
        } Catch (Exception e) {
            throw new AuraHandledException('System Error');
        } finally {
            throw new AuraHandledException('System Error');
        } 
    }

}