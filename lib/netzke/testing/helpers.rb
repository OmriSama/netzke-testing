module Netzke::Testing::Helpers
  def run_mocha_spec(path, options = {})
    @component = options[:component] || path.camelcase
    locale = options[:locale]
    url = netzke_components_path(class: @component, spec: path)
    url << "&locale=#{locale}" if locale

    visit url

    # Wait while the test is running
    wait_for_javascript(options[:stop_on_error])

    assert_mocha_results(options[:stop_on_error])
  end

  def wait_for_javascript(stop_on_error = false)
    start = Time.now
    loop do
      page.execute_script("return Netzke.mochaDone;") ? break : sleep(0.1)

      # no specs are supposed to run longer than 100 seconds
      raise "Timeout running JavaScript specs for #{@component}" if Time.now > start + 100.seconds
    end

  rescue Selenium::WebDriver::Error::JavascriptError => e
    sleep 1.year if stop_on_error
    raise e
  end

  def assert_mocha_results(stop_on_error = false)
    result = page.execute_script(<<-JS)
      var runner = Netzke.mochaRunner;
      return {
        test: runner.test.title,
        success: runner.stats.failures == 0 && runner.stats.tests !=0,
        error: runner.test.err && runner.test.err.toString()
      }
    JS

    if !result["success"]
      sleep 1.year if stop_on_error
      raise "Test failed: #{result["test"]}\n#{result["error"]}"
    end
  end
end
