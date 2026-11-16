# Declarative-agent skill

Here, the skill is bundled inside a dedicated Copilot assistant. The user
opens that assistant; they do not install the skill separately.

The author edits the skill in the agent project and republishes the agent
when it changes. An administrator manages the published assistant under
**Microsoft 365 admin center > Agents > All agents > select the agent**.
This differs from a standalone Chat/Cowork plugin, which is listed under
**Agents > Tools > Registry**.

## Use the agent

1. Sign in to Microsoft 365 Copilot with the assigned account and open the
   dedicated agent from the agent list. Use the name supplied by your
   organization; the `meeting-notes` skill is inside that assistant.
2. Supply meeting notes and ask the agent to summarize them using its skill.
3. Review the summary, decisions, action items and open questions. Missing
   owners/dates should remain unspecified rather than being invented.

## Requirements and ownership

Users need access to the published agent and the required Copilot features.
Authors need permission to create/upload custom apps. Administrators control
organization assignment. A user of an existing agent does not need to
install Agents Toolkit or build a ZIP.

## Create the agent as an author

Install Microsoft 365 Agents Toolkit CLI **1.1.17** using its
[official installation instructions](https://learn.microsoft.com/microsoftteams/platform/toolkit/microsoft-365-agents-toolkit-cli).
Then, from this repository root:

```powershell
.\scripts\New-Microsoft365Examples.ps1 -Kind DeclarativeAgent
```

The script uses the official scaffold and `atk add skill --from`. It enables
`TEAMSFX_AGENT_SKILLS` only for that process and restores its previous value.
The pinned scaffold emits an older declarative-agent schema, so the script
updates the agent manifest to documented **v1.9** before deployment. The
Microsoft 365 app manifest is a separate schema/version.

The generated agent references `skills/meeting-notes` using `agent_skills`;
the canonical skill is copied byte-for-byte. Inspect the generated publisher,
URLs, app identity, icons, and environment before provisioning.

## Deploy and manage as an administrator or owner

1. Confirm `atk account list` identifies the intended Microsoft 365 tenant.
2. From the generated project, provision with `atk provision --env dev`.
3. Validate/package using the pinned Toolkit's supported commands; tenant
   validation may upload content.
4. Submit/install the package through the Microsoft 365 organization catalog
   and assign the intended audience in the admin center.
5. Open **the agent**, submit the synthetic notes, and confirm skill invocation.
6. To update, refresh the bundled canonical skill, package/publish the agent
   again, and verify a new conversation.
7. Roll back with a reviewed previous-content package and verify its version.
   Block/uninstall the agent package to revoke distribution.

Use **Microsoft 365 admin center > Agents > All agents > select the agent**
to review its status and assigned audience. Verify access as an intended
recipient rather than only as the author.

## Troubleshooting

- **Agent not visible:** confirm the signed-in account, organization
  publication, assigned audience and installation.
- **Skill unavailable:** confirm it is registered inside this agent's
  package. Installing the standalone Chat plugin does not add it to an agent.
- **Old behavior after an edit:** publish the updated agent package and test
  a new conversation; the installed package does not read your local file.

An agent-scoped skill is a bundled component, not a live cross-agent registry
reference. Limits include eight skills, depth three, 350 files across skills,
and a 10 MB complete app package for Toolkit authoring. This sample is far
below those limits.

Sources: [Toolkit skill guide](https://learn.microsoft.com/microsoft-365/copilot/extensibility/build-declarative-agents-add-custom-skills),
[support matrix](https://learn.microsoft.com/microsoft-365/copilot/extensibility/declarative-agent-skills).
