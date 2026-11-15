# Copilot in SharePoint: site and personal skills

These are native Copilot in SharePoint skills, not SharePoint agents, saved
prompts, Microsoft 365 plugin packages, or a new tenant-wide skill registry.
The examples focus on the review workflow and preferred output, leaving
permissions and available actions to the host. The walkthrough uses synthetic
documents and explicitly requests chat output to keep its fixtures unchanged.

| Example | Intended use | Ownership and scope |
| --- | --- | --- |
| [sharepoint-site-review](skills/sharepoint-site-review/SKILL.md) | A consistent team project-brief readiness checklist | Site-admin managed; available on the associated site |
| [sharepoint-personal-brief](skills/sharepoint-personal-brief/SKILL.md) | An individual's preferred concise reading format | User-owned in OneDrive; usable by its owner across supported SharePoint sites |

Personal portability does not grant access to other sites. Both kinds use
only the capabilities and content permissions already available to the user.
They cannot connect to external systems or execute custom code.

## Prerequisites and isolated content

Use a site where Copilot in SharePoint is available and a licensed demo user.
Edit permission is required to create a skill; View permission is required
to run one. Do not change tenant policy, Restricted Content Discovery,
inheritance or spending policies merely to make a demonstration work.

Create a dedicated demo site or use an explicitly approved synthetic-content
library. Upload the [project brief](../../samples/sharepoint/project-brief.md)
and use the [rubric](../../samples/sharepoint/expected-behavior.md).
Creating/managing skills is an everyday Copilot capability; advanced work
can require Copilot Credits and explicit confirmation.

## Build reviewed packages

From the repository root in PowerShell 7:

```powershell
.\scripts\Build-Packages.ps1 `
    -SkillPath .\platforms\sharepoint\skills\sharepoint-site-review `
    -Kinds skill,onedrive-skill -OutputPath .\out\sharepoint\site
.\scripts\Build-Packages.ps1 `
    -SkillPath .\platforms\sharepoint\skills\sharepoint-personal-brief `
    -Kinds skill,onedrive-skill -OutputPath .\out\sharepoint\personal
```

`skill-<version>.zip` has root `SKILL.md` for a host upload.
`onedrive-skill-<version>.zip` has `<skill-name>/SKILL.md` for a matching-name
folder installation. Neither is a Microsoft 365 app package. A folder ZIP
must be extracted before a OneDrive folder upload; uploading the ZIP as a
plain document does not install a skill.

## Site skill deployment and management

1. On the demo site, open **Settings > Site skills**.
2. Select **Create or upload > Upload** and supply the reviewed standalone
   source/package accepted by that UI. Review its name and instructions.
3. New/uploads are enabled by default. Confirm the skill appears on that
   site's list, then open its Overview and Versions tabs.
4. The product creates its **Agent Assets** library automatically on first
   site-skill creation. Skills live at
   `/Agent Assets/Skills/<skill-name>/SKILL.md`; do not create an unrelated
   library with that display name or delete the product-managed library.
5. Select only the synthetic brief in the document library. In Copilot ask:
   `Run sharepoint-site-review on the selected document. Return recommendations in chat only.`
6. Record the actual skill indicator card and check the checklist and gaps
   against the rubric. A stored file alone is not runtime verification.

The instructions do not artificially prohibit search, document editing or
other native capabilities. A review request identifies the documents to
review; an unclear target calls for clarification rather than a blanket
restriction to selected files.

An alternative native authoring path is to ask Copilot to create a **site**
skill using the reviewed workflow, review the draft, then confirm saving.
Generated instructions need content review; do not assume they are
byte-identical to this source. Download/inspect the saved skill if needed.

The management page exposes enable/disable, copy to sites, and deletion.
Its detail page exposes editing, replacement, download and Versions.
Restoring an earlier version creates a new current version, preserving history.
For a demo, show these controls without changing them.

## Personal skill deployment and management

1. In Copilot in SharePoint ask it to create a **personal** skill named
   `sharepoint-personal-brief` using the reviewed instructions above.
2. Review the generated draft and explicitly save it as personal, not site.
   Use the host-supported personal skill management flow to review/edit it;
   do not guess a OneDrive system-folder location.
   The verified lab run used a fresh chat opened from the site home page.
   An earlier library-chat attempt refused saving; the later native
   **Skill created** card labeled **Your skill** was followed by an independent
   saved-file check.
3. Use `/skills` to inspect **Your skills** separately from **Site skills**
   and Microsoft's built-in skills.
4. On selected synthetic content, run:
   `Run sharepoint-personal-brief on the selected document. Return a reading draft in chat only.`
5. Verify a personal-skill indicator and the rubric. If testing cross-site
   availability, use a second authorized demo site with synthetic content.
   Do not infer this scope test merely from one-site invocation.

In the lab, the creation card and runtime indicator exposed the saved skill's
location. Its owner-specific OneDrive UI path was **Documents > Copilot >
Agent Assets > Skills > sharepoint-personal-brief**. This was discovered and
verified, not assumed as a universal system path. It is separate from the
Excel/PowerPoint folders and Chat's SharePoint Embedded upload storage.

The generated source retains the reviewed workflow but reformats sections and
expands the trigger description. It is not byte-identical to this repository's
package. Review the actual saved source rather than treating a natural-language
creation request as a byte-preserving import. A new chat with only the skill
name, synthetic document reference and task request showed **Used personal
skill sharepoint-personal-brief** and passed the baseline rubric.

Personal skills belong to the owner and are subject to the applicable
OneDrive retention, sensitivity, auditing and lifecycle policies. A personal
skill is not centrally assigned to all site users or all Microsoft 365 users.

## Governance and lifecycle

- Site skills inherit the site's content governance. By default, site Edit
  users can create and site View users can run; more restrictive library
  permissions are possible but require a deliberate governance decision.
- There is no separate tenant-wide skill on/off control for this feature.
  Site AI settings and Restricted Content Discovery affect Copilot
  availability; do not use retired preview opt-in cmdlets.
- Update/review a site skill through its details; test a fresh request after
  replacement or restoration. Copying to sites is distribution, not proof
  of continuous synchronization.
- Site-skill disablement and personal skill lifecycle are not the same as
  blocking a Microsoft 365 plugin. Verify actual host behavior before
  claiming revocation or permissions enforcement.

See [lab evidence](../../docs/lab-status.md) for observed results and
[the presenter walkthrough](../../docs/demo-script.md) for user/owner views.

Sources: [Native skills](https://learn.microsoft.com/sharepoint/copilot-in-sharepoint-skills),
[availability and licensing](https://learn.microsoft.com/sharepoint/copilot-in-sharepoint-get-started).
