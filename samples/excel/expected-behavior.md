# Excel pipeline review rubric

Run `npm run build:fixtures` to generate an editable XLSX containing the
[pipeline.csv](pipeline.csv) source as a table, with its header in row 1.
Upload the XLSX for the live demo; direct CSV upload opened in Reading View
in the lab and cannot demonstrate worksheet editing.
The native skill should create or update a PipelineReview worksheet, not just
describe one in chat.

- Seven source records; L001 duplicated in worksheet rows 2 and 5.
- Missing owner in row 3; unexpected Stage `Unknown` in row 4.
- Negative numeric amount -2000 in row 6.
- Nonnumeric amount and invalid date in row 7.
- Missing TargetDate in row 8; numeric zero is not a missing amount.
- Raw numeric total **35000** across **six** numeric records, explicitly
  including both duplicate rows and the negative amount.
- `not-a-number` is excluded, not converted to zero; the total is not labeled
  a deduplicated forecast.
- Findings include row references and original values, with source records
  still available for reconciliation.

Verify the actual worksheet cells and native skill indicator. A chat response
claiming that a worksheet was created is insufficient.
