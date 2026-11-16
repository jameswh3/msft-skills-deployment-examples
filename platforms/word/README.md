# Copilot in Word: plugin-provided and agent-attached skills

## How Word consumes skills

**Word desktop can expose skills from installed or shared Microsoft 365
plugins in its Copilot pane's `@` > Plugins picker.** A separate declarative
agent is not required for this plugin route. The plugin is the distributed
package; the skill listed beneath it supplies the reusable instructions.
Availability depends on the account, assignment, app version and supported
plugin capabilities.

Word also supports skills attached to a declarative agent. That is a
different packaging route, described below. Neither route establishes a
Word-specific OneDrive folder where copying `SKILL.md` installs a skill.

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

## Alternative: attach the skill to a declarative agent

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

**An agent-attached skill is scoped to its containing agent.** It is different
from selecting a plugin-provided skill directly in Word's Copilot pane.
The reviewed Microsoft documentation does not establish a Word-specific
OneDrive directory where dropping `SKILL.md` installs a skill. Excel and
PowerPoint folder instructions do not establish that behavior for Word.

### Use an agent-attached skill

1. Open a document you can access and its Copilot pane.
2. Open the declarative agent supplied by your organization. The skill is
   bundled inside that agent; selecting an unrelated plugin does not add it.
3. Refer to the open document in your request. For selected text, highlight
   the passage and choose **Add selection**.
4. Ask for the task described by the skill, then review the response and any file
   changes independently. Access to document text does not by itself prove
   that a skill can replace text or apply heading styles in the saved file.

The agent must contain the skill and be available to the signed-in user.
Document-interaction limits are described below.

### Author and deploy: two documented agent-authoring options

#### Option A: upload the skill through Agent Builder

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

#### Option B: package the skill with Microsoft 365 Agents Toolkit

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
6. Publish updates to the containing agent when the skill changes; changing
   the source file alone does not update an installed package.

Sources: [Toolkit agent
creation](https://learn.microsoft.com/microsoft-365/copilot/extensibility/build-declarative-agents)
and [Toolkit skill
registration](https://learn.microsoft.com/microsoft-365/copilot/extensibility/build-declarative-agents-add-custom-skills).
The repository's existing Microsoft 365 scaffold script targets
`meeting-notes`; it does not generate this Word agent.

### Maintain and update an agent-attached skill

- The author maintains the skill through **Agent Builder > Configure >
  Skills** or its registered directory in an Agents Toolkit project. Review and
  publish a new agent package when the skill changes; editing a Markdown file
  in an unrelated OneDrive folder does not update the installed agent.
- Keep the previous reviewed skill source and package for rollback.

## What Word can read and what you must verify

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

## Troubleshooting

- **Plugin missing from the picker:** check **Copilot pane > `@` > Plugins**,
  the signed-in account, plugin assignment/installation, and app availability.
- **Several copies of the skill appear:** check the containing plugin's name.
  A shared pilot and an organization-managed package are distinct deployments.
- **Agent not visible in Word:** confirm the signed-in account, organization
  distribution/installation and recipient access to the agent.
- **Skill unavailable inside the agent:** confirm it was added/registered
  in that agent's package and the updated agent was published.
- **Only a chat draft is returned:** document text access does not establish
  saved-file editing support. Review the actual result before applying it
  manually or claiming automatic document updates.
- **Copying into an Office folder does nothing:** no Word-specific
  OneDrive installation folder is established by the reviewed documentation.
  Use the plugin or agent packaging route rather than guessing a path.

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
