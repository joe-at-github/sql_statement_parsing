# Changelog

## 0.1.0
Core functionalities implemented.

## 0.1.1
Update README with accurate output in the usage section.

## 0.2.0
Remove #yaml and #hash.

Introduce #to_h, #data, #operation, #statement.

Include all fields and values in the 'data' section of the data packet, i.e no longer filtering out created_at and updated_at keys and values.

Simplify abstraction layers with better naming and removing a redundant class.

Update documentation.

## 0.2.1
Add description for #statement to README.

## 0.2.2
`SqlStatementParsing#to_h` returns a hash with symbolized keys, even for nested hashes.