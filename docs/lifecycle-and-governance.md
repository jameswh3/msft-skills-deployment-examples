# Creation, deployment and management lifecycle

## Identify who owns the change

- **End user:** selects installed skills, reviews results and manages the
  app's personal-use settings.
- **Skill/agent author:** maintains instructions and builds/publishes updates.
- **Site or personal owner:** maintains the SharePoint/OneDrive copy they own.
- **Organization or project administrator:** controls permitted users,
  installation, project roles and relevant service policies.

One person can hold several roles, but using a skill does not require the
ability to edit it or install it for everyone.

## Common rollout

The deployment steps differ by product; use its [platform guide](../README.md#approaches)
for the actual menus and commands. The common decisions are:

1. Assign an owner and review the source instructions and fictional test input.
2. If the product requires a package, build it and check the actual ZIP.
   Record its version and file hash (a fingerprint for identifying the bytes).
3. Check permissions and confirm you are signed in to the intended organization
   and project, not production by mistake.
4. Install or register the skill using the product's instructions, after
   confirming you have permission to do so.
5. If the product supports central assignment, start with a small test group
   and verify using a recipient's account, not only the author's.
   Personal skills require each user to complete their own setup instead.
6. Confirm the installed skill was used and compare the result with the
   expected-behavior checklist, called the rubric.
7. Expand access to the authorized audience.
8. For an update, keep the old package, test the new one, then update each
   installed package or agent that uses it. Test a new conversation.
9. To roll back, restore the reviewed previous content **and configure agents
   to use that version**. Restoring a registry default alone may not do that.
10. To withdraw a skill, use the product's block/uninstall/access controls.
    Find remaining copied instructions before deleting the original listing.

## Version and evidence record

Maintain a deployment record with the following information:

| Field | Purpose |
| --- | --- |
| Source commit and skill hash | Which instructions were reviewed; the commit identifies a saved Git revision |
| ZIP hash and package/app version | What was actually shipped |
| Skill's stored version/default | Which version the registry offers for a new reference |
| Version selected by each agent/package | What the existing assistant actually uses |
| Assigned users and groups | Who can access it |
| Service, agent engine and app version | Which experience was tested |
| Observed invocation and output | Proof beyond package validation |
| Previous package and agent version selection | How to restore reviewed behavior |
| Block/uninstall verification | Whether fresh sessions can still invoke it |

## Withdrawing access, by product

- Microsoft 365/Cowork: open **Microsoft 365 admin center > Agents > Tools >
  Registry > select the plugin**, then use its block/uninstall controls and
  review **Users**. Test a fresh conversation; in-progress sessions can
  have different behavior.
- Declarative-agent skills: remove the skill from each consuming agent's
  registered skill set and republish the affected packages. Each bundled
  copy must be updated separately.
- Studio: open **Build > Skills > select the skill > Share** to change which
  authors can reuse it. This does not remove copies already saved in other
  agents; remove the skill from affected agents and republish them as needed.
- Foundry: update the version selected in each agent's definition; changing
  only the skill's default does not alter existing prompt-agent versions.
- GitHub: enterprise block policy and repository file removal are separate.
- SharePoint site skills: open the site's **Settings > Site skills > select
  the skill** and disable it. Review copies on other sites separately.
- Excel/PowerPoint personal skills: the owner's **Copilot pane > Settings
  and more > Manage plugins > Custom skills** contains the per-skill toggle.
  Excel's automatic-use setting is not a revocation control for explicit
  mentions. Do not equate personal settings with organization assignment.
- API Center: hiding/removing a catalog entry does not revoke runtime access
  or delete instructions installed elsewhere.

Describing allowed tools in a catalog does not grant or enforce access.
Actual accounts, permissions, tool settings and organization policies still
control what can run.
