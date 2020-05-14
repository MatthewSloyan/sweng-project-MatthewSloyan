![GMIT Logo](http://password.gmit.ie/images/logo.png "GMIT Logos")
# Software Engineering Project 2020
### BSc (Hons) Computing in Software Development

### Overview:
This project is a simple to use “Recipe Finder” built using Ruby on Rails. The user can create an account and log in securely, create, edit, and delete their own recipes and view other users’ recipes. Users can search by recipe name or description, sort by recipe name or cooking time or filter by difficulty. Some of these features and more are described below. 

**Note:** I tested this on a new instance of GitPod and did not encounter any of the errors referenced in Teams. I have made the updates to bundler and the gitpod.yaml file just in case though. However, I did encounter an error when commenting out “initialize” in the rails_helper.rb file though. It stopped my Rspec tests working, so I have left this out.

### Features:
* **CRUD** – Full crud functionality on recipes. Users can create, view, edit, and delete a recipe if they are the author of said recipe. When creating or editing users can easily add/remove multiple steps and ingredients with nested forms and models. How this was achieved is documented in code.
* **Recipe Features** – How the user can find their recipes is customisable. On the home page if the user wants to search to find a specific recipe, they can search by the recipe name or description which will load results if found. If the user wants to remove all “Hard” difficultly recipes, they can uncheck the “Hard” box. Lastly, if a user wants to sort results by recipe name (alphabetically) or by cooking time (asc) then they can click on the respective header in the table. All these options are persistent across sessions and pages.
* **Users (Login, Signup & User profile page)** – Users can create an account which is full validated, E.g the email and username must be unique. Passwords are encrypted with bycrypt with a salt and only the required data is returned where is needed for security purposes. Once created the user can login in with their email or username and password. Any user can view another user’s profile page which shows their information (name, username, and the number of recipes) Also, on this page is the list of recipes they have created if found.

**Note:** Using the seed data the user “Test_Author” is created and can be signed in using the email “test@gmail.com”, the username “Test_Author” with the password “test1234”. On Heroku there is also a user for “Matthew_s97” that I have created when testing.

* **Routing** – All routing is validated, so that to create a recipe you need to be logged in. You also need to be logged in as the author of a specific recipe to delete or modify it. These links can be found on the view recipes page.

### Testing:
* All additional features such as login, signup, search, sort, filter and find recipes by author are fully implemented with cucumber feature tests. 
* All controllers, models, and helpers have Rspec tests for all paths and options. 
* All tests pass with an overall code coverage of 96.18%

### Additional Gems used:
* **bycrypt** – https://github.com/codahale/bcrypt-ruby

bycrypt is used to hash the user’s password security with a salt. Also, it is used to authenticate a user’s login by checking the entered password with a salt if the user is found by username or email.

* **cocoon** - https://github.com/nathanvda/cocoon

Cocoon was used to create the dynamic nested forms seen when creating a new recipe. I created the migrations, models, and parameters, but Coocon was used to add dynamic partials using javascript.


## Introduction
This project is the alternative assessment which will replace the 50% summer exam in Software Engineering which has been cancelled due to the pandemic. The project is worth 50%, and will address the module learning outcomes by focusing on the following topics:
- Software as a Service / Cloud Computing 
- Web Application Architectures (MVC)
- Software Development Frameworks
- Database Management
- Requirements Specification/Automated Acceptance Testing using Behaviour-Driven Development
- Unit and Functional Testing
- Test Coverage Metrics

## Requirements
Using the Software Engineering principles mentioned above which were discussed in the lectures and lab assignments, you are required to create and deploy a SaaS application using the Ruby on Rails framework, and write a comprenehsive suite of automated tests. You are free to come up with your own idea for what your application will do, but it can be broadly similar in style to the RottenPotatoes movie review sample application we worked on throughout the course (though obviously it must be different, i.e. not based on movies). In terms of functionality your application should be relatively simple. The focus here is not on building a complex feature-heavy application, but rather on building a simple application using solid engineering principles with thorough automated tests. Your application must conform to the specification detailed below.

### Specification 

#### Functionality
Your application should:
- support basic CRUD operations on a single resource (e.g. similar to the create, read, update and delete operations on movies supported by RottenPotatoes).
- include at least one **additional feature** beyond basic CRUD (e.g. the RottenPotatoes "find movies by the same director" feature you worked on for CA5, or the filtering and sorting functionality you added in CA3).

#### Database
Your application should:
- use an SQL database (the `sqlite` development database gem is included in the starter code). 
- define a database schema in a Rails migration, which can be used to create a database using the `rake db:migrate` task.
- define seed data which can be used to populate the database with initial data using the `rake db:seed` task.

#### Testing
Your application should include a comprehensive suite of automated tests, specifically:
##### Cucumber
- Cucumber BDD/Acceptance tests which verify the **additional feature** works as expected. Your cucumber tests should at a minimum include 2 scenarios, testing both the happy and sad paths of the feature. Comprehensive testing of the feature will be necessary to score full marks for this component.

##### RSpec
- RSpec unit/functional tests for the controller and model. Your RSpec tests should test:
  - the controller and model logic added to implement the **additional feature**.
  - whatever other controller/model logic that needs to be tested to improve code coverage.
 ##### Code Coverage
- The `simplecov` gem and necessary setup is included in the provided starter code. This will generate a detailed report of how well your code is covered by tests in `coverage/index.html`, as well as reporting the overall coverage percentage on the command line when `cucumber` and `rspec` tests are run (see CA5). Use this coverage report to identify under-tested code that you need to write tests for. Note that 100% coverage isn't necessary, or even desirable. 10 marks are available for code coverage, according to the following scheme:


Code Coverage Percentage| Marks |
:---: | :---: |
| >= 85 | 10 |
| >= 70 | 8 |
| >= 55 | 6 |
| >= 40 | 4 |
| >= 25 | 2 |
| < 25 | 0 |


#### Deployment
- Your application should be deployed to Heroku, complete with database and seeded with seed data.

#### Documentation
- Add a brief (1 paragraph) of your project to this README.
- Your Cucumber tests should act as a type of living documentation for your application. From reading the feature file(s) it should be clear what the additional feature is and how it works.

## Starter Code
The starter code in this repository includes a template Rails application which provides the following:
- a Gemfile with most (if not all) of the framework and test dependencies you'll need
- cucumber helper code and low-level step definitions for browser interaction (in `features/step_definitions/web_steps.rb`).
- rspec helper code
- various other useful things

This repository also includes a GitPod configuration which provides the following pre-installed in your GitPod workspace:
- the Heroku command line interface tool `heroku`
- VSCode extensions for Cucumber/Gherkin and Haml syntax highlighting
- a GitPod init command to automatically run `bundle install` when your workspace (re)starts, since it seems GitPod now uninstalls gems when your workspace is shutdown.

**You should build your application by incrementally adding to the template application included here. All of your code should be in this repository.**

## Marking Scheme
The project will be marked according to the following marking scheme:

Project Component | Marks
:--- | :---: |
|Basic CRUD operations on a single resource |  30 |
| Additional feature | 10 |
| DB: Schema defined in a Rails migration | 5
| DB: Seed data defined in db/seeds.rb | 5
| Cucumber BDD Acceptancd Tests | 15 |
| RSpec Unit/Functional Test | 15 |
| Code Coverage | 10 |
| Cloud Deployment (Heroku) | 10 |
| **TOTAL** | **100** |


## Reference Documentation
The [Rails documentation](https://guides.rubyonrails.org/v4.2/) is likely to be useful to you in solving problems you encounter. The [`rails` command line](https://guides.rubyonrails.org/command_line.htm) provides tools with may be useful to you, some of which you've already used. Specifically, the [`rails generate` command](https://guides.rubyonrails.org/command_line.html#rails-generate) can be used to generate templates for various things like controllers, models, migrations etc., which is likely to be easier and less error-prone than creating these things by hand. Use of productivity tools like this is encouraged.

## Submission
By **11pm on Friday May 15th** you are required to:
- submit the Heroku URL of your deployed application to the assignment on Moodle.
- ensure that all of your code is pushed to your repository on GitHub.

(note that submitting a zip file of your code to Moodle **is not necessary**. GitHub Classroom is being used to manage this assignment, and its tools allow me full access to your code.
