global class CreateTaskEmailExample implements Messaging.InboundEmailHandler {
 
  global Messaging.InboundEmailResult handleInboundEmail(Messaging.inboundEmail email, 
                                                       Messaging.InboundEnvelope env){
 
    // Create an InboundEmailResult object for returning the result of the 
    // Apex Email Service
    Messaging.InboundEmailResult result = new Messaging.InboundEmailResult();
  
    String myPlainText= '';
    String sender='';
    
    // Add the email plain text into the local variable 
    sender = email.fromAddress;
    myPlainText = email.plainTextBody;
   
    // New Task object to be created
    Task[] newTask = new Task[0];
    Issue__c newIssue = new Issue__c();
   
    // Try to look up any contacts based on the email from address
    // If there is more than one contact with the same email address,
    // an exception will be thrown and the catch statement will be called.
    try {
      /*Contact vCon = [SELECT Id, Name, Email
        FROM Contact
        WHERE Email = :email.fromAddress
        LIMIT 1];*/
      
      // Add a new Task to the contact record we just found above.
      //if(email.fromAddress == 'pablo@pabeli.com')
      //newIssue.name = email.fromAddress;

      //if(email.fromAddress == 'pablo.romero@salesforce.com')
      newIssue.name = email.subject + 'PLEASE CHANGE';
      newIssue.Email_Body__c = email.plainTextBody;
      newIssue.Email_Subject__c = email.subject;
      newIssue.Email_Sender__c = email.fromAddress;

      /*newTask.add(new Task(Description =  myPlainText,
           Priority = 'Normal',
           Status = 'Inbound Email',
           Subject = email.subject,
           IsReminderSet = true,
           ReminderDateTime = System.now()+1,
           WhoId =  '0031900000OGjV2AAL'));*/
     
     // Insert the new Task 
     //insert newTask;
     insert newIssue;
     
     System.debug('New Task Object: ' + newTask );   
    }
    // If an exception occurs when the query accesses 
    // the contact record, a QueryException is called.
    // The exception is written to the Apex debug log.
   catch (QueryException e) {
       System.debug('Query Issue: ' + e);
   }
   
   // Set the result to true. No need to send an email back to the user 
   // with an error message
   result.success = true;
   
   // Return the result for the Apex Email Service
   return result;
  }
}