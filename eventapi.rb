# Hook into the runtime 'at_exit' event
at_exit do
  # Name the custom event
  payload = { 'eventType' => 'CLIRun' }

  # Check to see if the process is exiting due to an error
  if $!.nil? || $!.is_a?(SystemExit) && $!.success?
    payload[:status] = 0
  else
    # Gather any known errors
    errors = ""
    (Thread.current[:errors] ||= []).each do |err|
      errors += "#{err}\n"
    end
    payload[:errors] = errors
  end

  # Send the errors to New Relic as a custom event
  insights_url = URI.parse("https://insights-collector.newrelic.com/v1/accounts/3375015/events")
  headers = { "Api-Key" => "<NEW-RELIC-API-KEY", "content-type" => "application/json" }

  http = Net::HTTP.new(insights_url.host, insights_url.port)
  http.use_ssl = true
  request = Net::HTTP::Post.new(insights_url.request_uri, headers)
  request.body = payload.to_json

  puts "Sending run summary to New Relic: #{payload.to_json}"
  begin
    response = http.request(request)
    puts "Response from New Relic: #{response.body}"
  rescue Exception => e
    puts "There was an error posting to New Relic. Error: #{e.inspect}"
  end
end
