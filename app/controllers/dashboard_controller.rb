class DashboardController < ApplicationController
  def index
    @lastSixAutomationRuns = AutomationRun.order(id: :desc).first(6)
    
    passHash = Hash.new
    @lastSixAutomationRuns.each do |automationRun|
      id = automationRun.id
      stats = TestRun.select(:status).where(automation_runs_id: id)
      passHash[id] = stats
      
      passes = passHash[id].count { |element| element["status"].match(/pass/) }
      fails = passHash[id].count { |element| element["status"].match(/fail/) }
      skips = passHash[id].count { |element| element["status"].match(/skip/) }
      passHash[id] = [passes, fails, skips]
    end
    @testsPassed = passHash
  end
end
