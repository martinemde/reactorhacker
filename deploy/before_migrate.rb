# encoding: UTF-8
$stderr.puts deployed_by
unless deployed_by == "Martin ☃ Emde".force_encoding('UTF-8')
  raise "encoding must match exactly!"
end
