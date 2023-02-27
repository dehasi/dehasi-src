---
layout: post
title:  "Versioning"
published: false
---

### Versioning 
1 Every change should have a (jira) ticket.

2 It’s worth to use [Semantic Versioning](https://semver.org/)
Versions should look like a 

MAJOR.MINOR.PATCH

3 `develop` branch is one step ahead from the master and has a `SNAPSHOT` prefix

| master  |1.2.34 |
| develop | 1.2.35-SHAPSHOT |

4 It’s worth to bind versions to some understandable things.
`major_release.spring_number.in_spring_release`

It’s also compatible with Semantic Versioning when we start from `0.1.0` (Sprint 1) and increase major version with some significant changes (i.e. going to production, starting the new phase, etc..).

5 You change it -- you own it

When you start to make changes, you are responsible for the whole class/file/module. 
It means you can (and have to) make some refactoring there. Also, reviewers will comment not only your changes.

### Branches
There are three types of branches:

bugFix/

feature/

refactoring/

A branch name should contain a ticket number.
i.e. `feature/jira-43-add-super-feature`

Sometimes it might be worth to add also a sprint number.
 `feature/i34-jira-43-add-super-feature`
But the period of branch life should be short (from a couple of hours to a couple of days).
That's why it's not always necessary.

Each developer’s branch is merged to `develop` 

### Commits
Each commit message has to start with a (jira) ticket number.

I.e.
`[JIRA-01] Fix something`

There is a regexp which can help
`(Merge.*|\[JIRA-\d+\] [A-Z].{,49}[^.]$)`
you can make your own prefix and debug it [here](https://www.debuggex.com/)

Commit message shall follow the following rules:

1. [Separate subject from the body with a blank line](https://chris.beams.io/posts/git-commit/#separate)
2. [Limit the subject line to 50 characters](https://chris.beams.io/posts/git-commit/#limit-50)
3. [Capitalize the subject line](https://chris.beams.io/posts/git-commit/#capitalize)
4. [Do not end the subject line with a period](https://chris.beams.io/posts/git-commit/#end)
5. [Use the imperative mood in the subject line](https://chris.beams.io/posts/git-commit/#imperative)
6. [Wrap the body at 72 characters](https://chris.beams.io/posts/git-commit/#wrap-72)
7. [Use the body to explain what and why vs. how](https://chris.beams.io/posts/git-commit/#why-not-how)

### Two approves
It’s good to have two reviews if they are:
* **Peer Review,** when your colleague looks at your Merge Request and confirms that your code makes exactly that task requires and clicks Approve.
* **Readability Review,** when an experienced developer (not necessary from your team) looks at the code and check the approach. How good this solution from the technical perspective. 

Otherwise, it's good if more people look at your code. But if they at the same level, or just not experienced, two approvers approach will look like a ritual.


### Merge requests
Add a task number to the merge request title
`JIRA-43 Implement useful feature`

Add description and labels if needed

### Merge request discussion
Try to explain your position in comments. I.e. give a link to conventions.

Don’t answer "done". Explain what you changed.

Some common shortcuts: 

*ditto:* the same thing again, when you already explained your point above.

*nit:* a small change that may not be very important, 
but is technically correct. In example `nit: remove whitespace.`

*LGTM:* Looks Good To Me

### Releasing 
Is merging the develop to the master (and should be automated).

Before merging: 
* run all tests which you have (unit, integration, smoke ...)

After merge:
* increase version of the develop
* updating release notes.
* create a tag with the actual version number on the master


### Links
[Semantic Versioning](https://semver.org/)

[How to Write a Git Commit Message](https://chris.beams.io/posts/git-commit/)

[A successful Git branching model](http://nvie.com/posts/a-successful-git-branching-model/)
