class AutomationRun
    def initialize(timestamp, os, buildNumber)
        @timestamp = timestamp
        @os = os
        @buildNumber = buildNumber
    end

    attr_reader :timestamp, :os, :buildNumber
end