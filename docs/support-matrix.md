# Support and deployment boundaries

SharePoint and Office documentation checked November 15, 2026; original
platform research checked November 13, 2026. Runtime availability depends on the
actual tenant, harness, client, region, license and rollout.

| Target | Portable instructions | Central mechanism | Update semantics |
| --- | --- | --- | --- |
| Copilot Chat | Standalone skills GA | Microsoft 365 plugin/skill registry and install/assignment | Package lifecycle; verify installed skills. WIQD tooling is preview/alpha. |
| Declarative agent | Native bundled skill | Agents Toolkit package and organization agent deployment | Repackage the consumer; not a live cross-agent reference. |
| Cowork | Native custom/plugin skills | Microsoft 365 plugin administration | Owner-shared changes require re-sharing; admin-installed packages can still be disabled by users. |
| SharePoint site skills | Native selected-content workflows | Settings > Site skills; site-managed Agent Assets library | Replace/edit and version restoration; copying to sites is not live synchronization. |
| SharePoint personal skills | Native personal workflows | Owner's OneDrive and Copilot in SharePoint creation/management | Owner-specific across authorized sites; not site-wide or tenant-wide assignment. |
| Word web | Existing shared/managed skills visible; creation within Word unsupported by current documentation and observed behavior | New source is a local workflow example only; Word exploration closed after failed native creation | No Chat-upload handoff or alternative deployment inferred; Excel/PowerPoint folders do not install a Word skill. |
| Excel | Native workbook-editing custom skills | Owner's app-specific OneDrive folder and native skill controls | Refresh source changes; automatic-use disablement does not block explicit mentions. |
| PowerPoint | Native presentation-editing custom skills | Personal upload/form or app-specific OneDrive folder | Refresh changes; disabled skills disappear from the documented dropdown. |
| Studio Microsoft Copilot harness | Markdown/ZIP native upload | Agent deployment; marketplace skill sharing in preview | Snapshot acceptance plus agent republishing. General plugin support unavailable. |
| Foundry | Skills API preview | Project-scoped immutable skill versions | Default promotion and consumer-bound versions are distinct. |
| GitHub Copilot | Repository, personal and plugin skills | Repository delivery or enterprise-managed plugin marketplaces | Standalone pinning/provenance versus marketplace update policy; client coverage differs. |
| API Center | Cataloged Skill assets/source links | Registry discovery and optional Git sync | Catalog metadata is not installation, execution, or revocation of copies. |

## Conservative portable subset

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
