.runs[].tool as $tool |
.runs[].results[] as $results |
$results.locations[] |
{
  ruleId: $results.ruleId,
  uri: .physicalLocation.artifactLocation.uri,
  startLine: .physicalLocation.region.startLine,
  startColumn: .physicalLocation.region.startColumn,
  level: $results.level,
  shortDescription: $tool.driver.rules[] | select(.id == $results.ruleId) | .shortDescription.text,
  helpUri: $tool.driver.rules[] | select(.id == $results.ruleId) | .helpUri
} |
.uri + ":" +
(.startLine | tostring) + ":" +
(.startColumn | tostring) + ":" +
(.level | ascii_upcase) + ":" +
"\"" + .ruleId + " " + .shortDescription + " " + .helpUri + "\""
