/**
 * The DMLOperations class serves as a deep dive into Data Manipulation Language (DML) in Apex.
 * It covers fundamental DML operations such as insert, update, upsert, and delete.
 *
 * This class introduces developers to the concept of manipulating Salesforce records in Apex.
 * It discusses how to use DML operations to create, update, and delete records.
 * This class uses standard Salesforce objects like Account, Contact, and Opportunity for demonstration.
 *
 * Topics covered in this class include:
 * - Understanding how to use insert DML operation to create records in Salesforce.
 * - Understanding how to use update and upsert DML operations to update existing records in Salesforce.
 * - Understanding how to use delete DML operation to remove records from Salesforce.
 *
 * Users of this class can expect to gain a strong understanding of DML operations in Apex and
 * be prepared for more advanced topics in Salesforce development.
 *
 * The methods within this class serve as practical examples of different DML operations,
 * allowing developers to learn through practice and examples.
 *
 * @author Rafia Wakaar
 */


public with sharing class DMLOperations {
    /**
     * Create a new Account object and inserts it into the database.
     * The Account will have a random name for uniqueness.
     * @return The Id of the newly created Account.
     */
    public static Id insertNewAccount() {
        // Create a new Account instance
        Account acc = new Account();
        // Set some fields on the Account
        acc.Name = 'Spider Man';
        // Insert the Account into the database
        insert acc;
        // Return the Id of the newly created Account
        return acc.Id;
    }

    /**
     * Create a new Account with the specified name and industry provided.
     * @param name The name of the account to be created.
     * @param industry The industry of the account to be created.
     */
    public static void createAccount(String name, String industry) {
        // Create a new Account and set the fields inline
        Account acc = new Account(Name = name, Industry = industry);
        // Insert the Account
        insert acc;
    }

    
    /**
     * Create a new Contact and link it to the Account id provided then inserts it into the database.
     * @param accountId The Id of the Account to link the Contact to.
     * @return The Id of the newly created Contact.
     */
    public static Id insertNewContact(Id accountId) {
        // Create a new Contact instance
        Contact cont = new Contact();
        // Set some fields on the Contact
        cont.FirstName = 'Lilly';
        cont.LastName = 'Potter';
        cont.Email = 'lilly_potter@hotmail.com';
        // Set the AccountId field to the given accountId
        cont.AccountId = accountId;
        // Insert the Contact into the database
        insert cont;
        // Return the Id of the newly created Contact
        return cont.Id;
    }

    /**
     * Update the last name of a Contact in the database.
     * Resource: https://developer.salesforce.com/docs/atlas.en-us.soql_sosl.meta/soql_sosl/sforce_api_calls_soql.htm
     * @param contactId The Id of the Contact to update.
     * @param newLastName The new last name for the Contact.
     */
    public static void updateContactLastName(Id contactId, String newLastName) {
        // Retrieve the Contact from the database
        Contact getCont = [SELECT Id FROM Contact WHERE Id = :contactId];
        // Update the Contact's last name
        getCont.LastName = newLastName;
        // Update the Contact in the database
        update getCont;
    }

    /**
     * Update the stage of an Opportunity in the database.
     * Resource: https://developer.salesforce.com/docs/atlas.en-us.soql_sosl.meta/soql_sosl/sforce_api_calls_soql.htm
     * @param oppId The Id of the Opportunity to update.
     * @param newStage The new stage for the Opportunity.
     */
    public static void updateOpportunityStage(Id oppId, String newStage) {
        // Retrieve the Opportunity from the database
        Opportunity opp = [SELECT Id FROM Opportunity WHERE Id = :oppId];
        // Update the Opportunity's stage
        opp.StageName = newStage;
        // Update the Opportunity in the database
        update opp;
    }

    /**
     * Update the Account's Name and Industry given an Account Id.
     * Resource: https://developer.salesforce.com/docs/atlas.en-us.soql_sosl.meta/soql_sosl/sforce_api_calls_soql.htm
     * @param accountId The Id of the account to be updated.
     * @param newName The new name for the account.
     * @param newIndustry The new industry for the account.
     */
    public static void updateAccountFields(Id accountId, String newName, String newIndustry) {
        // Query the account
        Account acc = [SELECT Id FROM Account WHERE Id = :accountId];
        // Update the Account with the given Id with the new name and industry
        acc.Name = newName;
        acc.Industry = newIndustry;
        update acc;
    }


    /**
     * Create or updates an Opportunities
     * The Opportunity's Stage is set to Qualification.
     * The Opportunity's Close Date is set to 3 months from today.
     * The Opportunity's Amount is set to 50000.
     * @param list of Opportunities to be changed then upserted.
     */
    public static void upsertOpportunityList(List<Opportunity> opportunities) {
        // Iterate over the opportunities
        for(Opportunity opps : opportunities){
            // Set the Opportunity's Stage to Qualification
            opps.StageName = 'Qualification';
            // Set the Opportunity's Close Date to 3 months from today
            opps.CloseDate = Date.today().addMonths(3);
            // Set the Opportunity's Amount to 50000
            opps.Amount = 50000;
        }            
        // Upsert the Opportunity
        upsert opportunities;
    }

    /**
     * Insert or updates opportunities from list of names.
     * Associate the Opportunities with account that has the name accountName.
     * There should be an Opportunity for each name provided in the list.
     * @param accountName The name of the Account.
     * @param oppNames The list of Opportunity names.
     */
    public static void upsertOpportunities(String accountName, List<String> oppNames) {
        //need to create a new account first and insert it so it has an id
        Account acc = new Account(Name = accountName);
        insert acc;
        List<Opportunity> upsertedOpps = new List<Opportunity>();
        // Loop through each Opportunity name
        for(String oppN: oppNames){
            // Create an Opportunity with the given name
            Opportunity newOpp = new Opportunity();
            newOpp.Name = oppN;
            newOpp.AccountId = acc.Id; // use id to assign relationships or check field API used
            //always add in required fields or will get error
            newOpp.StageName = 'Qualification';
            newOpp.CloseDate = Date.today().addMonths(3);
            // Add the Opportunity to the list
            upsertedOpps.add(newOpp);
        }
        upsert upsertedOpps;
    }

    /**
     * Take a list of contacts and their corresponding account names
     * Link the contacts to the accounts by the last letter of the contact's last name and the account name.
     * Some of the account and contacts may already exist in the database.
     * Example - Contact: John Doe 1 Linked to Account: Doe Inc. 1, Contact: Jane Doe 2 Linked to Account: Jane Inc. 2
     * @param contactsToUpsert List of Contacts to be upserted.
     * @param accountNames List of Account names corresponding to the Contacts.
     */
    public static void upsertAccountsWithContacts(List<Contact> contactsToUpsert, List<String> accountNames) {
        // Loop through each Account name
        List<Account> accList = new List<Account>();
        for(String acc : accountNames){
            Account newAcc = new Account(Name = acc);
            accList.add(newAcc);
        }
        // Upsert the Accounts
        upsert accList;
        // Loop through each upserted Account
        Map<String, Id> accountMap = new Map<String, Id>();
        for(Account upserAcc : accList ){
            // Add the Account's Id to a Map with the last letter of the Account's name as the key 
            String lastLetter = upserAcc.Name.substring(Math.max(0, upserAcc.Name.length() - 1));
            accountMap.put(lastLetter, upserAcc.Id);
        }
        // Loop through each Contact
        for(Contact con : contactsToUpsert){
            // Set the AccountId of the Contact to the Id of the Account with the same last letter of the Contact's last name
            String lastLetterContact = con.LastName.substring(Math.max(0, con.LastName.length() - 1));
            Id accountId = accountMap.get(lastLetterContact);
            con.AccountId = accountId;
        }
        // Upsert the Contacts
        upsert contactsToUpsert;
    }


    /**
     * Insert a list of Leads and then deletes them.
     * @param leadNames The list of Lead names to be inserted.
     */
    public static void insertAndDeleteLeads(List<String> leadNames) {
        // Loop through each Lead name
        List<Lead> leadsList = new List<Lead>();
        for(String lead : leadNames){
            Lead newLead = new Lead();
            newLead.LastName = lead;
            newLead.Company = 'Superman';
            leadsList.add(newLead);
        }
        // Insert the Leads
        insert leadsList;
        // Delete the Leads
        delete leadsList;
    }


    /**
     * Dynamically create the number of cases and relate it to the accountId, then deletes them.
     * @param accountId The account for which the cases will be created and then deleted.
     * @param numOfCases The number of cases to create.
     */
    public static void createAndDeleteCases(String accountId, Integer numOfCases) {
        List<Case> casesList = new List<Case>();
        Integer i;
        for (i = 1; i <= numOfCases; i++){
            Case newCase = new Case();
            newCase.AccountId = accountId;
            casesList.add(newCase);
        }
        // Insert the cases
        insert casesList;
        // Delete the cases
        delete casesList;
    }
}