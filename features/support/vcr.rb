require 'vcr'
require 'webmock/cucumber'

VCR.configure do |c|
  # Automatically filter all secure details that are stored in the environment
  ignore_env = %w{SHLVL RUNLEVEL GUARD_NOTIFY DRB COLUMNS USER LOGNAME LINES}
  (ENV.keys-ignore_env).select{|x| x =~ /\A[A-Z_]*\Z/}.each do |key|
    c.filter_sensitive_data("<#{key}>") { ENV[key] }
  end
  c.filter_sensitive_data("<KEY>") do |interaction|
    interaction.response.body.match(/SID=[a-z0-9_-]+[\s]+LSID=[a-z0-9_-]+[\s]+Auth=([a-z0-9_-]+)/i)
  end
  c.default_cassette_options = { :record => :all }
  c.cassette_library_dir = 'fixtures/vcr_cassettes'
  c.hook_into :webmock
end

VCR.cucumber_tags do |t|
  t.tag '@vcr', use_scenario_name: true 
end