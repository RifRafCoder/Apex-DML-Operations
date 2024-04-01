[![Open in Visual Studio Code](https://classroom.github.com/assets/open-in-vscode-718a45dd9cf7e7f842a935f5ebbe5719a5e09af4491e668f4dbf3b35d5cca122.svg)](https://classroom.github.com/online_ide?assignment_repo_id=13028692&assignment_repo_type=AssignmentRepo)
# Developer Kickstart Week 4: DML Operations

This project is part of the Developer Kickstart Week 4 curriculum at Cloud Code Academy. It's designed to help beginner Salesforce developers learn and practice the fundamental operations of the Data Manipulation Language (DML) in Apex. The focus is on the Insert, Update, Upsert, and Delete operations, all of which are essential in manipulating Salesforce data.

## Goals of the Practice
Through this practice project, you'll gain foundational knowledge about:
- Understanding the different types of DML operations in Apex (Insert, Update, Upsert, and Delete).
- How to use DML operations to create, update, and delete records in Salesforce.
- The structure and usage of Salesforce standard objects like Account, Contact, Opportunity, and Lead.
- How to handle bulk data operations in Apex.
- Understanding the concept of governor limits in Salesforce and how to write efficient, bulkified Apex code.

This foundational knowledge will prepare you for more advanced topics in Salesforce development, such as exception handling, asynchronous Apex, and trigger development. The curriculum includes practical examples with Salesforce standard objects to provide hands-on experience with DML operations.
## Note
Certain test methods related to the Book and Person classes are currently commented out and will need to be uncommented and deployed once the relevant classes are set up.

## Setup
[Video Overview](https://vimeo.com/839597882/46fc06d93e)

To get started, you'll need a Salesforce Trailhead Playground. If you don't have one, you can create it for free from any Trailhead module.

After you've set up your Trailhead Playground:

1. Install Visual Studio Code from [here](https://code.visualstudio.com/download).
2. Install Salesforce Extension Pack in Visual Studio Code. This can be done by searching 'Salesforce Extension Pack' in the Extensions view in VS Code and clicking Install.
3. Authorize your Trailhead Playground in Visual Studio Code. Press `Ctrl + Shift + P` to open the command palette and type 'SFDX: Authorize an Org', then press Enter. Follow the steps in the browser to log in to your Playground, then return to VS Code.
4. Deploy the Apex Class by right clicking on the `VariablesDatatypesOperators` and  `VariablesDatatypesOperatorsTest` file a using the option SFDX: Deploy Source to Org.

## Running the Test Classes

To run the test classes:

1. Open the command palette with `Ctrl + Shift + P`.
2. Type 'SFDX: Invoke Apex Tests...', and press Enter.
3. In the 'Select Test Class' input, select the test class you want to run and press Enter.
4. The test results will appear in the Output panel at the bottom of the screen. You can switch to the 'Test' tab in this panel to see a summary of the test run.

## Resources

If you get stuck at any point, here are some resources that might help:

- [Apex Developer Guide](https://developer.salesforce.com/docs/atlas.en-us.apexcode.meta/apexcode/apex_dev_guide.htm)
- [Salesforce Stack Exchange](https://salesforce.stackexchange.com/)
- [Visual Studio Code Documentation](https://code.visualstudio.com/docs)
- [Salesforce Extensions for Visual Studio Code](https://developer.salesforce.com/tools/vscode/)

And remember, programming is often about solving problems, so don't be afraid to use search engines to find answers to your questions.

Good luck with your learning journey in Salesforce development!