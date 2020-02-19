class AutomationRun
    def initialize(id, timestamp, os, buildNumber)
        @id = id
        @timestamp = timestamp
        @os = os
        @buildNumber
    end

    attr_reader :id, :timestamp, :os, :buildNumber
end