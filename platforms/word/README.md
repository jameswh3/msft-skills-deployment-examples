# Copilot in Word: project brief

The [word-project-brief skill](skills/word-project-brief/SKILL.md) polishes a
brief in the actual document using native headings and grounded open decisions.
It is a workflow definition, not a new permission boundary.

## Creation and fixture

Run `npm run build:hosts` from the repository root. The Word example's
standalone and matching-name folder packages are generated separately from
the original meeting-notes plugin.

Create a new synthetic Word document from the
[project brief](../../samples/sharepoint/project-brief.md).
Use the [rubric](../../samples/word/expected-behavior.md) to check actual
document changes, not just a chat response.

## Deployment boundary

Word web in this lab exposes **Add sources, skills, and more > Choose
plugins** and **Settings and more > Manage plugins**. Existing shared and
organization-managed skill packages were visible. This is observed browser
consumption support, not a desktop-only assumption.

**Creation within Word is not a supported option for this example.**
Current documentation does not establish that capability, and the native
creation request returned only an unsaved draft, with no personal
skill-storage tool or native save control. Do not present conversational
drafting as skill creation or continue searching for an assumed Word
OneDrive authoring folder.

The source remains an externally authored workflow example, not a deployed
Word skill. Investigation is closed for this lab: no speculative Chat-upload
handoff, managed-plugin alternative, or assumed Word OneDrive path is being
tested. Excel's and PowerPoint's personal folders are not Word installation
paths. Copilot Chat's documented SharePoint Embedded upload storage does not
establish Word discovery or consumption.

The existing [Microsoft 365 plugin approach](../microsoft-365/plugin/README.md)
demonstrates central package assignment and management. A standalone skill
ZIP is not that app package. The Word workflow in this directory is not
silently included in the previously deployed meeting-notes package.
Consult the [lab ledger](../../docs/lab-status.md) before claiming this
specific Word source has been installed or invoked.

## Intended behavior, not a live installed-skill demo

If a documented Word distribution route is established separately, install
and verify this specific source before selecting it through the picker:

```text
Polish this project brief for the support-group sponsor.
```

Inspect the saved document and its navigation/headings:

- Purpose, Audience and scope, Delivery plan, Success criteria, Open decisions.
- Native heading styles rather than literal Markdown markers.
- Preserved support-group scope, 2030-04-12 date, and unresolved 20/30 targets.
- Missing owner remains **Not specified**; expansion is not made approved.
- Translation scope remains an open decision.

Do not paste the full instructions into a prompt and label that an installed
skill demonstration.

## Observed management surface

Existing shared/managed packages were visible under **Manage plugins**.
That observation does not establish a deployment route for this new example.
Do not present its local source as installed or demonstrate a Word-native
creation or OneDrive catalog.

See [the presenter walkthrough](../../docs/demo-script.md) and
[support boundaries](../../docs/support-matrix.md).
