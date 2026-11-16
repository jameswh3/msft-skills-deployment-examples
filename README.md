# Skills across Microsoft and GitHub: user and administrator guide

Examples of creating, installing, using and updating skills in Microsoft
and GitHub products. The repository includes a shared meeting-notes skill
and additional examples for tasks in SharePoint, Word, Excel and PowerPoint.

Learn how reusable skill instructions reach users, where they are stored,
who can manage them, and how updates work in each product. The examples can
be used in your own organization; access to the repository author's lab is
not required.

## Start here

- **I want to use a skill:** start with [using skills](#using-skills), then
  choose your product below. You do not need developer tools just to use an
  installed skill.
- **I manage skills for other people:** start with [administration and
  ownership](#administration-and-ownership) and the [deployment
  comparison](docs/support-matrix.md).
- **I want to create or install the example:** follow the relevant product
  guide. Use the developer quickstart only when that guide requires a package.

### The terms used here

- A **skill** is reusable task instructions in a file named `SKILL.md`, with
  optional supporting files. It does not grant data access.
- An **agent** is the assistant a user opens. A **declarative agent** is a
  Copilot assistant configured with instructions and capabilities, rather
  than a separately hosted application.
- A **plugin** is an installable package that can contain skills and other
  capabilities. In Microsoft 365, administrators can assign that package to
  users or groups.
- A **tenant** is your organization's instance of Microsoft 365, with its own
  users, data and administration settings.
  An **environment** in Copilot Studio or a **project** in Foundry identifies
  the workspace where its builders manage the example.
- **Deploy** means put the skill/package into the service and make it
  available to the intended users. Writing the file or building a ZIP alone
  does not deploy it.
- A **harness** is the engine that runs an agent. The guides retain this term
  when it is part of an exact Microsoft product option.
- **MCP** (Model Context Protocol) is a connection protocol an application can
  use to discover and retrieve capabilities from a server. Skill retrieval
  requires the specific support described in the central management guide.

The [meeting-notes skill](skills/meeting-notes/SKILL.md) turns supplied synthetic
notes into a summary, decisions, action items, and unresolved questions. It has
no scripts, credentials, connectors, network calls, or external actions.

## Approaches

Choose the product where people will use the skill. Copilot Studio and
Foundry are builder services: their users usually interact with a published
agent or application, rather than with the builder's management screen.

The table separates each product's skill capability from where users or
agents run the skills and where their instructions are managed.

| Skill capability | Where the skill is used | How it gets there and who manages it | Guide |
| --- | --- | --- | --- |
| Copilot Chat skills | Microsoft 365 Copilot Chat | A user uploads a personal skill, or an administrator assigns a plugin containing it through Microsoft 365 admin center > Agents > Tools > Registry | [Microsoft 365](platforms/microsoft-365/README.md) |
| Declarative-agent skills | A dedicated declarative agent opened in Microsoft 365 Copilot | The author adds the skill through Agent Builder > Configure > Skills or Agents Toolkit > Add Skill; skill changes require republishing the containing agent | [Declarative agent](platforms/microsoft-365/declarative-agent/README.md) |
| Cowork skills | Copilot Cowork conversations and tasks | An administrator installs a plugin containing the skill through Microsoft 365 admin center > Agents > Tools > Registry; users enable it in Cowork > Customize > Plugins | [Cowork](platforms/microsoft-365/plugin/README.md) |
| SharePoint site skills | Copilot chat on the associated SharePoint site, for users with the required site/content permissions | A site owner creates the skill in Copilot in SharePoint and manages it from that site's Settings > Site skills | [SharePoint](platforms/sharepoint/README.md) |
| SharePoint personal skills | Copilot in SharePoint, for an individual user across supported sites they can access | The user saves reusable instructions for their own use in Copilot in SharePoint; Open skill location on the saved card opens the source file in that user's OneDrive | [SharePoint](platforms/sharepoint/README.md) |
| Plugin-provided skills in Word | Word desktop's Copilot pane > @ > Plugins > the skill beneath its plugin | An administrator assigns/installs the plugin through Microsoft 365 admin center > Agents > Tools > Registry, or its author shares it through the plugin sharing workflow; users select its skill in Word | [Word](platforms/word/README.md) |
| Excel custom skills | Copilot in Excel, with the workbook open | Put the skill folder in the user's Excel-specific OneDrive folder, then use Copilot pane > Settings and more > Manage plugins > Custom skills > Refresh and turn on the skill | [Excel](platforms/excel/README.md) |
| PowerPoint custom skills | Copilot in PowerPoint, with the presentation open | The user adds a skill through the Copilot pane's Manage skills/Manage plugins menu, by upload, form or its PowerPoint-specific OneDrive folder | [PowerPoint](platforms/powerpoint/README.md) |
| Copilot Studio skills | An agent published from Copilot Studio to Teams or Microsoft 365 Copilot | The agent's author opens Build > Skills to upload instructions, then publishes and grants access to the agent; sharing skills with other authors is separate | [Studio](platforms/copilot-studio/README.md) |
| Foundry skills (preview) | A Foundry agent, used through an application or API | A project owner uploads numbered skill versions through the Skills API or Foundry Toolkit, then configures which version an agent uses | [Foundry](platforms/foundry/README.md) |
| GitHub Copilot agent skills | GitHub Copilot in supported editors and coding tools | Add skill files to the code repository, or distribute a plugin through enterprise policy stored in the administrator-designated .github-private repository | [GitHub](platforms/github-copilot/README.md) |
| Foundry skills + API Center catalog | Foundry prompt agents using the Microsoft Copilot engine; Microsoft Agent Framework agents and other clients supporting MCP Resources and skills discovery | Store skill versions in Foundry and list them in API Center. Foundry prompt agents load a selected version directly; remote clients retrieve skills through a Foundry toolbox's MCP endpoint (preview). API Center provides discovery, not execution | [Central skill management](platforms/foundry-api-center/README.md) |

The same `SKILL.md` instructions can be reused across products, but the
installation steps, permissions, ways to select a skill and update behavior
differ. The tasks described in these examples are not the only tasks skills
can perform. See the [support matrix](docs/support-matrix.md).

## Using skills

1. Sign in to the product with the account that has access to the skill.
   Skills do not grant access to documents you cannot already open.
2. Select the skill/plugin, or open the agent containing it, using that
   product's guide above. For example, an Excel skill is selected inside
   Excel's Copilot pane; a Studio skill is used through its published agent.
3. Give the task and relevant input. For `meeting-notes`, supply meeting notes
   and ask for the summary, decisions, action items and open questions.
   You do not need to paste the skill's full instructions on every request.
4. Review the response and any proposed file changes. Confirm owners, dates
   and decisions against the source before applying or sharing the result.
5. If the skill is missing, check the signed-in account, whether its package
   was installed/shared with you, and whether it is enabled in that app.
   Product-specific troubleshooting is included in each guide.

Automatic selection is different from explicitly selecting a skill. Turning
automatic use off is not necessarily a permission or security control; Excel,
for example, documents that explicit mentions can still invoke the skill.

## Administration and ownership

First determine what you are managing:

- **A Microsoft 365 skill plugin:** an administrator manages the plugin
  package under **Microsoft 365 admin center > Agents > Tools > Registry**.
  Making it available and installing it for users are separate actions.
- **A skill bundled in a declarative agent:** the author maintains it in
  **Agent Builder > Configure > Skills** or the registered skill directory
  in an Agents Toolkit project, then republishes the containing agent.
- **A site skill:** the SharePoint site owner manages the skill on that site.
  Copying it to another site does not keep the copies synchronized.
- **A personal skill:** the individual user manages their saved instructions
  and the skill's settings in the app.
  Distributing a file is not the same as installing it for all employees.
- **A skill in Copilot Studio or Foundry:** the Studio agent author or Foundry
  project owner chooses the instructions or version their agent uses and
  publishes updates.
- **A catalog entry:** API Center lists a skill's description, source link
  and supported products. Adding or removing that entry does not install or
  remove the skill in another product.

For rollout, review the instructions, select a small initial audience, verify
access as a recipient, then expand access if appropriate. For updates,
identify every installed copy or agent version that needs changing. Follow
the [management lifecycle](docs/lifecycle-and-governance.md) and each product's
update/removal instructions.

## Developer quickstart: build packages locally

Prerequisites: Node.js/npm and PowerShell 7. Node 24.15.0 is restored as a
workspace-only tool; no global Node version switch is necessary.

```powershell
npm ci
npm run validate
npm test
npm run build
npm run build:hosts
npm run build:fixtures
```

The initial restore under an older Node may print WIQD's Node engine warning.
WIQD scripts use the pinned workspace Node 24 executable, not the global
runtime or the npm PowerShell shim. For CI, use Node 24.15.0 from the outset.

Build output in `out`:

- `skill-0.1.1.zip`: root `SKILL.md`, for standalone skill upload.
- `github-repository-0.1.1.zip`: `.github/skills/meeting-notes/SKILL.md`.
- `github-marketplace-0.1.1.zip`: a plugin and marketplace with the skill.
- `artifacts.json`: source/content hashes and package hashes.
- `host-examples/<platform>/<skill-name>/`: standalone and matching-name
  folder archives for the host-specific examples, with source/version/hash
  records identifying what each archive contains.
- `host-fixtures/OGE-Pipeline-Skill-Demo.xlsx`: an editable synthetic Excel
  table built from the checked-in CSV, preserving its deliberate data issues.

The default build still packages only the original meeting-notes skill.
Host-specific examples are separate from the root GitHub plugin's skill
directory; adding one does not silently update previously deployed plugins.

These are not Microsoft 365 app packages. Generate official Microsoft 365
projects with the [scaffold script](scripts/New-Microsoft365Examples.ps1).
Provisioning, tenant-side package validation, publication, and sharing are
separate authenticated actions.

## Check that an installation works

Use the [synthetic notes](samples/meeting-notes/input.md),
[rubric](samples/meeting-notes/expected-behavior.md), and
[edge cases](samples/meeting-notes/edge-cases.md).
Record discovery, actual invocation, output, audience, and version using the
[verification guide](docs/verification.md). A successful build is not a
successful deployment or an invocation test.

## Management and safety

- [Lifecycle and governance](docs/lifecycle-and-governance.md)
- [Official sources and preview/toolchain caveats](docs/sources.md)

No CI job provisions resources, changes enterprise policy, or deploys to a
tenant. Keep real tenant/subscription IDs, environment files, authentication
state, and detailed lab records outside this public repository.

## Optional supporting material

- [Presenter script](docs/demo-script.md): an optional tour of the retained
  lab examples. It is not the installation or administration guide.

## Contributing

Change the canonical skill once, then rebuild and test. Do not edit generated
copies. Use pull requests for changes to instructions, packaging, or policy
examples. Do not contribute meeting transcripts, secrets, or customer data.
