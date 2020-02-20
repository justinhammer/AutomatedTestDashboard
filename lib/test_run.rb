class TestRun
    def initialize(id, timestamp, status, testName, automationRun)
        @timestamp = timestamp
        @status = status
        @testName = testName
        @automationRun = automationRun
    end

    attr_reader :timestamp, :status, :testName, :automationRun
end