# Copilot in SharePoint: site and personal skills

Skills add reusable task instructions to **Copilot in SharePoint**,
the chat experience on a SharePoint site. They use the content permissions
the user already has. The examples use fictional documents and request
responses in chat so the source documents remain unchanged.

- **Site owner:** open the relevant SharePoint site, then **Settings > Site
  skills > select the skill > Overview or Versions** to manage a site skill.
- **Personal skill owner:** in Copilot's saved **Your skill** card, select
  **Open skill location**, or follow the source link on **Used personal
  skill**, to inspect the saved file in OneDrive.

These are not separately published SharePoint agents or Microsoft 365 plugin
packages. They do not create an organization-wide skill assignment.

| Skill name (example) | Where the skill is used | What this example does | Where its instructions are stored |
| --- | --- | --- | --- |
| [sharepoint-site-review](skills/sharepoint-site-review/SKILL.md) (site skill) | Copilot chat on the associated SharePoint site, for users with the required site/content permissions | Check project briefs for a goal, owner, audience, date and success criteria; report missing or conflicting details | The site's Agent Assets library |
| [sharepoint-personal-brief](skills/sharepoint-personal-brief/SKILL.md) (personal skill) | Copilot in SharePoint, for the individual user across supported sites they can access | Summarize selected documents as three takeaways, a facts table and questions about missing or conflicting details | The individual user's OneDrive |

These are example tasks, not limits on what site or personal skills can do.
Being able to use a personal skill across sites does not grant access to
those sites. Both kinds use
only the capabilities and content permissions already available to the user.
They cannot connect to external systems or execute custom code.

## Use an existing site or personal skill

1. Open a SharePoint site and content you can access, then open its Copilot
   chat pane. You do not need to be a site administrator to run an available
   skill.
2. Enter `/skills`. **Site skills** are associated with the current site;
   **Your skills** are the reusable instructions saved for your own use.
3. Select or name the intended skill and identify the document to review.
   For the sample, select the [project brief](../../samples/sharepoint/project-brief.md)
   and ask `Run sharepoint-site-review on the selected document`.
4. Review the response and its skill-use indicator. The site example reports
   missing or conflicting project-brief requirements; the personal example
   returns takeaways, a facts table and questions about missing or
   conflicting information in the documents.

The sample requests chat output to preserve its test document. That is a
choice for the example, not a general restriction added to either skill.

## Requirements

Use a site where Copilot in SharePoint is available and a licensed account.
Edit permission is required to create a skill; View permission is required
to run one. More restrictive library permissions may affect access.

For first-time evaluation, use a test site or approved library with the
fictional [project brief](../../samples/sharepoint/project-brief.md).
Do not change organization permissions or spending policies just to run it.
Creating/managing skills is an everyday Copilot capability; advanced work
can require Copilot Credits and explicit confirmation.

## Create and manage a site skill

1. On the site where people will use it, open **Settings > Site skills**.
2. Select **Create or upload > Upload** and supply the reviewed standalone
   source/package accepted by that UI. Review its name and instructions.
3. New/uploads are enabled by default. Confirm the skill appears on that
   site's list, then open its Overview and Versions tabs.
4. The product creates its **Agent Assets** library automatically on first
   site-skill creation. Skills live at
   `/Agent Assets/Skills/<skill-name>/SKILL.md`; do not create an unrelated
   library with that display name or delete the product-managed library.
5. Test it using the **Use an existing site or personal skill** steps above
   and the sample's [expected behavior](../../samples/sharepoint/expected-behavior.md).

Alternatively, ask Copilot in SharePoint to create a **site** skill using
the reviewed instructions, review the draft, then confirm saving.
Generated instructions need content review; do not assume they are
byte-identical to this source. Download/inspect the saved skill if needed.

On **Settings > Site skills**, select the skill to find enable/disable,
**Copy to sites**, and deletion actions. Open its details for editing,
**Replace**, **Download**, and **Versions**.
The details page's **Edit** menu offers **Edit** and **Edit with Copilot**.
Use **Disable** to stop use on the site, **Copy to sites** to distribute
a copy, **Replace** to upload reviewed instructions, and **Versions** to
inspect or restore earlier content. Restoring creates a new current version
and preserves history. Test after replacement or restoration; copied sites
are not automatically kept synchronized.

