[![Tests](https://github.com/actions-x/commit/actions/workflows/test.yaml/badge.svg)](https://github.com/actions-x/commit/actions/workflows/test.yaml)

Commit and push changes back upstream. Lightweight action using only alpine and shell scripting.

> Don't use v4 anymore as GitHub changed the way checkout works so it no longer works. 

## Usage

```yaml
name: publish

on:
  push:
    branches:
    - master
    
jobs:
  build:
    runs-on: ubuntu-latest
    steps:
    - name: checkout
      uses: actions/checkout@v2
    # make the changes between checkout and push
    - name: push
      uses: actions-x/commit@v6

```

All parameters are optional, with no parameters provided, these defaults are used:

- name  - the actor name, so if your github name is `example` the name will be `example` 
- email - the actor name @localhost, if your github name is `example` the email is `example@localhost`
- message - `Automatically updated using GitHub Actions`
- branch - defaults to the branch that triggered the action, so if you pushed to master, the branch is `master`
- files - `.` (meaning all files in the whole tree)
- repository - you can specify the repository to push the code to, default is `origin` (e.g. the same repository)
- token - if you want to push to a different repository you need to provide your own token, otherwise you can leave it
to the default value which is provided by GitHub Actions and works for the same repository
- force - you can specify true to perform force push, default is to not use force push
- directory - the working directory to do the commands in, default is `.` (current directory)

## Full reference

```yaml
name: publish

on:
  push:
    branches:
    - master
    
jobs:
  build:
    runs-on: ubuntu-latest
    steps:
    - name: checkout
      uses: actions/checkout@v2
    # make the changes between checkout and push
    - name: push
      uses: actions-x/commit@v6
      with:
        email: me@example.com
        name: GitHub Actions Autocommitter
        branch: master
        files: file1 file2 directory directory2/file3
        repository: https://github.com/Example/SomeOtherRepository
        token: ${{ secrets.MY_SECRET_TOKEN }}
        force: true
        directory: path/to/different/repo

```
