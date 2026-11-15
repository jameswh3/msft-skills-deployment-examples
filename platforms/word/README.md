# Copilot in Word: project brief

## How Word consumes skills

The documented agent-based route is **author a skill outside Word, attach it
to a declarative agent, and make that agent available in Word's Copilot
experience**. A declarative agent is a configured Copilot assistant containing
instructions and capabilities; here, one of those capabilities is the
[word-project-brief skill](skills/word-project-brief/SKILL.md).

Microsoft documents both [adding packaged skills to declarative
agents](https://learn.microsoft.com/microsoft-365/copilot/extensibility/declarative-agent-skills)
and [running declarative agents in
Word](https://learn.microsoft.com/microsoft-365/copilot/extensibility/build-declarative-agents).
When the user refers to the open document, Word supplies its text to the
agent. For a selected passage, the user selects text and chooses **Add
selection** in the Copilot pane. See [document
interaction](https://learn.microsoft.com/microsoft-365/copilot/extensibility/declarative-agent-document-interaction).

**This is agent-packaged consumption, not a documented Word watch-folder.**
The reviewed Microsoft documentation does not establish a Word-specific
OneDrive directory where dropping `SKILL.md` installs a skill. Excel and
PowerPoint folder instructions do not establish that behavior for Word.

## Author and deploy: two documented agent-authoring options

### Option A: upload the skill through Agent Builder

1. Run `npm run build:hosts` to generate the Word example's standalone skill
   ZIP under `out/host-examples/word/word-project-brief`. Choose the archive
   with `SKILL.md` at its root, not the matching-name OneDrive folder archive.
2. In Microsoft 365 Copilot, open **Agents & Skills > New agent**, or open a
   dedicated existing declarative agent in Agent Builder.
3. Open **Configure > Skills > Add** and upload the complete skill ZIP.
   Agent Builder requires the ZIP here, not a bare Markdown file.
4. Review the skill's name, description and instructions. Give the agent a
   distinct name, such as **OGE Word Project Brief**, and instructions to use
   `word-project-brief` for project-brief requests.
5. Test it on **Try it**, then publish/share the containing agent using the
   organization's approved agent distribution process. Verify the intended
   user can find the agent in Word; Agent Builder testing is not a Word test.

Source: [Add skills in Agent
Builder](https://learn.microsoft.com/microsoft-365/copilot/extensibility/agent-builder-add-skills).

### Option B: package the skill with Microsoft 365 Agents Toolkit

1. In VS Code, select **Microsoft 365 Agents Toolkit > Create a New
   Agent/App > Declarative Agent > No Action** to create a dedicated project.
2. Enable the documented `TEAMSFX_AGENT_SKILLS` feature flag before launching
   Toolkit, and use declarative-agent manifest version **1.9**.
3. Use **Microsoft 365 Agents Toolkit > Add Skill > Create a new skill**.
   Name it `word-project-brief` and keep it scoped to this agent.
4. Replace the generated
   `appPackage/skills/word-project-brief/SKILL.md` with the reviewed source.
   Toolkit registers the skill with the containing agent. Alternatively,
   import the existing skill directory through Toolkit's documented CLI.
   Merely creating a Markdown file without registering and publishing its
   containing agent is not deployment.
5. Use **Provision** for the intended test environment, then validate/package
   and submit the containing agent through the organization's agent catalog.
   Manage its assignment in **Microsoft 365 admin center > Agents > All
   agents > select the agent**.
6. Publish updates to the containing agent when the skill changes; changing
   the source file alone does not update an installed package.

Sources: [Toolkit agent
creation](https://learn.microsoft.com/microsoft-365/copilot/extensibility/build-declarative-agents)
and [Toolkit skill
registration](https://learn.microsoft.com/microsoft-365/copilot/extensibility/build-declarative-agents-add-custom-skills).
The repository's existing Microsoft 365 scaffold script targets
`meeting-notes`; it does not generate this Word agent.

## What this establishes, and what still needs testing

The agent route establishes documented skill packaging and access to Word
document text. It does **not** by itself establish the full in-place editing
behavior requested by this example. The document-interaction article describes
text context, selection and image insertion; it does not promise arbitrary
text replacement or applying Word heading styles by an attached skill.
Word's supplied context also omits actual styling and non-textual content.
Check saved document changes independently before claiming that behavior.

For a deployment test, create a synthetic Word document from the
[project brief](../../samples/sharepoint/project-brief.md). Open the deployed
agent in Word and request:

```text
Use word-project-brief to polish this document for the support-group sponsor.
```

Verify actual skill use and check the [rubric](../../samples/word/expected-behavior.md):
the five intended headings, support-group scope, 2030-04-12 date, conflicting
20/30 targets, unspecified owner and unresolved translation/rollout decisions.
If the agent returns only a draft in chat, report that result; do not claim
the document or its heading styles were updated.

## Other surfaces and lab evidence

Word web in the lab displayed existing shared/managed packages under
**Copilot pane > Add sources, skills, and more > Choose plugins** and
**Copilot pane > Settings and more > Manage plugins**. Those observations
are separate from the documented agent route above. The generic
[Chat plugin guide](../microsoft-365/plugin/README.md) documents packaging and
central assignment, but does not independently establish a Word-specific
standalone skill deployment contract.

Creating a skill by asking Word itself was not successful: the request
returned an unsaved chat draft. That result does not rule out externally
authored, agent-packaged skills. Likewise, Chat's upload instructions and
SharePoint Embedded storage do not establish a Chat-upload-to-Word handoff.

**This example's source and archives validate locally. Its Word agent has
not been packaged, deployed or invoked in the lab.** The documented route is
now identified; Word deployment and saved-document verification remain
separate work, not a completed installation. See the [lab
ledger](../../docs/lab-status.md) and [presenter
walkthrough](../../docs/demo-script.md).
