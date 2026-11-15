# Copilot Studio

Copilot Studio is the web application where an author builds and publishes
an agent for other people to use. For this example, choose an agent powered
by the **Microsoft Copilot harness**: "harness" is the product's label for the
engine that runs the agent. Other agent types have different skill features.

To manage this example, open **Copilot Studio > select the environment >
Agents > select the agent > Build > Skills > meeting-notes**. An environment
is the workspace containing the agent. Use **Share** on the agent to manage
who can use it; sharing the skill itself with other authors is separate.

## Create and deploy

1. Choose the intended lab environment, not the default or production
   environment accidentally.
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

Channel/data policies, authentication, licensing, and Copilot Credits apply.

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
- Revoke sharing and remove the skill from consumers as appropriate; verify
  actual published agents. Removing a registry listing is not proof that
  every embedded snapshot disappeared.
- Delete a skill only after saving a recoverable copy.

Agent publication, agent use access, and skill-library access are separate
operations. The lab published an authenticated Teams + Microsoft 365 channel,
enabled organization-wide agent **use** access through Share, and separately
published the skill to the maker's **Only you** library. The published channel
showed **Used skill: meeting-notes** and passed the shared baseline fixture.
Do not treat maker-library publication as organization-wide skill assignment.

**Automation boundary:** general plugin support in Copilot Studio is not yet
available. Its standard-harness solution/application lifecycle management
(ALM) documentation does not establish
an API for this harness's skill deployment. This example deliberately uses
the documented maker/administrator workflow instead of inventing an endpoint.

Sources: [Upload](https://learn.microsoft.com/microsoft-copilot-studio/agents-experience/skills-add-existing),
[sharing and updates](https://learn.microsoft.com/microsoft-copilot-studio/agents-experience/skills-manage),
[publishing](https://learn.microsoft.com/microsoft-copilot-studio/agents-experience/publication-publish-agent).
