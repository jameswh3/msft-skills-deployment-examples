# Support and deployment boundaries

Use this comparison to choose how users will receive a skill and who will
maintain it. For task-based instructions, start with the
[user and administrator guide](../README.md). Presenter scripts are not
required to install or manage any of these examples.

SharePoint and Office documentation checked November 15, 2026; original
platform research checked November 13, 2026. Runtime availability depends on the
organization's settings, agent engine, app version, region, license and rollout.
This table describes available routes. The [lab results](lab-status.md)
separately identify which deployments and tests were completed.

| Where it is used | What the skill provides | Where to install or manage it | How changes reach users |
| --- | --- | --- | --- |
| Copilot Chat | Reusable workflows selected in general chat; skills are generally available | Personal upload: Copilot > Agents > More agents > Add > Upload skill. Organization plugin: Microsoft 365 admin center > Agents > Tools > Registry | Update the personal skill or distribute an updated plugin package. The WIQD packaging tool is still preview/alpha. |
| Declarative agent | A skill bundled inside a dedicated Copilot assistant | Agent Builder > Configure > Skills, or the registered skill directory in an Agents Toolkit project | Rebuild and publish the containing agent. Editing another agent's copy does not update this one. |
| Cowork | Reusable instructions for Cowork tasks | Personal skills: Cowork > Customize > Skills. Organization plugins: Microsoft 365 admin center > Agents > Tools > Registry | Owner-shared changes require re-sharing. Users can turn off admin-installed plugins for their conversations. |
| SharePoint site skills | A review workflow available on the associated site | Open the SharePoint site > Settings > Site skills > select the skill > Overview or Versions | Edit/replace the skill or restore a previous version. Copying it to another site does not keep the copies synchronized. |
| SharePoint personal skills | The owner's preferred workflow across authorized sites | Create/save a personal skill in Copilot in SharePoint; follow Open skill location on its card or the source link on Used personal skill to OneDrive | The owner manages the saved skill file. This does not assign it to every site visitor or everyone in the organization. |
| Word web | [Skills attached to a declarative agent; Word supplies open-document text/selection](../platforms/word/README.md) | Agent Builder > Configure > Skills > Add (skill ZIP), or Toolkit > Add Skill (source directory) | Repackage/republish the agent. No Word-specific OneDrive installation folder established by reviewed docs. This Word agent is not yet deployed; in-place text/style editing still requires verification. |
| Excel | Workbook-editing custom skills | Excel > Copilot pane > Settings and more > Manage plugins > Custom skills: create/open Skills OneDrive folder, upload the skill folder, select Refresh and turn on its toggle | Edit/replace the OneDrive source, then select Refresh. The automatic-use toggle does not block explicit mentions. |
| PowerPoint | Presentation-editing custom skills | PowerPoint > Copilot pane > Settings and more > Manage plugins > Custom skills: add the skill by upload/form or app-specific OneDrive folder, then refresh and enable it | Refresh changes; disabled skills disappear from the documented dropdown. |
| Copilot Studio agent using the Microsoft Copilot engine (UI label: harness) | A Markdown file or ZIP uploaded into an agent | Copilot Studio > select environment > Agents > select agent > Build > Skills; publish and share the agent separately | Authors accept updates to imported copies, then republish their agents. Sharing a skill with authors is preview functionality. General plugin support is unavailable. |
| Foundry | Numbered skill versions stored in a project; preview | VS Code > Microsoft Foundry Toolkit > Tools > Skills, or the project Skills API | Upload a new fixed-content version. Update the agent's selected version too; changing the skill's default does not update an existing agent. |
| Agent Framework / compatible remote-skill clients | Skill content read from a Foundry toolbox; preview | Connect the application to the toolbox's authenticated MCP endpoint over HTTPS, using MCP Resources and skills discovery (`resources/list`, `resources/read`) | Choose the toolbox/skill versions the application should use. This route is documented, not runtime-tested in this lab. See the [connection guide](../platforms/foundry-api-center/README.md). |
| GitHub Copilot | Skills in a code repository or an installed plugin | Repository: .github/skills/skill-name/SKILL.md. Enterprise plugin policy: designated .github-private repository > copilot/managed-settings.json | Update repository files or the approved plugin version/policy. Supported behavior varies by client; this lab lacks Copilot entitlement. |
| API Center | A searchable catalog entry linking to the skill's source | Azure portal > API Centers > select resource > Inventory > Assets > select skill; Git synchronization is under Platforms > Integrations | Update the entry or its Git source. This changes discovery information, not installed copies or their runtime permissions. |

## Technical authoring rules used by this repository

The examples use a deliberately small common file format. These are build
checks for authors, not user installation instructions.

- `name` and `description`, plain single-line YAML scalar values.
- Matching lowercase-hyphen directory name; no consecutive hyphens.
- Name <=64 characters; description <=1024 characters.
- Instructions <20000 characters.
- UTF-8 without BOM, no scripts, external tools or custom metadata.
- A skill ZIP has `SKILL.md` at its root. A Microsoft 365 app ZIP has its own
  manifest and layout; these are not interchangeable.

The validator also checks referenced Markdown links, safe resource paths,
companion sizes/count, and shallow directory structure. It is an intentionally
conservative repository policy, not a complete validator for every host's
supported skill features.

## Important non-equivalences

- MCP `tools/list` support != MCP Resources/remote skill discovery support.
- API Center inventory access != permission to invoke a Foundry endpoint.
- Upload != publish != share != install != available to a user != invoked.
- Default skill version != version bound into an existing consumer.
- Skill marketplace removal != removal of snapshots already embedded in agents.
- SharePoint site skill != SharePoint agent or Microsoft 365 plugin.
- SharePoint personal skill portability != permission to read another site.
- An app's personal OneDrive skill folder != a universal Office deployment or
  tenant-wide audience assignment.
- Skill enablement/disablement semantics vary by host; do not reuse one
  platform's behavior as evidence for another.
- Passing local static validation != passing tenant-side validation or a live test.

See [sources](sources.md) for product-specific limits. Do not copy
declarative-agent limits onto standalone Chat uploads or Cowork personal uploads.
