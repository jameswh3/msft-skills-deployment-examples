# Microsoft 365 examples

Choose whether the user should stay in general chat or open a dedicated
assistant. Both can use the same reviewed skill instructions, but they are
packaged and managed differently:

| User experience | How to deploy it | Where an administrator finds it |
| --- | --- | --- |
| Select a skill/plugin in Copilot Chat or Cowork | Build a plugin package containing the skill | Microsoft 365 admin center > Agents > Tools > Registry > select the plugin |
| Open a dedicated Copilot assistant | Bundle the skill inside a declarative agent and publish the agent | Microsoft 365 admin center > Agents > All agents > select the agent |

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
