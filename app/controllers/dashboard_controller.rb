class DashboardController < ApplicationController
  def index
    @lastSixAutomationRuns = AutomationRun.order(id: :desc).first(6)
    
    passHash = Hash.new
    @lastSixAutomationRuns.each do |automationRun|
      id = automationRun.id
      passes = TestRun.where(status: 'pass', automation_runs_id: id).count
      fails = TestRun.where(status: 'fail', automation_runs_id: id).count
      skips = TestRun.where(status: 'skip', automation_runs_id: id).count
      passHash[id] = [passes, fails, skips]
    end
    puts passHash
    @testsPassed = passHash
  end
end
