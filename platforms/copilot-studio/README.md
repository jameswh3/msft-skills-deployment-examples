# Copilot Studio

Copilot Studio is the web application where an author builds and publishes
an agent for other people to use. For this example, choose an agent powered
by the **Microsoft Copilot harness**: "harness" is the product's label for the
engine that runs the agent. Other agent types have different skill features.

To manage this example, open **Copilot Studio > select the environment >
Agents > select the agent > Build > Skills > meeting-notes**. An environment
is the workspace containing the agent. Use **Share** on the agent to manage
who can use it; sharing the skill itself with other authors is separate.

## Use a skill through the published agent

1. Open the published agent in the channel your organization provides, such
   as Teams or Microsoft 365 Copilot. Users do not upload its skill file or
   visit Copilot Studio just to use it.
2. Give the task and input. For this example, ask it to use `meeting-notes`
   and supply the meeting notes.
3. Review its summary, decisions, action items and open questions. If shown,
   **Used skill: meeting-notes** identifies which skill supplied instructions.

Ask the agent owner for access if it is missing. Access to the published
agent is separate from permission to edit it or reuse its skill as an author.

## Requirements

Authors need access to the intended Copilot Studio environment and permission
to create/publish the agent. Users need access to its published channel.
Channel/data policies, authentication, licensing, and Copilot Credits apply.

## Create and deploy as an author

1. Select the intended development/test environment.
2. Create a dedicated agent using the Microsoft Copilot harness.
3. **Build > Skills > Upload a skill**: upload the reviewed `SKILL.md` or the
   standalone ZIP produced by `npm run build`. In that ZIP, `SKILL.md` must
   be at the top level, not inside another folder.
4. Set agent instructions to use the meeting-notes skill for supplied notes
   and return drafts only.
5. Preview with the shared input and edge-case rubric; inspect skill use.
6. Publish the agent to an allowed channel. Share it with the pilot audience
   or submit to the organization catalog.
7. Test the published experience as an intended recipient, not just as maker.

## Central skill sharing (preview)

From a skill's details, Share > Only you or Specific users/groups. Makers can
browse marketplace skills shared by administrators or owners and add them to
agents. Each agent receives a **snapshot**: its own saved copy at that point
in time, with a link back to the original.

Changes require re-sharing. Makers receive an update notification and choose
to update their snapshot; then republish the consuming agent. This is not
automatic live synchronization.

## Update and revoke

- Replace/edit the uploaded skill, Preview, and republish.
- For an imported skill, open its details > More options > **Replace**, select
  the reviewed source/package, and save the agent before testing. The lab
  verified this workflow with revision 0.1.1.
- Keep the previous source/package for rollback; replace with that reviewed
  content, republish, and test.
- Stop sharing the skill with other authors when appropriate. Remove it
  from each agent that should no longer use it, republish those agents and
  test them. Removing the shared listing does not remove their saved copies.
- Delete a skill only after saving a recoverable copy.

## Manage access as an owner or administrator

- **Use the agent:** open the agent's **Share** panel and grant the intended
  users use access; publish it to the allowed channel.
- **Edit the agent:** grant author/coauthor access only to people who should
  change its configuration, not everyone who needs to use it.
- **Reuse the skill in another agent:** open **Build > Skills > select the
  skill > Share** and choose the intended author audience. **Only you**
  does not publish an organization-wide skill library.

## Troubleshooting

| Problem | What to check |
| --- | --- |
| Works in Preview, not for users | Publish the current agent, check the channel where users open it and who has permission to use it, and test with a recipient account. |
| A shared skill changed but the agent did not | Accept the skill update in the consuming agent and republish it. Each agent has its own saved copy. |
| A user cannot edit the skill | Permission to use the published agent does not grant permission to edit its skills; ask the owner to review the user's authoring permissions. |
| Markdown skill upload is unavailable | Check that the agent uses the Microsoft Copilot harness; other agent types have different skill features. |

**Automation boundary:** general plugin support in Copilot Studio is not yet
available. Its standard-harness solution/application lifecycle management
(ALM) documentation does not establish
an API for this harness's skill deployment. This example deliberately uses
the documented maker/administrator workflow instead of inventing an endpoint.

For completed tests and limitations, see [lab results](../../docs/lab-status.md).

Sources: [Upload](https://learn.microsoft.com/microsoft-copilot-studio/agents-experience/skills-add-existing),
[sharing and updates](https://learn.microsoft.com/microsoft-copilot-studio/agents-experience/skills-manage),
[publishing](https://learn.microsoft.com/microsoft-copilot-studio/agents-experience/publication-publish-agent).
