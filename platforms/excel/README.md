# Copilot in Excel: pipeline review

The [excel-pipeline-review skill](skills/excel-pipeline-review/SKILL.md)
creates a review worksheet with source-row evidence and reconciled totals.
It defines a workflow, not additional permission restrictions.

This native custom-skill example uses the owner's OneDrive and Excel's
skill controls. Centrally reviewing and distributing the source is different
from assigning a Microsoft 365 plugin to an organization.

## Prepare and deploy

Use a licensed account with Copilot in Excel available in the browser.
From the repository root:

```powershell
npm run build:hosts
npm run build:fixtures
```

1. Upload `out/host-fixtures/OGE-Pipeline-Skill-Demo.xlsx` and open it in
   Excel's Editing View. The workbook has a `PipelineData` table.
   Direct CSV upload opened in Reading View in the lab.
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

## Run and verify

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

## Owner and administrator experience

- Show **Manage plugins > Custom skills**, the example's toggle and details,
  **Refresh**, and its OneDrive source without changing them during a demo.
- Updates require replacing/editing the owner's source and refreshing the
  client. Verify a fresh request after an update.
- Excel documents that disabling automatic use does not prevent an explicit
  `@mention`. Do not present that toggle as an access-control boundary.
- OneDrive ownership, permissions and lifecycle policies govern the stored
  files. A personal skill is not an all-users tenant assignment.

See [lab evidence](../../docs/lab-status.md) and
[the presenter walkthrough](../../docs/demo-script.md).
Source: [Copilot in Excel skills](https://support.microsoft.com/en-us/excel/copilot/copilot-in-excel-skills).
