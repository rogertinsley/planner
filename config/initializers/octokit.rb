stack = Faraday::RackBuilder.new do |builder|
  builder.use Faraday::HttpCache, shared_cache: false
  builder.use Octokit::Response::RaiseError
  builder.adapter Faraday.default_adapter
  builder.response :logger
end
Octokit.middleware = stack
