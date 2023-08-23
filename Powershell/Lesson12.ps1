<#
    What is Source Control?
    Is this only for developers?
    What do you do with your scripts \ code?
    - Store them on local drives
    - Store them on Network drives
    - Store them on a Repo
    - Who has access to them?
    - How do you track changes?
    - Does everyone on your team know the location of your scripts?
    - Do you write down what they are used for and where they are used?
    
    Different types of Code Repo's
    Centralized Repo's - A CheckIn / CheckOut Process that is maintained by a Central Server \ Application
    MS Visual Source Safe
    SVN - Subversion, Tortoise 
    Decentralized Repo's - May have a Central Location but a copy of all changes are included in each Pull Request
    GIT, BitBucket, GitLab, 
    
    Questions to think about:
    Is there any thing in my Script / Code that would be considered as data?
        - ComputerNames, IP Addresses, SPN, API, Account Names, etc.
        - Does my script need priveleged access or a PW, token, certificate
    How would I classify my Script / Code? 
        - Is it a one off, used semi often, used on a regular basis, scheduled
        - Am I the only one that will run this, will some one else run it, 
            would I like to hand this off at some point, do I need a Service Account to run this?
        - Operational task or a Business task
    Does my Script / Code impact Operations or the Business? 
        - Think about the type of Repo you will need for this
        - would you put work stuff in a public repo that the company doesn't have access to?
        - Do you know where we should store Scripts / Code?
    How is my Script / Code being run?
        - Manually 
            - I run it locally on my machine
            - It's copied and run from a specific box
            - It requires a specific application / module to run
        - In Automation
            - We have a Scheduled Task that runs on a server
            - We have a pipeline that uses this
            - It has to be run after a specific task 
    Who will be running my Script / Code?

    Origin - This is the database that all of the Remote distributed databases connect to
    Remote - This is the Remote database which is on your machine unless you are using it as a standalone
    Branching / Deployment Strategy - Working by yourself you may not want to be complex with your repo.
        Having an understanding of the strategies will help you when working with other's

    What does Fairway use?        
    GIT / Atlassian BitBucket
    GIT / AzureDevops
    License is required for access to both
    GIT is the executable / command line 

    Links
    https://git-scm.com/book/en/v2/Getting-Started-Installing-Git
    https://support.atlassian.com/bitbucket-cloud/docs/set-up-an-ssh-key/
    https://git-scm.com/downloads/guis
    https://code.visualstudio.com/
    https://fairway.atlassian.net/wiki/spaces/DEVOPS/pages/11272448/Bitbucket+Cloud+Setup
#>

<#
    Gui vs Console
    Both have their use's and it depends on what you feel comfortable with.
     
#>

git --version

<#
    Git Config file
    Git will use this file for 
    user.name
    user.email
    core.sshcommand
#>
git config --global --list

<#
    Basic Git Commands
    Git Status - If you don't know what branch your on, or 
        if there is anything that has changed on your end
    Git Branch
    Git Fetch - Check to see if there is a change on the Origin that is different then on your end.
        It's common to see changes if there are multiple people working in the same Repo
    Git Add . or git add Lessons/Pester/Pester3/mbx.tests.ps1
#>

git status
# What is the status of my Repo?
git branch
# What branch am I on?
git checkout Lesson12
# How to change to a different branch

git fetch # nothing will return if my Remote branch matches the Origin

git add Lessons/Lesson12.ps1
# Git Status shows our Change is now added to our local Repository
Git commit -m "Updating Git with Lesson12"
# The commit is to our Local Database not the Origin Database Git Status is telling you what 
git Push
# What happens if you have a new branch that is on your local Remote repo but not on the Origin repo
git push --set-upstream origin lesson12
git status
<#
    I now have my updates on the Origin Server 
    let's take a look at the BitBucket Server and go over some more items
    Making a change on the Origin and Fetching it back on our Local repo
    Let's Merge the branch lesson12 to the Master Branch
    Why Should we work like this?
#>

Git Status
<#
    There is a lot more to talk about with Git
    Git Stash - Currently working on some things I am not ready to commit but need to hold on to it till later
    Git Tag - useful for versioning information, friendly names, and for automation
    Git Log -n 3
    Some things are easier in the gui
    Git Cherry-pick
    git revert
    
    gitk 
#>

git log -n 3

<#
    What are your experiences with using Source Control?
#>

git merge --?
