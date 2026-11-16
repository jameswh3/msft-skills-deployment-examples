# GitHub Copilot

GitHub Copilot can use skill instructions from a code repository or an
installed plugin in supported clients. This guide shows both installation
methods using the `meeting-notes` example.

## Where to manage it

- **One code repository:** maintain
  `.github/skills/meeting-notes/SKILL.md` in that repository. Changes are
  reviewed and delivered through its normal Git workflow.
- **Organization-wide plugin policy:** enterprise administrators maintain
  `copilot/managed-settings.json` in the enterprise's designated
  `.github-private` repository. That is a private Git policy repository,
  not a Microsoft 365 admin center page.
- A **marketplace** here is a listing that tells a supported coding client
  where to find installable plugins; it is not the skill's runtime.

## Use an installed skill

1. Open the intended code repository in a supported Copilot client, using
   an account with Copilot access.
2. Use its skills picker/slash menu where offered, or explicitly request the
   skill by name. For the sample, ask for `meeting-notes` and supply notes.
3. Review the response and the client's skill-load activity, when available.
   The workflow should preserve missing owners/dates rather than invent them.

If it is missing, choose a repository or plugin installation route below.
Having access to a GitHub repository does not itself provide Copilot licensing.

## Repository-scoped skill

Inspect the source before installation. With GitHub CLI 2.90.0+ (`gh skill`
is public preview):

```powershell
gh skill preview jameswh3/msft-skills-deployment-examples meeting-notes
gh skill install jameswh3/msft-skills-deployment-examples meeting-notes
```

By default, installation applies to the current project. To distribute a
reviewed release, select a specific release tag or commit hash with the
documented `@VERSION` or `--pin` option, not both.
Alternatively, extract the generated repository ZIP into an explicitly chosen
test repository; it contains `.github/skills/meeting-notes/SKILL.md`.

Do not install into personal skill locations as a side effect of building.

## Plugin marketplace

The root [plugin manifest](../../plugin.json) points to the shared `skills`
directory. The [marketplace listing](../../.claude-plugin/marketplace.json)
tells clients where to find that plugin; it does not contain a second
authored copy of the skill.

For an authorized user's Copilot CLI:

```powershell
copilot plugin marketplace add jameswh3/msft-skills-deployment-examples
copilot plugin install meeting-notes@oge-skills
```

This installs trusted agent instructions. Review the content first. VS Code
also documents marketplace/source installation for supported agent engines.
`oge-skills` is the marketplace identifier inside the manifest; it is not the
GitHub repository name and was not changed by the repository rename.

## Enterprise central deployment

1. Designate an enterprise governance `.github-private` repository.
2. Review [the example managed settings](enterprise-policy/managed-settings.json).
   Copy them to `copilot/managed-settings.json` in that designated repository,
   not this examples repository.
3. Keep the marketplace name `oge-skills` consistent with the actual manifest.
4. `extraKnownMarketplaces` supplies discovery; `enabledPlugins` requires the
   sample plugin. The example disables marketplace auto-update for deliberate
   review. Choose your update policy explicitly.
5. To restrict all marketplace sources, add the documented
   `strictKnownMarketplaces` policy deliberately; it also disables built-in
   marketplaces. It is not enabled by this example.
6. Use supported enterprise-team overrides for a pilot if needed. Grant
   marketplace repository read access for private distribution.
7. Check enterprise settings validation, then verify policy refresh and
   invocation in a supported client.

Managed requirements override repository defaults and local preferences.
Coverage varies: the current `enabledPlugins` matrix supports CLI, VS Code,
Copilot app, GitHub Actions cloud execution, and JetBrains, but not cloud
sandbox execution. Check current minimum client versions before rollout.

## Update and rollback

- For standalone skills, record the source repository and selected release
  tag or commit hash. Use `gh skill update` to update the installed skill.
- Refreshing a marketplace listing and updating an installed plugin are
  separate operations. Preserve
  reviewed previous content, publish corrected/previous content under a valid
  next version when necessary, and verify actual installed versions.
- Block the plugin through enterprise policy, then test a fresh session.
  Remove repository-scoped copies separately; blocking a plugin is not proof
  that an independently copied skill was removed.
- Plugin invocation metrics are not installation or exact adoption counts.

## Troubleshooting

- **Repository is accessible but Copilot is unavailable:** check the account's
  Copilot entitlement and the client's supported version.
- **Skill does not appear:** confirm the installation scope, actual skill
  folder/package and the repository opened in the client.
- **Enterprise policy seems ignored:** check the designated governance
  repository, policy validation and client refresh/minimum-version support.
- **Old instructions still run:** distinguish a repository copy from an
  installed plugin and update the copy the client is actually using.

For deployment and runtime test evidence, see the separate
[verification record](../../docs/lab-status.md).

Sources: [Native skills](https://docs.github.com/en/copilot/how-tos/copilot-on-github/customize-copilot/customize-cloud-agent/add-skills),
[enterprise plugin management](https://docs.github.com/en/copilot/how-tos/administer-copilot/manage-for-enterprise/use-managed-settings/manage-plugin-marketplaces-and-plugins),
[client coverage](https://docs.github.com/en/copilot/reference/enterprise-administrators/enterprise-managed-settings),
[plugin format](https://code.visualstudio.com/docs/agents/reference/agent-plugin-reference).
