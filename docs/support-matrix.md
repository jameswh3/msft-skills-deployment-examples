# Support and deployment boundaries

Use this comparison to choose how users will receive a skill and who will
maintain it. For task-based instructions, start with the
[user and administrator guide](../README.md).

SharePoint and Office documentation checked November 15, 2026; original
platform research checked November 13, 2026. Runtime availability depends on the
organization's settings, agent engine, app version, region, license and rollout.
This table describes available routes. Use the [verification
guide](verification.md) to test availability and execution in your environment.

| Skill capability | Where the skill is used | What the skill provides | Where to install or manage it | How changes reach users |
| --- | --- | --- | --- | --- |
| Copilot Chat skills | Microsoft 365 Copilot Chat | Reusable task instructions selected in general chat; skills are generally available | Personal upload: Copilot > Agents > More agents > Add > Upload skill. Organization plugin: Microsoft 365 admin center > Agents > Tools > Registry | Update the personal skill or distribute an updated plugin package. The WIQD packaging tool is still preview/alpha. |
| Declarative-agent skills | A dedicated declarative agent in Microsoft 365 Copilot | A skill bundled inside a dedicated Copilot assistant | Agent Builder > Configure > Skills, or the registered skill directory in an Agents Toolkit project | Rebuild and publish the containing agent. Editing another agent's copy does not update this one. |
| Cowork skills | Copilot Cowork conversations and tasks | Reusable instructions for Cowork tasks | Personal skills: Cowork > Customize > Skills. Organization plugins: Microsoft 365 admin center > Agents > Tools > Registry | Owner-shared changes require re-sharing. Users can turn off admin-installed plugins for their conversations. |
| SharePoint site skills | Copilot chat on the associated SharePoint site | Reusable instructions for users with the required site/content permissions | Open the SharePoint site > Settings > Site skills > select the skill > Overview or Versions | Edit/replace the skill or restore a previous version. Copying it to another site does not keep the copies synchronized. |
| SharePoint personal skills | Copilot in SharePoint, across supported sites the individual user can access | Reusable instructions for that individual's own use | Create/save a personal skill in Copilot in SharePoint; follow Open skill location on its card or the source link on Used personal skill to OneDrive | The individual user maintains the saved skill file. This does not assign it to every site visitor or everyone in the organization. |
| Plugin-provided skills in Word | Word desktop's Copilot pane > @ > Plugins > select the skill beneath its plugin | Microsoft 365 plugin skills consumed in Word, not a separate Word-specific format; [Word guide](../platforms/word/README.md) | Centrally deployed: Microsoft 365 admin center > Agents > Tools > Registry. Owner-shared: the author's plugin sharing workflow. Users select the available plugin's skill in Word | Administrators distribute managed-package updates; authors rebuild/re-share owner-shared packages. Personal Chat uploads do not establish Word availability. Picker discovery does not prove invocation, document access or editing. |
| Excel custom skills | Copilot in Excel, with the workbook open | Reusable instructions for workbook tasks; the example checks data and creates a review worksheet | Excel > Copilot pane > Settings and more > Manage plugins > Custom skills: create/open Skills OneDrive folder, upload the skill folder, select Refresh and turn on its toggle | Edit/replace the OneDrive source, then select Refresh. The automatic-use toggle does not block explicit mentions. |
| PowerPoint custom skills | Copilot in PowerPoint, with the presentation open | Reusable instructions for presentation tasks; the example adds an executive-summary slide | PowerPoint > Copilot pane > Settings and more > Manage plugins > Custom skills: add the skill by upload/form or app-specific OneDrive folder, then refresh and enable it | Refresh changes; disabled skills disappear from the documented dropdown. |
| Copilot Studio skills | An agent published from Copilot Studio to Teams or Microsoft 365 Copilot | Reusable task instructions uploaded as Markdown or a ZIP; requires the Microsoft Copilot engine (UI label: harness) | Copilot Studio > select environment > Agents > select agent > Build > Skills; publish and share the agent separately | Authors accept updates to imported copies, then republish their agents. Sharing a skill with authors is preview functionality. General plugin support is unavailable. |
| Foundry skills (preview) | A Foundry agent, used through an application or API | Numbered skill versions stored in a project; preview | VS Code > Microsoft Foundry Toolkit > Tools > Skills, or the project Skills API | Upload a new fixed-content version. Update the agent's selected version too; changing the skill's default does not update an existing agent. |
| Foundry toolbox remote skills (preview) | Microsoft Agent Framework agents or other clients supporting MCP Resources and skills discovery | Skill content read from a Foundry toolbox; preview | Connect the application to the toolbox's authenticated MCP endpoint over HTTPS, using MCP Resources and skills discovery (`resources/list`, `resources/read`) | Choose the toolbox/skill versions the application should use. See the [connection guide](../platforms/foundry-api-center/README.md). |
| GitHub Copilot agent skills | GitHub Copilot in supported editors and coding tools | Skills in a code repository or an installed plugin | Repository: .github/skills/skill-name/SKILL.md. Enterprise plugin policy: designated .github-private repository > copilot/managed-settings.json | Update repository files or the approved plugin version/policy. Users need Copilot access and a supported client version. |
| API Center skill catalog | Not run in API Center; users discover its source and supported products there | A searchable catalog entry linking to the skill's source | Azure portal > API Centers > select resource > Inventory > Assets > select skill; Git synchronization is under Platforms > Integrations | Update the entry or its Git source. This changes discovery information, not installed copies or their runtime permissions. |

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

- A client that can list MCP tools cannot necessarily discover or read skills.
  It also needs MCP Resources and remote skill discovery support.
- Access to the API Center catalog does not grant permission to connect to
  Foundry and load a skill.
- Uploading, publishing, sharing, installing, making available and actually
  using a skill are separate steps. Completing one does not prove the others.
- Changing the default skill version does not update the version already
  selected by an existing agent or application.
- Removing a skill from a marketplace does not remove copies saved in agents.
- A SharePoint site skill is not a SharePoint agent or Microsoft 365 plugin.
- Using a personal skill on another SharePoint site still requires permission
  to read that site's content.
- Installing a skill in one app's personal OneDrive folder does not install
  it in every Office app or for everyone in the organization.
- Turning a skill off has different effects in different products; check
  the product's guide rather than assuming it prevents every use.
- Local file/package checks do not prove the service will accept a package
  or that an installed skill works.

See [sources](sources.md) for product-specific limits. Do not copy
declarative-agent limits onto standalone Chat uploads or Cowork personal uploads.
