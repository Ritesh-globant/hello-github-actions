#!/bin/bash

export GIT_BRANCH=${GITHUB_HEAD_REF}

echo "Github branch 01 $GIT_BRANCH"

if [[ "$GIT_BRANCH" == "" ]] || [[ ! -z "$GIT_BRANCH"  ]]; then
  echo "Github branch 02 $GIT_BRANCH"
  export GIT_BRANCH=${GITHUB_REF#refs/heads/}
  echo "Github branch 03 $GIT_BRANCH"
fi  
export ENVIRONMENT=$NONE

if [[ "$GIT_BRANCH" =~ release/.* ]]; then
  export ENVIRONMENT="stage"
fi

if [[ "$GIT_BRANCH" =~ hotfix/.* ]]; then
  export ENVIRONMENT="stage"
fi

if [[ "$GIT_BRANCH" = "develop" ]] || [[ "$GIT_BRANCH" =~ feature/.* ]]; then
  export ENVIRONMENT="dev"
fi

if [ "$GIT_BRANCH" = "master" ]; then
  export ENVIRONMENT="prod"
fi

if [ "$ENVIRONMENT" == "$NONE" ]; then
  echo "Failed to determine environment based on branch $GIT_BRANCH"
  exit 1
fi

echo "===================================="
echo "BRANCH: $GIT_BRANCH"
echo "ENVIRONMENT: $ENVIRONMENT"
echo "===================================="
