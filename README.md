# Microsoft ecosystem skill deployment examples

One portable skill, distinct deployment and management examples, plus
host-specific workflows where the scope and user experience differ.

This repository is for people evaluating how to give users reusable Copilot
instructions, whether or not they administer Microsoft services every day.

## Start here

- **Present the examples:** follow the [user and administrator demo
  walkthrough](docs/demo-script.md), which gives the menus to open.
- **Choose a deployment route:** use the table below, then follow that
  product's guide. You do not need to deploy every example.
- **Check what actually worked:** read the [lab results](docs/lab-status.md).
  A documented option is not necessarily a completed lab deployment.
- **Build the files yourself:** use the developer quickstart below. Reading
  the guides or presenting existing deployments does not require these tools.

### The terms used here

- A **skill** is reusable task instructions in a file named `SKILL.md`, with
  optional supporting files. It does not grant data access.
- An **agent** is the assistant a user opens. A **declarative agent** is a
  Copilot assistant configured with instructions and capabilities, rather
  than a separately hosted application.
- A **plugin** is an installable package that can contain skills and other
  capabilities. In Microsoft 365, administrators can assign that package to
  users or groups.
- A **tenant** is your organization's Microsoft 365 service boundary.
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

| Where the skill is used | How it gets there and who manages it | Guide |
| --- | --- | --- |
| Microsoft 365 Copilot Chat: the general chat experience | A user uploads a personal skill, or an administrator assigns a plugin containing it through Microsoft 365 admin center > Agents > Tools > Registry | [Microsoft 365](platforms/microsoft-365/README.md) |
| Microsoft 365 declarative agent: a dedicated assistant | The author includes the skill in the agent package; an administrator manages the agent under Microsoft 365 admin center > Agents > All agents | [Declarative agent](platforms/microsoft-365/declarative-agent/README.md) |
| Copilot Cowork: the task-running experience | Deploy the plugin through Microsoft 365 admin center > Agents > Tools > Registry; users find it in Cowork > Customize > Plugins | [Cowork](platforms/microsoft-365/plugin/README.md) |
| SharePoint site skills: shared instructions on one site | A site owner creates the skill in Copilot in SharePoint and manages it from that site's Settings > Site skills | [SharePoint](platforms/sharepoint/README.md) |
| SharePoint personal skills: the owner's reading workflow | The owner creates/saves a personal skill in Copilot in SharePoint and follows its source link to the saved OneDrive file | [SharePoint](platforms/sharepoint/README.md) |
| Word: a document-focused agent | Attach the skill to a declarative agent through Agent Builder or Agents Toolkit, then distribute the agent. Documented route; this Word example is not yet deployed | [Word](platforms/word/README.md) |
| Excel: review the open workbook | Put the skill folder in the owner's Excel-specific OneDrive folder, then use Copilot pane > Settings and more > Manage plugins > Custom skills > Refresh and turn on the skill | [Excel](platforms/excel/README.md) |
| PowerPoint: edit the open presentation | The owner adds a skill through the app's Manage skills/Manage plugins menu, by upload, form or its PowerPoint-specific OneDrive folder | [PowerPoint](platforms/powerpoint/README.md) |
| Copilot Studio: build an agent for other people to use | The agent's author opens Build > Skills to upload instructions, then publishes and grants access to the agent; sharing skills with other authors is separate | [Studio](platforms/copilot-studio/README.md) |
| Microsoft Foundry: build an AI-backed application | A project owner uploads numbered skill versions through the Skills API or Foundry Toolkit, then configures which version an agent uses | [Foundry](platforms/foundry/README.md) |
| GitHub Copilot: assist developers in a coding client | Add skill files to the working repository, or distribute a plugin through enterprise policy stored in the designated governance repository | [GitHub](platforms/github-copilot/README.md) |
| **Foundry + API Center** | Centrally manage skill versions in Foundry and catalog them in API Center. Foundry Copilot-harness prompt agents consume versioned skill references; Microsoft Agent Framework agents and compatible remote-skill clients consume skills through a Foundry toolbox's MCP endpoint (preview) | [Central skill management](platforms/foundry-api-center/README.md) |

`SKILL.md` content is portable. Installation packages, permissions, invocation,
and update behavior are not universal. See the [support matrix](docs/support-matrix.md).

The host-specific lab extension verifies SharePoint site and personal skills,
Excel's saved review worksheet, and PowerPoint's saved executive-summary deck.
Word has a documented agent-packaging route, but this Word example has not
yet been deployed or tested in Word. See the [evidence ledger](docs/lab-status.md) for exact checks
and limitations; local packaging alone is not runtime verification.

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

## Validate in a host

For a presentation using existing deployments, follow the
[demo script: user and admin experiences](docs/demo-script.md).

Use the [synthetic notes](samples/meeting-notes/input.md),
[rubric](samples/meeting-notes/expected-behavior.md), and
[edge cases](samples/meeting-notes/edge-cases.md).
Record discovery, actual invocation, output, audience, and version using the
[verification guide](docs/verification.md). A successful build is not a
successful deployment or an invocation test.

## Management and safety

- [Lifecycle and governance](docs/lifecycle-and-governance.md)
- [Official sources and preview/toolchain caveats](docs/sources.md)
- [Lab deployment status](docs/lab-status.md)

No CI job provisions resources, changes enterprise policy, or deploys to a
tenant. Keep real tenant/subscription IDs, environment files, authentication
state, and detailed lab records outside this public repository.

## Contributing

Change the canonical skill once, then rebuild and test. Do not edit generated
copies. Use pull requests for changes to instructions, packaging, or policy
examples. Do not contribute meeting transcripts, secrets, or customer data.
