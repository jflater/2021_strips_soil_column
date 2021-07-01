## Recommended collaboration workflow for Git

Generally, you want to only update the main/master branch via pull requests from branches that have been merged with master beforehand. This is so that

1. Main/master branch is always in a state that "works"
2. Any potential merge conflicts with main have been addressed in the branches before the branch is incorporated into main, making sure that adding new changes to the main branch won't break it.

### Workflow example

Let's say you're working on your own. You have the `main` branch that has the current working site. An example workflow would be:

1. `git checkout main` followed by `git pull` to make sure you have the most up-to-date version of `main`. 
    * Ideally, there should be no merge conflicts or problems here because you've been following this workflow :) 
2. `git checkout -b your-new-branch` to create a new branch named `your-new-branch` and switch to it, followed by `git push -u origin your-new-branch` to tell the remote repo about your branch.
3. Make all your changes on the `your-new-branch` branch: `git add` and `commit` as you normally would. When you're ready to move all the changes to `main`, do a `git push` to update the remote `origin/your-new-branch`.
4. `git checkout main` followed by `git pull` to update `main` again. 
    * If you're working on your own, there probably won't be many changes, but if you have collaborators, this is necessary to make sure you know about changes made by other people.
5. `git checkout your-new-branch` to switch to the new branch you made
6. `git merge main` to add all the changes from `main` into `your-new-branch`. 
    * If there are no merge conflicts, awesome! 
    * If there are, you'll have to reconcile the merges. You can either fix the merges in `vim`/your favorite IDE, or you can do use the `theirs/ours` merging strategies to accept all the changes from the `main`/`your-new-branch` branches, respectively. There are two ways you can do this:
        * Abort the merge via `git merge --abort` to cancel the merge attempt, then re-do the merge with `git merge -s ours/theirs master` to take all the changes from `your-new-branch`/`main` respectively.
        * If you're already in a conflicted state and you want to use one of the strategies, you can use `git checkout --theirs/--ours .` to take all the changes from `your-new-branch`/`main` respectively, followed by `git add .` and `git commit`.
        	* More info: https://stackoverflow.com/questions/10697463/resolve-git-merge-conflicts-in-favor-of-their-changes-during-a-pull/33569970#33569970
    * After handling the merge, `git push` again to update `origin/your-new-branch`. 
        	
    At this point you have successfully incorporated all the changes in `main` into `your-new-branch` and resolved any conflicts. Incorporating all the changes from `your-new-branch` into `main` should be painless now (assuming no one has made any changes between the last step and here). 
7. To incorporate the changes from `your-new-branch` into main, there are two main options:
    1. To just merge all the changes without review, do `git checkout main` to checkout the main branch followed by `git merge your-new-branch`. This should just be a `fast-forward` merge since you handled all the conflicts in step 6. Now do `git push` to update `origin/main`. You're all done!
    2. If you want someone else to review the changes before merging the two branches together, you can open a pull request on the Github website:
        * Go to the repo website and click on "Pull Requests". Click on "New Pull Request".
        * The base branch should be `main/master` and the `compare` branch should be `your-new-branch`. Write something about what the pull request does and submit the pull request.
        * Theoretically, you should see some checks underneath that say something like "This branch has no conflicts with the base branch" (since we handled all the conflicts in step 6) and you should see the beautiful green "Merge pull request button". Then whoever you want to review the changes will be able to click that button and merge all the changes into the main branch. 
        * In order to get all the changes into your local, you'll need to do `git checkout main` followed by `git pull`. Again, this should be a `fast-forward` merge.
    See [here](https://github.com/pommevilla/friendly-dollop/pull/2) for an example of someone following this workflow to submit changes into my repo. 

