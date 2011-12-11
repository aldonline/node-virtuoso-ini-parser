vip = require '../lib/vip'
assert = require 'assert'

test = ->
  path = __dirname + '/virtuoso.ini'
  ini = vip.read_sync path
  # test a value that we know we won't change
  assert.equal ini.Replication.QueueMax, '50000'
  vip.override ini, {Replication:{QueueMax:'40000'}}
  assert.equal ini.Replication.QueueMax, '40000'
  # vip.write_sync __dirname + '/virtuoso.ini.txt', ini

test()