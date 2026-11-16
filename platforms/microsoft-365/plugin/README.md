# Microsoft 365 skill plugins: Chat, Cowork and Word

A plugin is the installable package containing the skill. Authors can share
the plugin, or administrators can centrally assign/install it for users or
groups. Users select its skill in Chat, Cowork or supported Word experiences.
It is not a separate skill file each employee must manually copy.

Word can expose both centrally deployed and owner-shared plugins.
Word is a consumption surface for their skills, not a separate Word-specific
skill deployment mechanism. Management and updates follow the containing
plugin's delivery method.

## Where users and administrators find it

- **Copilot Chat user:** select the installed skill/plugin in the chat's
  skills/plugin picker.
- **Cowork user:** open **Customize > Plugins > Added > select the plugin**.
- **Word user:** in the **Copilot** pane, type `@`, search the plugin's
  name, choose **Plugins**, and select the skill listed beneath that plugin.
- **Administrator:** open **Microsoft 365 admin center > Agents > Tools >
  Registry > select the plugin > Users** to review who can use it and who
  has it installed. The plugin details contain block/uninstall controls.

Users and administrators can follow the next sections without building a
package. The later author sections use WIQD (Work IQ Dev Tools) to generate
a starter project and its deployment files.

## Use the installed skill

1. In Chat, select the installed skill/plugin. In Word, use **Copilot
   pane > `@` > Plugins** and select its skill. In Cowork, open **Customize >
   Plugins > Added**, select the plugin and turn it on for your conversations.
   An organization-installed plugin can be present but turned off.
2. Start a conversation or Cowork task. For the sample, ask
   `Use meeting-notes to summarize these notes` and supply the meeting notes.
3. Review the result and the skill-use activity, when available. Installation
   does not force every request to invoke the skill.

For a personal Chat skill rather than a plugin, follow the
[Chat upload instructions](../README.md#install-a-personal-skill-in-copilot-chat).
Cowork also supports personal skills through **Customize > Skills > Add >
Create new**, or **Upload skill** from the Add menu. Those are owner-managed
skills, not an organization plugin assignment; see [Cowork
customization](https://learn.microsoft.com/copilot/cowork/cowork-customize).

## Install for users as an administrator

Have the approved Microsoft 365 app ZIP from its author; a standalone
`SKILL.md` or skill ZIP is not that app package.

1. Open **Microsoft 365 admin center > Agents > Tools > Registry > Upload**.
2. Upload the built app ZIP, review its components, and select the intended
   users/groups. Start with a small test audience.
3. Complete **Install**, then open the package's **Users** panel and verify
   both availability and installation scope. If it is already registered but
   not installed, find it under **Agents > Tools > Plugins** and select
   **Install** for the intended audience.
4. If blocked, check **Agents > Settings > Agent and plugin access** for the
   relevant publisher category.
5. Ask a recipient to find and run the installed skill in each intended host:
   Chat, Cowork and/or Word. Verify them separately before expanding assignment.

For Word selection and document-editing boundaries, see the
[Word guide](../../word/README.md). A plugin appearing in Word's picker does
not establish that every tool or editing capability in that package works there.

Updates and removal are covered below. If you need to build the package
first, use the author instructions in the next two sections.

## Build the package as an author

Chat standalone skills are generally available. WIQD 0.26.0 is preview and
its plugin CLI is alpha. This repository uses the official generated project.

From the repository root:

```powershell
npm ci
.\scripts\New-Microsoft365Examples.ps1 -Kind Plugin
```

The scaffold requires you to review and explicitly accept the WIQD EULA.
The script does not accept terms automatically.

On Windows, invoke the pinned CLI without npm's Node PowerShell shim:

```powershell
$node = (Resolve-Path .\node_modules\node\bin\node.exe).Path
$wiqd = (Resolve-Path .\node_modules\@microsoft\wiqd\bin\wiqd.js).Path
$project = (Resolve-Path .\out\microsoft-365\meeting-notes-plugin).Path
& $node $wiqd plugin validate --path $project --env dev --mode source
```

Inspect the generated manifest, privacy/terms URLs, publisher, icons, app
identity, and environment configuration before deployment. Replace scaffold
placeholder publisher metadata with information appropriate for your tenant.

**Source validation is not full package validation.** For a skills-only
plugin, it does not validate the actual skill payload.

## Provision and package (changes the tenant)

Only run these after confirming the signed-in tenant and deployment audience:

```powershell
& $node $wiqd auth login --interactive
& $node $wiqd plugin provision --path $project --env dev
& $node $wiqd plugin package --path $project --env dev
```

`dev` is generated with shared scope. Inspect `AGENT_SCOPE`; an environment
name is not proof of effective scope. The `local` scaffold environment is
intended for personal testing; `local` itself is not a valid `AGENT_SCOPE`
publication value. Keep the generated scope or use a documented supported
value; tenant publication and audience assignment are separate operations.
Provision first: it writes the environment values package/share require.

Validate the actual returned ZIP path. This operation uploads the package:

```powershell
& $node $wiqd plugin validate --path $project --env dev --mode package --package-file '<returned ZIP path>'
```

Do not substitute older `--mode deep` examples for the pinned CLI's supported
modes. Sharing is not catalog publication, even for tenant-wide sharing.

## Shared packages and organization uploads

For catalog publication through WIQD, review the generated `publish` lifecycle
and use `plugin publish` with the same explicit project/environment. Organization
approval may be required. Do not equate provision, share, publish, and install.

An owner-shared plugin and a separately uploaded organization-managed plugin
can have different assignment controls, even if they contain the same skill.
Check the app identity and delivery method, not just its display name.

If a test package is already shared and you need a separate managed package,
use a deliberately separate app identity and name for that new package;
validate it before upload. Keep its identity stable for later updates. Do not
repeatedly create new IDs to work around an update or access problem.

## Update, rollback, and removal

- Update the canonical source, refresh the generated skill, increment the app
  version, package, validate, and redeploy. Do not edit only the generated copy.
- Preserve the previous ZIP and source hash. Roll back by redeploying reviewed
  previous content under a valid next app version if the service rejects a
  version downgrade; verify a fresh conversation.
- Re-share owner-shared changes when required by the sharing method.
- Admins can block/uninstall packages and delete tenant-uploaded packages.
- Cowork users cannot remove admin-installed plugins, but can disable them
  for their conversations. Admin deployment does not force invocation.
- Cowork blocking affects new conversations; do not claim immediate
  interruption of sessions already using the plugin.
- Microsoft Purview is Microsoft's compliance and audit service; use it to
  review Copilot activity where available. This sample has no external
  connectors requiring user or administrator approval.

## Troubleshooting

| Problem | What to check |
| --- | --- |
| A user cannot find the package | Confirm the account, package identity, Users availability/installation scope, and publisher policy. |
| Cowork lists it but does not use it | Open Customize > Plugins > Added and turn it on, then explicitly request the skill in a new task. |
| A changed file has no effect | Rebuild and distribute the containing package; re-share if required. Editing the author's source alone does not update an installed package. |
| Activity identifies the wrong copy | Check for shared and managed packages containing the same skill name; use a test recipient with only the intended package when identifying its source. |

Sources: [Chat skills](https://learn.microsoft.com/microsoft-365/copilot/extensibility/build-copilot-chat-skills),
[Cowork administration](https://learn.microsoft.com/copilot/cowork/cowork-manage-plugins),
[WIQD lifecycle](https://microsoft.github.io/wiqd/getting-started/build-a-plugin/).
