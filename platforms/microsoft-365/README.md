# Skills in Microsoft 365 Copilot Chat and dedicated agents

Choose whether the user should stay in general chat or open a dedicated
assistant. Both can use the same reviewed skill instructions, but they are
packaged and managed differently:

| User experience | How to deploy it | Where the skill is maintained |
| --- | --- | --- |
| Select a skill/plugin in Copilot Chat or Cowork | Build a plugin package containing the skill | Microsoft 365 admin center > Agents > Tools > Registry > select the plugin |
| Open a dedicated Copilot assistant | Bundle the skill inside a declarative agent and publish the agent | Agent Builder > Configure > Skills, or the registered skill directory in an Agents Toolkit project |

## Use an existing skill or agent

1. Sign in to [Microsoft 365 Copilot](https://copilot.cloud.microsoft/) with
   the account your organization granted access.
2. For a standalone skill, select the installed skill/plugin in the chat's
   picker. For an agent-scoped skill, open the dedicated agent from the agent
   list instead. Labels may appear as **Agents & Skills** or **Agents**.
3. Enter the task and supply its input. With this repository's example, ask
   `Use meeting-notes to summarize these notes`, followed by your notes.
4. Review the response. A summary should not invent an owner, deadline or
   decision that the notes do not contain.

## Install a personal skill in Copilot Chat

This is for your own Chat use, not organization-wide assignment:

1. Prepare the reviewed `SKILL.md`, or a ZIP with `SKILL.md` at its top level.
2. In Copilot, open **Agents > More agents**, then **Add > Upload skill**.
3. Upload the file, review the name/description, and save it.
4. Open it in **Agents & Skills** to review its instructions and automatic-use
   setting. Select it explicitly for the first request.

Uploaded Chat skill files are stored in tenant-scoped SharePoint Embedded
containers, not an ordinary Word/Excel/PowerPoint OneDrive skills folder.
These Chat instructions do not establish installation in those apps.
Source: [personal Chat skill authoring and
upload](https://learn.microsoft.com/microsoft-365/copilot/extensibility/build-copilot-chat-skills).

## Install and manage for other people

- For Chat/Cowork plugins, use the [plugin installation and administration
  guide](plugin/README.md#install-for-users-as-an-administrator).
- For a dedicated assistant, use the [declarative-agent
  guide](declarative-agent/README.md).
- Check both **Available to** and **Installed for** in the package's user
  settings where offered. Access approval alone is not proof of installation.

## If a skill is missing or does not run

- Confirm you are using the account it was shared/assigned to, not another
  personal or work account.
- Ask the owner/admin to confirm the package identity, assignment and
  installation. Similar display names can refer to different packages.
- Check organization policy under **Microsoft 365 admin center > Agents >
  Settings > Agent and plugin access** if the item is blocked.
- Select the skill explicitly and start a fresh conversation after updates.
  Chat and Cowork must be checked separately.

## Technical packaging details for authors

For authors editing package configuration files (called manifests), the two
registration properties are:

- **Plugin skill:** `agentSkills` in the Microsoft 365 app manifest. Targets
  standalone Copilot Chat and Cowork. [Plugin guide](plugin/README.md).
- **Agent-scoped skill:** `agent_skills` in the declarative-agent manifest.
  Targets the packaged agent. [Agent guide](declarative-agent/README.md).

Do not interchange those properties or assume a personal upload installs a
plugin for other people. Check that the intended user can find and run the
skill separately in Chat, Cowork, and the dedicated agent.

Prerequisites include the intended Microsoft 365 tenant/account, appropriate
licensing, permission to upload custom apps, and administrator access for
organization assignments. Information Barriers can restrict skill/plugin
upload and sharing; check the target tenant first.

See [primary sources](../../docs/sources.md) and the
[common rollout lifecycle](../../docs/lifecycle-and-governance.md).
