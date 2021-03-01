#!/usr/bin/env bash

username="username"
password="password"
repo="https://${username}:${password}@github.com/username/blog.git"
repo_path="/srv/repo/blog"
destination="/srv/public/blog"


function clone(){
    echo "git clone repo ${repo} ..."
    rm -rf $repo_path
    git clone $repo $repo_path
    if [ $? != 0 ]; then
        # git clone error, remove repo path and retry
        echo "git clone repo ${repo} error, remove repo path ${repo_path} and retry"
        rm -rf $repo_path
        if [ $? != 0 ]; then
            echo "remove path ${repo_path} of repo ${repo} error, return"
            return 1 # remove repo path error
        fi
        git clone $repo $repo_path
        if [ $? != 0 ]; then
            echo "git clone repo ${repo} error, return"
            return 1 # git clone error, return
        fi
    fi
    return 0
}

function pull(){
    echo "git pull repo ${repo} ...";
    if [ ! -d "$repo_path/.git" ]; then
        echo "git pull repo ${repo}, path ${repo_path} not exist, return"
        return 1 # git pull, repo path not exist
    fi
    cd $repo_path
    git pull
    if [ $? != 0 ]; then
        echo "git pull repo ${repo} error, return"
        return 1 # git pull error, return
    fi
    return 0
}

function hugo-generate(){
    if [ ! -d "$repo_path" ]; then
        echo "hugo generate, path ${repo_path} not exist, return"
        return 1
    fi

    if [ -d "$destination" ]; then
        rm -rf $destination
        if [ $? != 0 ]; then
            echo "hugo generate, remove destination ${destination} error, return"
        fi
    fi
    mkdir -p $destination
    if [ $? != 0 ]; then
        echo "hugo generate, create destination ${destination} error, return"
        return 1
    fi

    cd $repo_path
    hugo --destination=$destination
    if [ $? != 0 ]; then
        echo "hugo generate, generate static file error, return"
        return 1
    fi
    return 0
}

function hook(){
    if [ ! -d "$repo_path/.git" ]; then
        clone;
        if [ $? != 0 ]; then
            return 1 
        fi
    else
        pull;
        if [ $? != 0 ]; then
            return 1
        fi
    fi

    hugo-generate
    if [ $? != 0 ]; then
        return 1
    fi
    return 0
}


hook