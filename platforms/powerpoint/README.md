# Copilot in PowerPoint: executive story

The [powerpoint-executive-story skill](skills/powerpoint-executive-story/SKILL.md)
adds a concise executive summary first while retaining the detailed slides.
It uses the presentation access already available to Copilot; it grants no
additional permissions.

## Prepare the example

Run `npm run build:hosts` from the repository root. Create a new synthetic
presentation using the three-slide [outline](../../samples/powerpoint/slide-outline.md).
Use a licensed account with the relevant Copilot features available; browser
availability must be checked in the actual client and tenant.

## Add the skill in PowerPoint

Start in the **Copilot pane** (the chat side panel), not PowerPoint's
**File > Options** settings. The verified web client uses **Settings and more >
Manage plugins > Custom skills**. Microsoft's support article calls this
**Manage skills** instead.

PowerPoint documents three personal custom-skill routes:

1. **Choose skills > Manage skills > Add skill**: upload the reviewed
   standalone skill ZIP from
   `out/host-examples/powerpoint/powerpoint-executive-story`.
   This is not a Microsoft 365 app ZIP.
2. The **Add skill** form: supply the reviewed name, description and
   instructions, then save. Inspect the resulting source; generated or
   reformatted content is not automatically byte-identical.
3. **Manage skills > Custom skills**: create/open the native OneDrive skills
   folder and upload a matching-name folder containing `SKILL.md`.

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

The lab used the documented OneDrive-copy route. After an initial folder
upload error, the canonical file was added to the already-discovered empty
folder through the documented [SharePoint files REST API](https://learn.microsoft.com/en-us/sharepoint/dev/sp-add-ins/working-with-folders-and-files-with-rest),
without overwriting an existing file. Downloaded bytes matched the canonical
SHA-256. The native custom list and picker then recognized the skill.

## Run and verify

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
- Existing theme and readable native layout.

The saved lab deck was independently decoded, not accepted from chat claims:
four slides, all three original source slides intact, and five summary bullets
containing 10, 12, 12, 11 and 14 whitespace-delimited words. Each slide uses
the same native title-and-content layout. The response explicitly labeled
the recommended next step as an inference from the open issues.

Draft text in chat is not an inserted slide. An uploaded file is not proof
of discovery or invocation; see [lab evidence](../../docs/lab-status.md).

## Owner and administrator experience

Open **Copilot pane > Settings and more > Manage plugins > Custom skills >
powerpoint-executive-story**. Show its toggle and saved instructions.
Use **Add** to show the available addition methods, or **Refresh** to reload
the list, without uploading or changing anything during the presentation.
Some releases label the menu **Manage skills**. PowerPoint documents that
disabled skills stop automatic use and disappear from the dropdown; do not
copy Excel's explicit-mention semantics onto PowerPoint.

These are owner-specific OneDrive skills. Centrally maintaining a reviewed
source and distributing it does not establish tenant-wide installation,
continuous synchronization or revocation of copies.

See [the presenter walkthrough](../../docs/demo-script.md).
Source: [Copilot in PowerPoint skills](https://support.microsoft.com/en-us/powerpoint/copilot/copilot-in-powerpoint-skills).
