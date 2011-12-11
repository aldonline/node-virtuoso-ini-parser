
# Overview

virtuoso.ini differs from regular .inis so existing parsers failed.

# Basic Usage

    vip = require 'virtuoso-ini-parser'
    
    # read and parse an ini file
    
    ini = vip.read_sync './virtuoso.ini'
    
    # the ini variable now refers to a hash ( simple Object )
    # containing all sections and values parsed from the ini
    # comments and formatting are forever lost
    
    # read some values from the hash ( Object )
    
    console.log ini.Database.DatabaseFile # 'virtuoso.db'
    console.log ini.Parameters.ServerPort # '1111'
    
    # modify freely ( it's just a plain hash! )
    ini.Parameters.ServerPort = '1112'
    
    # you can also delete a complete section
    delete ini.Mono
    
    # and add a completely new section if you like
    # no validation takes place ( you guessed, because it is just a hash )
    ini.SelfDestruction = type: 'nuclear', delay: 1000
    
    # introspect
    for own section, params of ini
      for own key, value of params
        console.log "#{section}.#{key} = #{value}"
    
    # store the hash in ini format again
    # wherever you want
    vip.write_sync './virtuoso.ini'


# Other methods

The API exposes two more core methods:

    # parse a string
    ini = vip.parse ini_file_contents_as_string

    # serialize a hash
    ini_contents_as_string = vip.stringify ini


And a convenience method to apply overrides to inis.
This simply iterates through the new section.key=values
and applies them, setting values and/or creating sections
as needed.

    # load file
    ini = vip.read_sync './virtuoso.ini'
    
    # apply configuration changes
    vip.override ini,
      Database:
        DatabaseFile: '/tmp/db1/virtuoso.db'
      Parameters:
        ServerPort: 1112
        NumberOfBuffers: 10000
    
    # save
    vip.write_sync './virtuoso.ini'


