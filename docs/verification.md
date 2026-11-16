# Verification

## Local checks: validate files without deploying them

```powershell
npm ci
npm run validate
npm test
npm run build
```

Tests cover invalid/duplicate metadata, encoding, unsafe/missing references,
archive roots, included manifests, actual packaged bytes, changed-source
provenance, and script syntax.

Generate and inspect both official Microsoft 365 projects separately.
Source validation for a skills-only WIQD project does not cover its actual
skill or full package; report that limitation.

## Live checks: test the installed skill in each product

Use the [same input](../samples/meeting-notes/input.md),
[rubric](../samples/meeting-notes/expected-behavior.md), and
[edge cases](../samples/meeting-notes/edge-cases.md). The rubric is the
expected-behavior checklist. Use the corresponding sample/rubric instead
when testing a SharePoint or Office-specific workflow.

1. Confirm the organization, assigned users, installed package, the skill
   version selected by its agent, and the product/app version.
2. Find/select the skill explicitly where supported; record observed loading.
3. Run a naturally matching prompt with automatic discovery enabled.
4. Run an unrelated prompt; ensure this skill is not spuriously invoked.
5. Test missing notes, missing owners/dates, conflicting facts and embedded
   instruction attempts.
6. For `meeting-notes`, verify all four output sections and check that
   action-item owners, dates and tasks match the supplied notes. For other
   examples, use their expected-behavior checklists instead.
7. For central assignment, verify an intended recipient and any excluded
   audience. For an all-user lab assignment, record that no excluded-user
   control was exercised rather than fabricate a result.
8. Publish an update and confirm the installed copy or agent uses the new
   instructions.
9. Roll back and verify the previous instructions and selected skill version
   in a new conversation.
10. Revoke/block and check a fresh session.

Do not report every test as passed because one normal-input request worked.

## Evidence levels

- **Documented:** official documentation supports the approach.
- **Local pass:** source/archive/scaffold checks ran successfully.
- **Deployed:** service read-back confirms registration/assignment.
- **Runtime pass:** observed invocation and evaluated output.
- **Not executed / blocked / unavailable:** explicit remaining gap.

API Center discovery and Foundry export are separate checks. Test remote
toolbox skill loading only in a compatible client. Do not infer it from a
successful MCP tool call.

Run GitHub Copilot runtime checks with an entitled account and a supported
client. Record runtime verification separately from repository publication
and offline validation.
