# Foundry skills (preview)

Foundry is the agent-building service used by an application developer.
It stores skills in a selected project, with a new numbered version for each
content update. An **immutable** version cannot be edited after creation.
`default_version` identifies which version a new, unpinned reference selects;
it does not change the version already used by an existing agent.

## Use a skill through an application

An application developer attaches the skill to a Foundry agent. Users then
send tasks to that application or agent; they do not install the skill into
their personal Copilot account. Ask the application owner for the application
link or supported API access and the required sign-in.

For the meeting-notes example, the application sends the notes to the agent
and returns the structured summary. Developers can also test the agent in a
supported playground or through its agent endpoint. An ordinary application
user does not need VS Code or Azure CLI.

## Manage as a project owner or administrator

- **Documented graphical interface:** in VS Code, open **Microsoft Foundry
  Toolkit** for the intended project, then **Tools > Skills > meeting-notes**.
  This is an extension in VS Code, not a Microsoft 365 admin center page.
- **Lab-tested management route:** run this repository's
  `Invoke-FoundrySkill.ps1` with **Inspect** to read the skill and its versions.
  The commands below show the other operations for developers.
- **Which version an agent uses:** inspect that agent's saved definition.
  A pinned reference names a specific version rather than following the
  skill's default.

The API uses the Azure AI authentication scope and the
`Foundry-Features: Skills=V1Preview` request header. The API commands below
require an authorized project account; ordinary users of the finished
application do not run them.

## Prerequisites

- A Foundry project in a supported Copilot-harness region. The harness is the
  agent's execution engine; this example requires the Microsoft Copilot one.
- Foundry User (formerly Azure AI User) or equivalent project permissions.
- An existing reasoning/tool-calling model deployment for runtime testing.
- An Azure CLI session for the intended tenant/subscription.

## Create a skill version as an author

From the repository root, set your own endpoint (never commit lab values):

```powershell
$project = 'https://<account>.services.ai.azure.com/api/projects/<project>'
.\scripts\Invoke-FoundrySkill.ps1 -ProjectEndpoint $project -Operation CreateVersion -WhatIf
.\scripts\Invoke-FoundrySkill.ps1 -ProjectEndpoint $project -Operation CreateVersion
```

Record the returned immutable version. The first creation can establish the
initial default. For updates, inspect the current default before and after
creation; do not assume a CLI convenience update stages without promotion.

```powershell
.\scripts\Invoke-FoundrySkill.ps1 -ProjectEndpoint $project -Operation Inspect
.\scripts\Invoke-FoundrySkill.ps1 -ProjectEndpoint $project -Operation SetDefault -SkillVersion '<candidate version>'
```

The script submits the canonical description and Markdown instructions as
inline content. This instruction-only sample does not need companion files.
It does not create an agent, invoke a model, or grant RBAC.

## Attach the skill to an agent and test it

In Foundry, create a **new prompt agent with the Microsoft Copilot harness**,
select the existing model, add the skill with an explicit immutable version,
then Save and start new chat. Verify its stored definition and run the shared
synthetic input.

For REST deployment, copy [agent.example.json](agent.example.json) to an ignored
lab file and replace the model deployment and immutable skill version. Keep a
new, unique agent name. The example disables the broad harness capabilities
and enables only file reading; no customer tools are attached.

```powershell
az rest --method post --resource https://ai.azure.com `
  --url "$project/agents?api-version=v1" `
  --headers 'Foundry-Features=MicrosoftCopilot=V1Preview,Skills=V1Preview' `
  --body '@out\agent.json'
```

Inspect `versions.latest.definition` and its `skills`, `harness`, and `tools`;
agent creation returns an agent container, not just a version object.
Invoke through the **agent-scoped** base URL
`$project/agents/<agent-name>/endpoint/protocols/openai`, creating an explicit
conversation before calling `/responses`. Do not use the project-level
Responses route for the Copilot harness. See the official
[endpoint examples](https://learn.microsoft.com/azure/foundry/agents/faq#which-endpoint-should-i-use-to-invoke-a-copilot-harness-agent-).
Confirm both the completed `skill` invocation and the output against the
[rubric](../../samples/meeting-notes/expected-behavior.md); a plausible summary
alone does not prove that the skill loaded.

For deployment through a generated `azd` project, preserve its actual project
and model fields and add a skill reference to the agent service:

```yaml
skills:
  - name: meeting-notes
    version: "<candidate version>"
```

This is a fragment, not a complete `azure.yaml`. Pin the supported CLI/extension
versions from the current host documentation before using it.

An unpinned reference is resolved when a prompt-agent version is created and
stored as an immutable version. Changing `default_version` does **not** update
already-created agent versions.

## Export, rollback, remove

```powershell
.\scripts\Invoke-FoundrySkill.ps1 -ProjectEndpoint $project -Operation Export -SkillVersion '<approved version>' -OutputPath .\out\foundry-export.zip
```

Export creates an archive and a record of its source/version/hash without
extracting or executing its content. Review both before using it in another
product.

To roll back, set the previous default if appropriate **and configure the
agent to use the previous skill version**. Test a new conversation.
Before deleting versions or skills, inventory consumers; preserve rollback
content. No destructive delete operation is included in the script.

For the distinct catalog/distribution path and optional toolbox discovery,
see [Foundry + API Center](../foundry-api-center/README.md).

## Troubleshooting

- **Cannot list or upload skills:** confirm the selected project, project
  permissions, authentication scope and required preview header.
- **New skill version has no effect:** inspect the agent's saved skill
  reference. Changing `default_version` does not update an existing agent.
- **REST invocation fails:** use the agent-scoped endpoint described above,
  not the project-level Responses route.
- **A response looks right but skill use is unclear:** inspect the completed
  skill invocation as well as output. Matching prose alone is not proof.
- **Feature unavailable:** check region, engine and preview support before
  changing organization permissions or provisioning replacement resources.

The [lab results](../../docs/lab-status.md) describe the tests completed by
this repository; they are not a requirement to use your own project.

Sources: [Skills API](https://learn.microsoft.com/azure/foundry/agents/how-to/tools/skills),
[Copilot harness](https://learn.microsoft.com/azure/foundry/agents/how-to/use-tools-skills-copilot-harness).
