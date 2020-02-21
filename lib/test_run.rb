class TestRun
    def initialize(timestamp, status, testId, automationRunId)
        @timestamp = timestamp
        @status = status
        @testId = testId
        @automationRunId = automationRunId
    end

    attr_reader :timestamp, :status, :testId, :automationRunId
end