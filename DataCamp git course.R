#++++++++++++++++++++++
# DataCamp git course #
#++++++++++++++++++++++


# 1. Generalities --------------
#+++++++++++++++++++++++++++++++
git init

git add "length.R"
git commit -m "bla bla bla"

# to amend (correct) a commit you can use --amend
git commit --amend -m "new message"

git status
git add "length.R"

# 2. See changes ----------
#++++++++++++++++++++++++++

# to know what changes are made in current files of the repository:
git diff
# changes in a particular file:
git diff "length.R"
# changes in a particular file in other directory:
git diff "data/length.R"

# to compare the state the repository files with those in the staging area:
git diff -r HEAD
# -r refers to 
# HEAD refers to the most recent commit

# to compare the staate of a file with that of the staging area:
git diff -r HEAD "length.R"

git log -2
git log --oneline
# to see a specific file's history:
git log "length.R"

# to see the details (changes) of a specific commit:
git show 0da2f7 # hash code
git show HEAD  # the last commit
git show HEAD~1  # the previous one
git show HEAD~2  # the one before, etc...

# to know who made the changes:
git annotate "length.R"

# to see the changes between two commits:
git diff hash1 hash2
git diff HEAD~1 HEAD~3


# 3. Remove files -----------
#++++++++++++++++++++++++++++

# to show a list of unwanted (untracked) files:
git clean -n 
# to remove unwanted files:
git clean -f
# git clean only works with untracked files, it you remove them it is for ever


# But is far safer to remove tracked files 
# (because you can always restore them later)
git add "length.R" 
git commit -m "Add lenght.R to the repository"
git rm "length.R" # remove file and stages the change in one step
git commit -m "Removing file length.R frorm the directory"  # commit the removal


# 5. Configuration ------------
#++++++++++++++++++++++++++++++
# see how git is configured:
git config --list
git config --system  # for every user in this computer
git config --local
git config --global 
git config --global user.email gboyra@azti.es



# 6. UNDO changes ------------
#++++++++++++++++++++++++++++++

# to remove an addition to stage, for example:
git add "analysis.R"  # you reset:
git reset HEAD

#
# undo changes that have not yet been staged:
git checkout -- "length.R"  
# notice the "--" separating checkout and the file name
# careful: when you discard changes this way, they are gone forever

# You can combine reset and checkout to do both things
# First reset the staged changes
git reset HEAD "length.R"  # or:
git reset "length.R"
# And then unstage the file
git checkout -- "length.R"

# to restore an old version of a file:
git checkout hash length.R
# and don't forget to commit the change:
git commit -m "restore and old version"

# to undo changes to many files at once:
git reset
git reset HEAD  # the last or default commit or stage
git reset HEAD "data"  # a full directory

# to unstage many files at once:
git checkout data  # all the changed files in the directory
git checkout -- .  # all the changed files in the current directory
 

# 7. Branches ------------
#+++++++++++++++++++++++++

# One of the reasons of Git's popularity is its support for branches
# Branches are different versions of your work
# They are like parallel universes, changes you make in one branch
# doesn't affect the other branches (until you merge them back together)
# Normally, a commit has (is the child of) one single father
# But in merges, the commit has two fathers

# By default, every git repository has a branch called master (or main)

# to list all the branches in a repository, use branch
git branch
# the branch you are currently in will be shown with a * beside its name

# to list the differences between branches:
git diff branch1 branch2
git diff branch1 -- branch2

# use "checkout" to switch from one branch to another:
git checkout branch.to.go.to  # you move to your secondary branch

git checkout master   # go back to your primary branch
ls  # checkout that the file is not there

# to create a branch you use git branch:
git branch branch.name

# you can also create a branch and switch to it in the same step with checkout -b:
git checkout -b branch.name

# 7.1 Merging branches ----------

# When you merge one branch (source) into another (destination), 
# git adds the changes on the source to the destination
# If the changes don't overlap (no conflicts), the result is a new commit 
# in the destination branch with all the changes from the source
# (you have to be in the destination branch to do the following)
git merge source destination

# When you are in one branch, all the changes on the open scripts are 
# commited in this branch

# Conflicts: changes in the same lines of code
# when you compare two branches, the conflicts are seen in red color
git diff source destination

git merge source destination 
# when there is a conflict message, you can type "git status"
git status
# and some info on conflicts will be provided
# then you have to remove the conflicted lines to be able to proceed


# 8. Remote repositories and Colaboration ------------
#+++++++++++++++++++++++++++++++++++++++++++++++++++++
 
# 8.1 Cloning a remote repository -------------

# Ehen you join a project that is already running, you can "clone" it:

git clone https://github.com/datacamp/project.git  # or:
git clone https://github.com/datacamp/project.git new.name
# this copies the new project into your directory
# by default, the remote repository is called origin


# 8.2 Adding a remote repository to your project ------------

# You can add one more remotes using:
git remote add remote-name URL
# Or remove existing ones:
git remote rm remote-name

# Then, you can list the names of remotes:
git remote  # or, if you want more info:
git remote -v  # for verbose



# 8.3 Pull changes from the remotes -----------
# Git keeps track of remote repositories so that you can pull changes
# from them and push changes to them

# A typical workflow is that you pull in your collaborators
# work from the remote repository so you have the latest version, 
# do some work yourself and the push back to the remote

# copy everything in the "remote-branch" branch in the "remote-repo" repo
# to your current branch of your local repo
git pull remote-repo remote-branch

# when you pull, both branches are merged

# Git tends to stop you from switching branches with unsaved work
# It also stops you from pullin changes when this might overrite 
# what you have done locally
# The fix is simple: either commit or revert your local changes
# and try again

# 8.4 Push changes from the local to the remote ----------
# To upload changes to the remote, use push:
git push remote-repo local-branch
# this pushes the content of "local-branch-name" into a branch
# with the same name in the "remote-name" repo
# It is possible to use different branch names in both ends
# but this quickly becomes confusing, so it is discouraged
# Normally it is better to use the same branche names across repos

# To prevent you from overwriting others' work
# Git does not allow you to push changes to a remote 
# unless you have merged the contents of the remote
# into your own work


