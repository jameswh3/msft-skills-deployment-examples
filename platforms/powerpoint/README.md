# Copilot in PowerPoint: executive story

Skills provide reusable instructions for presentation tasks. This repository's
[powerpoint-executive-story example](../../samples/powerpoint/skills/powerpoint-executive-story/SKILL.md)
adds an executive-summary slide at the beginning and keeps the existing slides.
It uses the presentation access already available to Copilot; it grants no
additional permissions.

## Use an installed skill

1. Open the presentation you want to edit and its Copilot pane.
2. Select **Add sources, skills, and more > Choose plugins >
   powerpoint-executive-story**.
3. Ask for an executive summary for the intended audience.
4. Review and apply the proposed changes, then inspect the saved slides.
   Keep the original detail and check unresolved facts before sharing.

If the skill is missing, use the installation steps below. You need Copilot
available in your account and permission to edit the presentation.

## Add the skill in PowerPoint

Start in the **Copilot pane** (the chat side panel), not PowerPoint's
**File > Options** settings. The verified web client uses **Settings and more >
Manage plugins > Custom skills**. Microsoft's support article calls this
**Manage skills** instead.

PowerPoint documents three personal custom-skill routes:

1. **Choose skills > Manage skills > Add skill**: upload the reviewed
   standalone skill ZIP. Generate this repository's example with
   `npm run build:hosts`; the output is under
   `out/host-examples/powerpoint/powerpoint-executive-story`.
   This is not a Microsoft 365 app ZIP.
2. The **Add skill** form: supply the reviewed name, description and
   instructions, then save. Inspect the resulting source; generated or
   reformatted content is not automatically byte-identical.
3. **Manage skills > Custom skills**: create/open the OneDrive skills folder
   provided by PowerPoint and upload a matching-name folder containing `SKILL.md`.

Select **Refresh**, turn on the skill's toggle, and check its saved instructions
before selecting it for a request.
The lab's PowerPoint OneDrive folder was separate from Excel's. Discover
the intended app's folder rather than copying another app's path.
ZIP uploads have product-specific resource restrictions; this example uses
only Markdown.

In the verified web client, these controls were labeled **Settings and more >
Manage plugins > Custom skills** and **Add sources, skills, and more >
Choose plugins**. Use the actual client labels rather than assuming they
match the support article's screenshots.

## Try the sample and check the result

Create a separate three-slide presentation from the
[outline](../../samples/powerpoint/slide-outline.md) to try the workflow
without changing a work presentation.

In the Copilot prompt, open **Add sources, skills, and more > Choose plugins**,
select `powerpoint-executive-story`, and ask:

```text
Add the executive summary to this presentation for a support-group sponsor.
```

Review/apply the proposed change and inspect the saved deck using the
[rubric](../../samples/powerpoint/expected-behavior.md):

- Four slides: the new **Executive summary** first, then the original three.
- Three to five summary bullets, each no longer than twenty words.
- Accurate support-group pilot and 2030-04-12 date.
- Both 20 and 30 article targets remain an unresolved choice.
- Expansion remains proposed; missing ownership and translation scope are
  not given invented answers.
- Keep the presentation's existing theme and use a readable PowerPoint slide layout.

Draft text in chat is not an inserted slide. An uploaded file is not proof
of discovery or invocation.

## Update and manage as the owner

1. Open **Copilot pane > Settings and more > Manage plugins > Custom skills >
   powerpoint-executive-story**. Some releases label this **Manage skills**.
2. Use the skill's edit option or update its source through the app-specific
   OneDrive folder, depending on how you added it.
3. Select **Refresh**, check the saved instructions and test a new request.
4. Turn off its toggle when you do not want it available. PowerPoint documents
   that disabled skills stop automatic use and disappear from the dropdown;
   do not assume Excel's explicit-mention behavior applies.

## What an administrator can manage

Each user's personal skills are stored in that user's OneDrive.
Centrally maintaining a reviewed
source file does not install it for everyone or continuously synchronize
copies. OneDrive and Copilot organization policies apply, but this route does
not demonstrate an all-users skill-assignment control.

## Troubleshooting

- **Skill missing from the picker:** confirm it is enabled in **Custom
  skills**, refresh, and check you used PowerPoint's folder rather than Excel's.
- **ZIP uploaded but not installed:** use the skill upload form, or extract
  the matching-name folder before a OneDrive folder upload.
- **Summary only appears in chat:** review/apply the proposed change and check
  the saved deck. Chat text alone is not a changed presentation.
- **Duplicate summary slide:** try the sample against a fresh three-slide
  copy; the previously saved result already contains its summary.

Source: [Copilot in PowerPoint skills](https://support.microsoft.com/en-us/powerpoint/copilot/copilot-in-powerpoint-skills).
