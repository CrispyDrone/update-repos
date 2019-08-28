# update-repos
Small bash script to quickly update repositories in a root folder. You can specify from which remotes content needs to be fetched, which branches need to be included, and which repositories need to be updated by using a regular expression (case insensitive). 

## Dependencies
+ git: <https://git-scm.com/>

## How to use
```
update-repos.sh <folder> <remote> <branches> <ff-only> <regex>
```

+ `<folder>`: The root folder
+ `<remote>`: The git remote you want to update
+ `<branches>`: A comma separated list of branches you want to update.
+ `<ff-only>`: `true` or `false` specifying whether to merge using fast-forward only strategy or not.
+ `<regex>`: A regular expression used to filter the repositories that should be updated, based on their name (i.e. the `.git` part of the clone url).

### Examples
+ Update all master and develop branches using the origin remote in all repositories contained in a folder "my-repos" using only the fast forward merge strategy:

  ```
  update-repos.sh my-repos origin master,develop true
  ```

+ Update all master branches in all repositories matched 'notes' contained in a folder "my-repos" while allowing non fast foward merges:

  ```
  update-repos.sh my-repos origin master false notes
  ```

## In the pipeline
1. Automatic stash handling in case there are uncommited changes preventing a checkout
2. Cross platform support
3. Support for parallel processing
4. Improved command line experience with flags etc
5. Support for multiple origins (only content fetching, not merging...?)
6. Investigate partial, shallow fetching,...
