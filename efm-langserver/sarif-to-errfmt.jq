.runs[].tool as $tool |
.runs[].results[] as $results |
$results.locations[] |
{
  ruleId: $results.ruleId,
  uri: .physicalLocation.artifactLocation.uri,
  startLine: .physicalLocation.region.startLine,
  endLine: .physicalLocation.region.endLine,
  startColumn: .physicalLocation.region.startColumn,
  endColumn: .physicalLocation.region.endColumn,
  level: $results.level,
  shortDescription: $tool.driver.rules[] | select(.id == $results.ruleId) | .shortDescription.text,
  helpUri: $tool.driver.rules[] | select(.id == $results.ruleId) | .helpUri
} |
.uri + ":" +
(.startLine | tostring) + "-" + (.endLine | tostring) + ":" +
(.startColumn | tostring) + "-" + (.endColumn | tostring) + ":" +
(.level | ascii_upcase) + ":" +
"\"" + .ruleId + " " + .shortDescription + " " + .helpUri + "\""
