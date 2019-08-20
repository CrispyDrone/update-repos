# update-repos
Small bash script to quickly update specified branches for all repositories in a root folder.

## Dependencies
+ git: <https://git-scm.com/>

## How to use
+ Update all master and develop branches in all repositories contained in a folder "my-repos" using the only fast forward merge strategy:

  ```
  update-repos.sh my-repos true master,develop
  ```

+ Update all master branches in all repositories contained in a folder "my-repos" while allowing non fast foward merges:

  ```
  update-repos.sh my-repos false master
  ```

