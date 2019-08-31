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
1. Add support to update any repository in the root folder regardless of its depth. Currently it only considers the immediate i.e. level 1 subfolders.
2. Support for parallel processing
3. Improved command line experience with flags etc
4. Support for multiple origins (only content fetching, not merging...?)
5. Investigate partial, shallow fetching,...
6. Cross platform support
7. Remove unnecessary usages of grep and sed by parameter substitution etc.
8. Improve error handling
9. Rewrite the git remote url validation since it's not required for a git repository folder to end in `.git`

## Change history:
+ v0.21:
  + Added support for automatic stashing in case the repository contains uncommitted changes that prevent a checkout to one of the specified branches.
+ v0.20: 
  + Added regex support to specify which repositories need to be updated (see git clone url)
  + Added support for specifying the remotes to fetch from
+ v0.10: Initial release
  + Update level 1 folders containing git repositories for a specified set of branches.
  + Support for fast forward only merges
