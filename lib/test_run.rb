class TestRun
    def initialize(timestamp, status, testName, automationRunId)
        @timestamp = timestamp
        @status = status
        @testName = testName
        @automationRunId = automationRunId
    end

    attr_reader :timestamp, :status, :testName, :automationRunId
end