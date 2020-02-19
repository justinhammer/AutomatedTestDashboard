class TestRun
    def initialize(id, timestamp, status, testName, automationRun)
        @id = id
        @timestamp = timestamp
        @status = status
        @testName = testName
        @automationRun = automationRun
    end

    attr_reader :id, :timestamp, :status, :testName, :automationRun
end