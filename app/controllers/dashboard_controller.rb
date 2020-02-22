class DashboardController < ApplicationController
  def index
    @lastSixAutomationRuns = AutomationRun.last(6)
  end
end
