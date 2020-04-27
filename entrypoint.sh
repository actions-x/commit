#!/bin/sh

BRANCH=$INPUT_BRANCH
case $BRANCH in "refs/heads/"*)
  BRANCH=$(echo "$BRANCH" | sed "s@refs/heads/@@")
esac

echo "machine github.com" > "$HOME/.netrc"
echo "  login $GITHUB_ACTOR" >> "$HOME/.netrc"
echo "  password $INPUT_TOKEN" >> "$HOME/.netrc"

echo "machine api.github.com" >> "$HOME/.netrc"
echo "  login $GITHUB_ACTOR" >> "$HOME/.netrc"
echo "  password $INPUT_TOKEN" >> "$HOME/.netrc"

git config user.email "$INPUT_EMAIL"
git config user.name "$INPUT_NAME"
git add $INPUT_FILES -v
git commit -m "$INPUT_MESSAGE"
git push "$INPUT_REPOSITORY" "$BRANCH"
