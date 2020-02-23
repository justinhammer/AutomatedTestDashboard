class DashboardController < ApplicationController
  def index
    # Get latest six automation rows to display on Dashboard:
    @lastSixAutomationRuns = AutomationRun.order(id: :desc).first(6)
    
    # Get test status information for each of the latest 6 automation runs:
    passHash = Hash.new
    @lastSixAutomationRuns.each do |automationRun|
      id = automationRun.id
      stats = TestRun.select(:status).where(automation_runs_id: id)
      passHash[id] = stats
      
      passes = passHash[id].count { |element| element["status"].match(/pass/) }
      fails = passHash[id].count { |element| element["status"].match(/fail/) }
      skips = passHash[id].count { |element| element["status"].match(/skip/) }

      

      passHash[id] = {"passes" => passes, "fails" => fails, "skips" => skips}
    end
    @testStatuses = passHash
  end
end
