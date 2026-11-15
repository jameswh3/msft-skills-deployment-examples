# Lab verification status

This is a sanitized ledger, not proof inferred from documentation.
Detailed tenant identifiers and deployment records belong outside this public
repository.

| Component | Current evidence | Remaining check |
| --- | --- | --- |
| Canonical skill | Local metadata/encoding tests pass | Behavior per target host |
| Standalone/GitHub archives | Root structure and actual content hashes pass | Install in intended host |
| Microsoft 365 plugin | Shared revision 0.1.1 pilot passed Chat baseline with **Using skills from** trace; owner-shared publication approved; separately identified managed ZIP passed 59 host rules and archived canonical-byte parity, uploaded successfully, and has saved All users availability and automatic installation | Isolated managed-source invocation in Cowork; see attribution limitation below |
| Copilot Cowork | Managed package appeared in Added without manual installation, is labeled **Managed by your organization**, and was enabled for the pilot user; baseline and ambiguity/conflict/injection runs passed with **Reviewed custom skill** trace | Trace identifies the duplicate shared pilot, not the managed package; do not claim isolated managed-package runtime verification |
| Declarative agent | Agent schema v1.9; app passed 61 host rules; revision 0.1.1 package content verified; pilot baseline passed with **Using skills from** trace; tenant request approved and publication/preinstallation to All users completed; separate Available tenant-registry entry verified | Edge cases and excluded-user control not exercised |
| Copilot Studio | Revision 0.1.1 replaced/saved; Preview baseline and ambiguity/conflict/injection checks passed with explicit **Used skill: meeting-notes** trace; authenticated Teams + Microsoft 365 channel published and installed; published-channel baseline passed with the same trace; organization-wide use access confirmed in sharing and admin registry | Other-recipient shared-skill snapshot/update acceptance and destructive revocation not exercised |
| Foundry | Immutable versions 1-3 created; skill load observed in synthetic runs; default promotion/rollback and explicit consumer rebinding tested; refined revision 0.1.1 passed baseline and ambiguity/conflict/injection checks and was promoted/exported | Destructive revocation/removal deliberately not exercised on retained demo resources |
| API Center | **Free** native registration and public Git integration verified; **Linked and syncing** discovered a separate `kind: skill` Testing asset with `apiSourceId` and explicit `**/SKILL.md` pattern; catalog-source retrieval and reviewed metadata/instruction-body parity with the deployed source/export verified | No universal remote loading or hosted execution adapter claimed; raw artifact hashes differ as documented in the platform guide |
| GitHub repository | Source pushed to public main; Windows CI validation, tests and packaging passed; contributor Write invitation sent | Invitation acceptance |
| GitHub Copilot runtime | **Unavailable: no Copilot entitlement in this lab** | Must be tested in another entitled environment |
| SharePoint site skill | Dedicated synthetic-content site and native site skill created; revised canonical file replaced in the product-created Agent Assets library with exact saved-byte SHA-256 verified; fresh **Used site skill sharepoint-site-review** trace observed, with four output sections and all five checklist rows, missing owner and conflicting 20/30 target | Dedicated Site skills management page and additional edge cases not yet exercised |
| SharePoint personal skill | Documented site-home Copilot creation, reviewed definition and explicit personal-save confirmation succeeded; native **Skill created / Your skill** card and actual OneDrive source verified. Fresh chat showed **Used personal skill sharepoint-personal-brief**, three takeaways, a four-row Fact/Evidence/Caveat table, and three grounded open questions | Generated source is not byte-identical to the canonical package; see source-review note below. Cross-site portability and lifecycle changes not exercised |
| Word workflow | Source and archives validate; Word web displays existing shared/managed packages. Documentation review establishes a route through a declarative agent containing the skill, authored with Agent Builder or Agents Toolkit and distributed as an agent | **Word agent packaging, deployment and invocation not performed.** In-place text/style edits remain unverified. Word-native creation returned only an unsaved draft; no Word OneDrive installation folder or Chat-upload handoff is established. See the [Word deployment guide](../platforms/word/README.md) |
| Excel pipeline review | Native app-specific OneDrive folder created; 1576-byte canonical source uploaded with exact SHA-256 parity, listed/refreshed/enabled in Custom skills and selected through the native picker; changes accepted and saved workbook independently decoded: source records preserved, eight findings in A11:D18, total B21=35000 and included count B22=6 | Initial chat miscounted affected source rows as six; saved findings cover all seven. Read-back corrected the count in prose but retained six in its chat table. No separate source-mount trace exposed in the inspected UI |
| PowerPoint workflow | Canonical 1204-byte source saved in the discovered native app-specific OneDrive folder with exact SHA-256 parity; listed and enabled in Custom skills, selected through the native picker, and invoked with a short task request. Saved deck independently decoded: Executive summary first, original three source slides intact, five summary bullets of 10/12/12/11/14 words, common native title-and-content layout, preserved date and 20/30 conflict | No separate source-load trace observed; native selection, saved source and deck output are verified. Suggested next step was explicitly identified as an inference in chat, not a source decision |

