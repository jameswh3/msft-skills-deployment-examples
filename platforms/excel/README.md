# Copilot in Excel: pipeline review

Skills provide reusable instructions for workbook tasks. This repository's
[excel-pipeline-review example](../../samples/excel/skills/excel-pipeline-review/SKILL.md)
checks workbook data, lists findings with the affected source rows in a
review worksheet, and calculates totals you can check against the original data.
It uses the workbook access already available to Copilot; it grants no
additional permissions.

This example stores its instructions in the owner's OneDrive. In Excel's
**Copilot pane > Settings and more > Manage plugins > Custom skills**, the
owner opens the **Skills OneDrive folder**, selects **Refresh** after source
changes, and turns the skill's toggle on or off. Centrally reviewing and
distributing the source is different from assigning a Microsoft 365 plugin
to an organization.

## Use an installed skill

1. Open a workbook you are authorized to edit and open its Copilot pane.
2. Select **Add sources, skills, and more > Choose plugins >
   excel-pipeline-review**.
3. Ask it to review the intended table. For this repository's sample, use
   `Review PipelineData in this workbook and apply the review worksheet.`
4. Review the proposed changes, then select **Done** when appropriate.
   Inspect the saved review sheet before relying on its findings or totals.

If the skill is missing, install it using the next section or ask its owner
for the reviewed source. An ordinary workbook user does not need to run the
repository's build commands after the skill is installed.

## Install a personal skill

Use a licensed account with Copilot in Excel available in the browser.
Have a folder named `excel-pipeline-review` containing the reviewed
[SKILL.md](../../samples/excel/skills/excel-pipeline-review/SKILL.md). You can create that folder
and copy the file yourself. To generate the package and optional sample
workbook from this repository instead, run:

```powershell
npm run build:hosts
npm run build:fixtures
```

1. Open an editable XLSX workbook. To try the optional sample, upload
   `out/host-fixtures/OGE-Pipeline-Skill-Demo.xlsx` and open it in Excel's
   Editing View. Its table is named `PipelineData`.
2. In Copilot, open **Settings and more > Manage plugins > Custom skills**.
   Other releases label this **Manage plugins & skills**.
3. If necessary, select **Create skills folder**, then open the product's
   **Skills OneDrive folder** link or **Add > Add in OneDrive**.
4. Upload the matching-name `excel-pipeline-review` folder containing the
   reviewed `SKILL.md`. Alternatively, extract the matching-name OneDrive
   archive under `out/host-examples/excel/excel-pipeline-review`.
   Uploading that ZIP as an ordinary OneDrive document is not installation.
5. Return to **Custom skills**, select **Refresh**, and enable the example.
   Verify its name and source, not just a successful upload notification.

The lab's Excel folder was under **My files > Documents > Copilot >
Microsoft Excel > skills**. Its PowerPoint folder was separate. Use the
product-created folder for the intended app; do not assume this layout is a
universal path or that one app's upload installs the skill in another app.

## Try the sample and check the result

In the Copilot prompt's **Add sources, skills, and more > Choose plugins**,
select `excel-pipeline-review`. Request:

```text
Review PipelineData in this workbook and apply the review worksheet.
```

Confirm the intended editing mode and review the proposed changes. Select
**Done** when appropriate, then inspect the saved `PipelineReview` worksheet.
The [rubric](../../samples/excel/expected-behavior.md) requires seven source
records, eight findings, and a raw numeric total of **35000** across **six**
numeric records. Both duplicate rows and the negative amount are included;
the nonnumeric amount is excluded and zero remains numeric.

A useful read-back request is:

```text
Verify the saved PipelineReview worksheet and report the raw total,
included record count, finding count and distinct affected source-row count.
```

All seven source rows have findings. Check actual cells rather than trusting
a chat-only count or a claim that a worksheet was created.

## Update and manage as the owner

1. Open **Copilot pane > Settings and more > Manage plugins > Custom skills**.
2. Follow **Skills OneDrive folder** to the skill's saved instructions.
   Edit the reviewed Markdown in a text editor and replace the saved file
   in the same skill folder when updating it.
3. Return to **Custom skills > Refresh**. Check the skill's name, saved
   instructions and toggle, then test a new request.
4. Turn off its toggle to stop automatic use. Excel documents that an explicit
   `@mention` can still invoke it, so this is not an access-revocation control.

## What an administrator can manage

OneDrive ownership, permissions, retention and organization policy govern
the stored files and Copilot availability. This route installs a personal
skill for its owner; it does not provide an all-users installation switch.
If distributing reviewed source, each recipient must complete installation
in their own Excel skills folder and refresh Excel.

## Troubleshooting

- **Skill does not appear:** use Excel's **Skills OneDrive folder** link,
  check the matching folder/name and `SKILL.md`, then select **Refresh**.
  An unextracted ZIP stored as a document is not installed.
- **Workbook opens read-only:** use an editable workbook and an account with
  edit permission. The optional generator creates an XLSX rather than a CSV.
- **Chat and worksheet disagree:** read the saved worksheet cells and request
  reconciliation. Do not rely on the chat's summary count alone.

Source: [Copilot in Excel skills](https://support.microsoft.com/en-us/excel/copilot/copilot-in-excel-skills).
