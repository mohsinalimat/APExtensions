- Assure `CarthageSupport/APExtensions-example.xcodeproj` and `Example/APExtensions.xcworkspace` have all dependencies added.
- Run `checkBuild.command`
- Change version in podspec
- Run `podUpdate.command`
- Update CHANGELOG.md
- Update README.md with new version if needed
- Run `updateDocs.command`
- Push changes in git
- Add git tag
- Merge `master` to needed branched, e.g. `core`, `abstractions`, `storyboard`, `view-configuration` or `view-state`.
- Run `podPush.command`
