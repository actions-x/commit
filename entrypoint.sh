#!/bin/sh

CURRENT_BRANCH=${GITHUB_REF##*/}
TARGET_BRANCH=$INPUT_BRANCH
case $TARGET_BRANCH in "refs/heads/"*)
  TARGET_BRANCH=$(echo "$TARGET_BRANCH" | sed "s@refs/heads/@@")
esac

if [ "$INPUT_FORCE" != "0" ]; then
  FORCE='--force'
fi

echo "machine github.com" > "$HOME/.netrc"
echo "  login $GITHUB_ACTOR" >> "$HOME/.netrc"
echo "  password $INPUT_TOKEN" >> "$HOME/.netrc"

echo "machine api.github.com" >> "$HOME/.netrc"
echo "  login $GITHUB_ACTOR" >> "$HOME/.netrc"
echo "  password $INPUT_TOKEN" >> "$HOME/.netrc"

git config user.email "$INPUT_EMAIL"
git config user.name "$INPUT_NAME"

cd "$INPUT_WORKING_DIR" || exit 1

# shellcheck disable=SC2086
git add $INPUT_FILES -v
git commit -m "$INPUT_MESSAGE"

git branch actions-x-temp-branch
git fetch "$INPUT_REPOSITORY" "$CURRENT_BRANCH"
git checkout "$CURRENT_BRANCH"
git merge actions-x-temp-branch
git branch -d actions-x-temp-branch

git push "$INPUT_REPOSITORY" "$CURRENT_BRANCH:$TARGET_BRANCH" $FORCE
