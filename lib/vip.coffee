fs = require 'fs'

exports.parse = parse = ( string ) ->
  ini = {}
  section = null
  for line in string.split '\n'
    line = line.trim()
    if line.length > 0 and line[0] isnt ';'
      if line[0] is '[' # a new section
        ini[ line.substring 1, line.length - 1 ] = section = {}
      else # a value
        [key, value] = line.split '='
        # remember some values have trailing comments
        section[key.trim()] = value.split(';')[0].trim()
  ini

exports.stringify = stringify = ( object ) ->
  lines = []
  for own section, settings of object
    lines.push ''
    lines.push '[' + section + ']'
    for own key, value of settings
      lines.push key + ' = ' + value
  lines.join '\n'

exports.read_sync = read_sync = ( path ) -> 
  parse fs.readFileSync path, 'utf8'

exports.write_sync = write_sync = ( path, object ) ->
  fs.writeFileSync path, stringify object

# applies overrides to an ini object
exports.override = override = ( ini, overrides ) ->
  for own section, settings of overrides
    for own key, value of settings
      ( ini[section] ?= {} )[ key ] = value
