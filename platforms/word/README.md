# Copilot in Word: plugin-provided skills

## How Word consumes skills

**Word desktop can expose skills from installed or shared Microsoft 365
plugins in its Copilot pane's `@` > Plugins picker.** The plugin is the distributed
package; the skill listed beneath it supplies the reusable instructions.
Availability depends on the account, assignment, app version and supported
plugin capabilities.

This plugin route does not establish a Word-specific OneDrive folder where
copying `SKILL.md` installs a skill.

## Use a plugin-provided skill in Word

1. Open a document and its **Copilot** pane.
2. Type `@`, search for the plugin's name, and choose the **Plugins** tab.
3. Select the skill beneath the intended plugin. For this repository's
   centrally deployed sample, select **meeting-notes** beneath **OGE Meeting
   Notes Managed**.
4. Enter the task and supply its input. For example, ask
   `Use meeting-notes to summarize these notes` and provide the
   [synthetic meeting notes](../../samples/meeting-notes/input.md).
5. Review the response and any skill-use activity. To test access to the open
   document separately, put the notes in that document and ask the selected
   skill to summarize the notes in it.

The same skill name can appear beneath several plugins. Select the intended
containing plugin rather than identifying a deployment by the skill name
alone. Seeing an entry in the picker confirms availability, not that every
capability works or that a request actually invoked it.

The `meeting-notes` skill returns a draft in chat; it does not edit the Word
document. The separate [word-project-brief skill](skills/word-project-brief/SKILL.md)
requests document edits and heading styles. Installing `meeting-notes` does
not install that other skill.

## Deploy and maintain a plugin for Word users

Use the [Microsoft 365 plugin packaging and administration
guide](../microsoft-365/plugin/README.md). Administrators upload the approved
Microsoft 365 app ZIP through **Microsoft 365 admin center > Agents > Tools >
Registry** and assign/install it for the intended users. Users then select its
skill through Word's picker; they do not upload the app ZIP into the document.

Test Word as a separate target host. Availability in Chat or Cowork does not
prove that all of a plugin's tools, scripts or editing operations work in Word.
For updates, rebuild and distribute the containing plugin, then check a fresh
Word conversation. Editing an unrelated OneDrive file does not update it.

## Verify invocation and document changes

Select the plugin's skill explicitly, supply representative input, and inspect
skill-use activity as well as the response. For `meeting-notes`, check the
[meeting-notes rubric](../../samples/meeting-notes/expected-behavior.md).

For a skill that requests document edits, verify its access to the intended
document and inspect the saved text and styles independently. Neither a picker
entry nor a correct chat draft establishes that the document changed.

The separate project-brief source and [rubric](../../samples/word/expected-behavior.md)
define an editing workflow's expected results: five headings, support-group
scope, the 2030-04-12 date, conflicting 20/30 targets, unspecified ownership and
unresolved translation/rollout decisions. These are acceptance criteria, not
proof that a plugin implements the requested editing behavior.

## Troubleshooting

- **Plugin missing from the picker:** check **Copilot pane > `@` > Plugins**,
  the signed-in account, plugin assignment/installation, and app availability.
- **Several copies of the skill appear:** check the containing plugin's name.
  A shared pilot and an organization-managed package are distinct deployments.
- **Only a chat draft is returned:** document text access does not establish
  saved-file editing support. Review the actual result before applying it
  manually or claiming automatic document updates.
- **Copying into an Office folder does nothing:** no Word-specific
  OneDrive installation folder is established by the reviewed documentation.
  Use the plugin packaging route rather than guessing a path.

## Microsoft's Legal plugin is a separate capability

Microsoft supplies a Legal plugin for **Word desktop**, enabled by default
for Microsoft 365 Copilot commercial subscribers. Administrators control it
through **Microsoft 365 Apps admin center > Policy Management**, using the
policy **Legal Skills in M365 Copilot in Word**. This policy controls
Microsoft's supplied Legal plugin; it is not an upload or deployment setting
for customer-authored plugins.

Customer-authored skill plugins use the separate [Microsoft 365 plugin
packaging and central installation route](../microsoft-365/plugin/README.md).
Their skills can appear in Word's plugin picker; the Legal policy does not
upload or assign those customer packages. Chat's upload storage is not a
Word installation folder.

Source: [Manage Copilot for legal](https://learn.microsoft.com/microsoft-365/admin/manage/manage-copilot-for-legal).
