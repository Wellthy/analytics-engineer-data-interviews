# Analytics Engineer Prompt - Product Analytics

## Background
At Wellthy, we use dbt to build and maintain our data transformations. dbt is an open-source command line tool that lets data teams quickly and collaboratively deploy analytics code while software engineering best practices. For more information about dbt you can reference the documentation [here](https://docs.getdbt.com/docs/introduction), or test it out by following their [online tutorial](https://courses.getdbt.com/collections). Please note this is not required for this interview. 

For the purpose of this challenge, think of dbt as a tool that enables you to build and test tables (data models) using `SELECT` statements. Each data model created in a dbt project is stored in a `.sql` file. Since data models are often dependent on each other, dbt creates a directed acyclic graph (DAG) that allows you to see these dependencies. This is done by using jinja (e.g.,`{{ ref('some_model_name') }}`) to reference tables in the `FROM` clause.

Data models can be configured and data tests and documentation can be added using YAML files. Click [here](https://docs.getdbt.com/docs/building-a-dbt-project/tests) for more information about dbt tests or [here](https://docs.getdbt.com/docs/building-a-dbt-project/documentation) for more information about documentation.

At Wellthy, we support families in caring for their loved ones, whether it's for their spouse,  parents, children, or even the next-door neighbor who's just like family. We do this by seamlessly integrating technology and personalized care support to help caregivers tackle the logistical and administrative tasks of caring for the ones they love, including themselves.

This process starts with a caregiver creating an account on the Wellthy platform. From there they can create a care project and be assigned a Care Coordinator who will assit them throughout their care journey. If you are interested in learning more about Wellthy’s service you can read more at [here](https://wellthy.com/).

To understand how our members and caregivers interact with the Wellthy platform, we use Snowplow to capture event data for analysis.

Wellthy’s main source of revenue is through employer benefit programs. Companies (our clients) will sign a deal to offer Wellthy as a benefit to their eligible employees. To increase revenue, retention, and expand our client base, we want to ensure a smooth, intuitive, and empathetic experience to caregivers and their families. Therefore, it is important that our signup and conversion process is ..... , and a caregiver gets the help they need as quickly as possible. 

## Scenario:
The Head of Product comes to the Data Team and says they suspect prospective members are dropping off ** at some point during the signup process. One PM hypothesizes that this is due to an ****, while another thinks the call to action is not clear on ****.  The Data Team's Data Analyst needs to analyze event data from the Wellthy website and deliver insights to the Produt Team so they can make a decision on how to improve the signup experience.

## Here are some of the business questions that analyst would like to be able to answer:
* What is the average amount of time a user is spending on each page in the signup flow?
* Do members from one client have greater conversion rates than others?
* Which step in the signup funnel has the largest dropoff?
* What percent of new signups make it through the project funnel, from Creating Account to seeing their Care Project Dashboard?

## Challenge
An analytics engineer on the team has begun modeling this out to allow the analyst to answer these questions more easily. The engineer has submitted a pull request (PR) for you to review. 

Prior to your technical interview, please review the files in the `base`, `intermediate`, and `prod` subdirectories, as well as the `seed` file, pretend you are giving a real PR review. Make note of any questions you might have about the sample data model; you will have an opportunity to ask them during the interview. 

## The Technical Interview
During your interview, we will discuss your PR review in a collaborative session. You will not be asked to do any coding yourself, but please be prepared to share your screen and discuss what changes, suggestions, or questions you would include in your review. Please note: you do not need to submit anything ahead of the interview or prepare a presentation of any kind.

## dbt Model structure
Our dbt structure is separated across multiple databases and schemas in Snowflake, and transformations are performed in different "layers" to reduce the repetition of logic across multiple models:
* The `prep` database contains all of the early transformations that are not directly accessed by BI Tools or external processes.
    * The `base` schema contains a 1-1 relationship with the source tables and includes the individual table transformations and column aliasing. Every source table should have a corresponding `base` model.
    * The `intermediate` schema contains early combinations of records that are used as stepping stones to produce additional downstream transformations. One example of this could be *****. This sepration will allow for leveraging the same models downstream without repeating the same joins multiple times.
* The `prod` database contains the "final" transformations to produce the models that are accessed directly by BI Tools and external processes.

## Lineage Graph
![DAG](DAG.png) ** REPLACE THIS PNG IMAGE ***

## Assumptions
Since this is an incomplete directory without access to the source data, you are unable to run the models yourself to verify their accuracy. As such, please assume the following:
* `dbt run` results in a successful build of all models.
* `dbt test` results in a successful test of all models.
* All events are firing correctly in Snowplow