## Personal skill deployment and management

1. In Copilot in SharePoint ask it to create a **personal** skill named
   `sharepoint-personal-brief` using the reviewed
   [skill instructions](skills/sharepoint-personal-brief/SKILL.md).
2. Review the generated draft and explicitly save it as personal, not site.
   Use **Open skill location** on the saved card, or the source link on the
   **Used personal skill** indicator, to inspect its saved `SKILL.md` in
   OneDrive; do not guess a system-folder location.
3. Use `/skills` to inspect **Your skills** separately from **Site skills**
   and Microsoft's built-in skills.
4. On selected synthetic content, run:
   `Run sharepoint-personal-brief on the selected document. Return takeaways, a facts table and open questions in chat only.`
5. Verify the **Used personal skill** indicator and expected result.
   To check availability across sites, repeat on a second site you can access.

Use the creation card or runtime indicator to open the saved skill's actual
location. A personal skill's OneDrive path can appear as **Documents > Copilot >
Agent Assets > Skills > sharepoint-personal-brief**; follow the supplied link
rather than assuming a universal installation folder. This storage is separate
from the Excel/PowerPoint folders and Chat's SharePoint Embedded upload storage.

Review the actual saved instructions: Copilot may reformat or add to the
instructions you supplied. For an update, revise the saved skill
through its supported creation/editing flow and test the saved result in a
new chat. A chat draft without a saved skill is not an installation.

Personal skills belong to the individual user. Organization policies for
OneDrive file retention, sensitive information and activity logging apply. A personal
skill is not centrally assigned to all site users or all Microsoft 365 users.

## What site and organization administrators can manage

- Site permissions control who can create and run site skills. By default,
  users with Edit permission can create them and users with View permission
  can run them. Administrators can set more restrictive library permissions.
- There is no separate tenant-wide skill on/off control for this feature.
  Site AI settings and Restricted Content Discovery affect Copilot
  availability; do not use retired preview opt-in cmdlets.
- Update/review a site skill through its details; test a fresh request after
  replacement or restoration. Copying to sites is distribution, not proof
  of continuous synchronization.
- Disabling a site skill does not manage personal skills or block a
  Microsoft 365 plugin. Check the relevant product's controls and test
  whether the intended user can still run the skill.

## Troubleshooting

- **A site skill is missing:** confirm you are on the associated site, have
  content permissions, and the skill is enabled under **Settings > Site
  skills**. A skill on another site is not automatically a local site skill.
- **Personal creation returned only text:** check for a saved **Your skill**
  card and its actual source file. Review the draft and explicitly confirm
  personal saving; do not assume conversational instructions were saved.
- **A copied site uses old instructions:** update that site's copy; copying
  is distribution, not ongoing synchronization.
- **Copilot itself is unavailable:** check site availability, licensing and
  organization/site policies before troubleshooting the skill file.

## Optional: build the sample packages

Users running an existing skill do not need this step. Authors can run from
the repository root in PowerShell 7:

```powershell
.\scripts\Build-Packages.ps1 `
    -SkillPath .\platforms\sharepoint\skills\sharepoint-site-review `
    -Kinds skill,onedrive-skill -OutputPath .\out\sharepoint\site
.\scripts\Build-Packages.ps1 `
    -SkillPath .\platforms\sharepoint\skills\sharepoint-personal-brief `
    -Kinds skill,onedrive-skill -OutputPath .\out\sharepoint\personal
```

`skill-<version>.zip` has `SKILL.md` at its top level for a supported upload.
`onedrive-skill-<version>.zip` contains a matching-name folder; extract it
before a OneDrive folder upload where that installation method is supported.
Neither is a Microsoft 365 app package, and storing a ZIP as a document does
not install it.

Sources: [Native skills](https://learn.microsoft.com/sharepoint/copilot-in-sharepoint-skills),
[availability and licensing](https://learn.microsoft.com/sharepoint/copilot-in-sharepoint-get-started).
