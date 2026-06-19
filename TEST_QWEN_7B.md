# Qwen2.5-Coder 7B Model Testing - Task Batch 1

## Model: qwen2.5-coder:7b
## Testing Approach: Aider with 8 Firebase Integration Tasks
## Model Size: 7B Parameters (Significantly larger, better reasoning)

---

## Instructions for Testing

Run Aider with this command:
```bash
aider --model ollama/qwen2.5-coder:7b
```

Then ask the model to complete the following task:

---

## Task 1: Add Firebase Dependencies

**Objective**: Add Firebase packages to pubspec.yaml

**Instructions**:
Add these packages to the `dependencies` section in `pubspec.yaml`:
```yaml
firebase_core: ^1.24.0
firebase_auth: ^4.20.0
cloud_firestore: ^4.13.0
firebase_storage: ^11.5.0
```

**Requirements**:
- ✅ Add all 4 packages with the specific versions shown
- ✅ Don't remove or break existing dependencies
- ✅ Keep YAML formatting correct (indentation)
- ✅ Verify file is valid YAML after changes

**Success Criteria**:
- pubspec.yaml has all 4 Firebase packages in dependencies section
- File is properly formatted
- No duplicate dependencies
- Existing dependencies (flutter, cupertino_icons, flutter_svg, video_player) are preserved

---

## What to Watch For

1. **File Modification**: Check that pubspec.yaml actually gets modified
2. **Git Commits**: Watch for actual commits being made
3. **File Corruption**: Ensure no project files are damaged
4. **Completion**: Firebase packages should be added, not just explained

## Testing Checklist

After Qwen 7B responds:
- [ ] Check `git log --oneline -5` for new commits
- [ ] Check `git diff` for uncommitted changes
- [ ] Verify `grep -A 5 "dependencies:" pubspec.yaml` shows Firebase packages
- [ ] Ensure no files were corrupted
