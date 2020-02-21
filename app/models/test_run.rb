class TestRun < ApplicationRecord
    belongs_to :tests
    belongs_to :automation_runs
end
