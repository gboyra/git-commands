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

# 2.1 diff: changes between saved and added files -------

# The diff command prints the changes in a file between:
# the last saved-to-disk version 
# and the last saved-to-repo version of the same file
# i.e., it doesn't account for unsaved changes in the file

# to know what changes are made in current files of the repository:
git diff
# changes in a particular file:
git diff "length.R"
# changes in a particular file in other directory:
git diff "data/length.R"

# to compare the state of the repository files with those in the staging area:
git diff -r HEAD
# -r refers to 
# HEAD refers to the most recent commit

# to compare the state of a file with that of the staging area:
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

# 6.1 Remove an addition to stage -----
#++++++++++++++++++++++++++++++++++++++
git add "analysis.R"  # you reset:
git reset HEAD  # or:
git reset analysis.R

# 6.2 undo changes that have not yet been staged ----
#++++++++++++++++++++++++++++++++++++++++++++++++++++
git checkout -- "length.R"  
# notice the "--" separating checkout and the file name
# careful: when you discard changes this way, they are gone forever

# 6.3 Combine reset and checkout to do both things ----------
#++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
# First unstage the file 
git reset HEAD "length.R"  # or:
git reset "length.R"
# And then reset the unstaged changes
git checkout -- "length.R"

# 6.4a See an old version of a file ---------
#+++++++++++++++++++++++++++++++++++++++++++++++
git show hash-code file-name  
# you can see the old version of the file like this
# but it will show it in the command line
# not really useful for long files
# It is better to apply the procedure described next:

# 6.4b Restore an old version of a file ---------
#+++++++++++++++++++++++++++++++++++++++++++++++
git checkout hash-code length.R
# and then you have to commit the change:
git commit -m "restore an old version of a file" 
# if you want to cancel the restoration, type:
git checkout -- length.R
# and the file will go back to its previous state

# Don't forget to type the file name after the hash code,
# otherwise you will restore the whole repository to that stage
# as it's explained in the next section

# 6.5 Restore an old version of the repository ---------
#+++++++++++++++++++++++++++++++++++++++++++++++++++++++
git checkout hash-code 
# When you do this, you move the HEAD to the hash
# you create a "detached" HEAD and are no longer in a branch. 
# All the commits done in all files after the checkout hash
# are temporarily discarded.
# Git creates a kind of a "temporary" branch
# that you can revert by typing:
git switch -
# or you can convert this into a new branch typing:
git switch -c <new-branch-name>
# In this temporary branch you can look around, do commits
# and if you then switch out, all the changes will be gone
# but if you switch to a new branch, you will keep them 


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
#++++++++++++++++++++++++++++++++

# When you merge one branch (source) into another (destination), 
# git adds the changes on the source to the destination
# If the changes don't overlap (no conflicts), the result is a new commit 
# in the destination branch with all the changes from the source
# (you have to be in the destination branch to do the following)
git merge source destination  # or, simply:
git merge source

# When you are in one branch, all the changes on the open scripts are 
# commited in this branch


# 7.2 Conflicts solving ---------
#++++++++++++++++++++++++++++++++

# Conflict: both parents have changes in the same line of code
# when you compare two branches, the conflicts are seen in red color
git diff source destination 

git merge source destination 
# when there is a conflict message, you can type "git status"
git status
# and some info on conflicts will be provided

# You can also type 
git diff dest_branch source_branch

# But the best is to open each conflicted file, by typing:
open conflicted_file.txt

# There will be markers delimiting each conflicting line groups
# <<<<<<<<< <Destination_branch>
#  Changes in destination_branch
# ===
#  Changes in source_branch
# >>>>>>>> <source_branch>

# Then you have to remove the conflicted lines to be able to proceed
# (remove always full lines)
# (1) Solve the conflicts
#   You have to remove either (one or the other, not both):
#    -lines between <<< and ===
#    -lines between === and >>>
# (2) Then remove also ALL the lines starting with markers
# (3) Save the conflicted files
# (4) Stage the files
# (5) Commit the changes


# 8. Remote repositories and Collaboration ------------
#+++++++++++++++++++++++++++++++++++++++++++++++++++++
 
# 8.1 Cloning a remote repository -------------

# When you join a project that is already running, you can "clone" it

# Note: the remote repository has to be public
#       Or you have to have been invited to it and have accepted 

# First you have to create a RStudio project on your PC,
# start a git repository in it (git init) 
# and then type from the terminal:
git clone https://github.com/datacamp/project.git  # or:
git clone https://github.com/datacamp/project.git new.name
# this copies the new project into your directory
# by default, the remote repository is called origin


# 8.2 Adding a remote repository to your project ------------

# When you have an RStudio project with a local repository,
# you can have a remote copy of it
# First you must create a remote repository in, say, GitHub
# Then, you can add the remote repo using:
git remote add remote-name URL

# You can have many remote repositories with different names
# And you can remove any of them:
git remote rm remote-name

# You can list the names of remotes:
git remote  # or, if you want the IP address to be printed:
git remote -v  # for verbose

# Troubleshooting: 
# When you can't access the remote, check the following:
# is it a public or private repo
# privates can be more tricky so you can make it public 
# or if it is private, make sure that you have accepted the invitation
# and that the project has a git repo started
# and that you are well identified

# 8.3 Pull changes from the remotes -----------
# Git keeps track of remote repositories so that you can pull changes
# from them and push changes to them

# A typical workflow is that you pull in your collaborators
# work from the remote repository so you have the latest version, 
# do some work yourself and the push back to the remote

# copy everything in the "remote-branch" branch of the "remote-repo" 
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