No platform is labeled runtime-verified until its actual installed skill has
been observed and the synthetic output checked. An initial deployment does
not imply update, rollback, revocation, or all-user assignment tests passed.

The new SharePoint examples leave access and available actions to the host,
rather than imposing blanket search/edit/action bans. The site-skill evidence
above is from a fresh run after that revision, not the earlier restricted
draft. Personal-skill storage in OneDrive is not a separate content sandbox.

The earlier SharePoint personal creation attempt in library chat returned
only a draft and refused saving. A later fresh site-home chat succeeded
through the documented creation and confirmation flow; the earlier refusal
is not treated as a permanent product limitation. The generated source was
downloaded and reviewed: 1600 bytes, SHA-256
`da59893c34fb92b19730d79020f9d979f8f5b75c4197874ad0f4ff67e7a59485`.
Its section formatting and expanded trigger description differ from the
canonical source, but the reviewed workflow and output criteria are retained,
without additional search/edit/action bans. The runtime skill indicator linked
to the owner's actual OneDrive skill folder. Native creation, saved source,
and fresh invocation are separate observed checks.

The PowerPoint folder upload initially failed and left an empty folder.
The canonical file was subsequently added to that same discovered folder
using Microsoft's documented SharePoint file-upload REST API with overwrite
disabled, then downloaded and hashed. This is the documented OneDrive-copy
installation route, not a new cross-host skill mechanism. A fresh browser
tab recovered the expired PowerPoint session. The unrelated existing custom
skill remains off; only this example is enabled.

For pilot publisher metadata and synthetic-data handling, see [demo use](demo-use.md).

The Studio agent has no configured external tools or knowledge/search sources,
and memory is off. Its native skill was separately published to the maker's
**Only you** library and is discoverable in Cowork. That pilot-library access
is distinct from the consuming agent's organization-wide **use** access.
Manual fixture checks are not a formal Studio evaluation run.

## Cowork source-attribution limitation

The shared pilot and the managed deployment intentionally contain the same
`meeting-notes` name and instructions. Cowork's runtime trace and skill-details
page identified **OGE Meeting Notes Skilldev**, even when the prompt named
the managed package. The shared pilot's enable switch was off when inspected;
the managed package's switch was on. These observations do not establish
which package's bytes were mounted, nor that disabling a plugin revokes every
other copy of its skill.

The observed output passed the portable skill rubric, and managed installation
was independently verified. An isolated managed-source runtime check remains:
use a clean entitled test user with only the managed demonstration installed.
Do not delete the working shared pilot or claim source isolation from matching
output alone.

Revision 0.1.1 strengthens missing-reference-date reporting after a live edge
case exposed insufficient ambiguity handling. These are observed samples, not
proof that model behavior or prompt-injection resistance is deterministic.
