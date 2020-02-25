class AutomationRunsController < ApplicationController
    def index
        @automationRuns = AutomationRun.all.page params[:page]
    end
    
    def show
        @automationRun = AutomationRun.find(params[:id])
    end

    def create
        puts "Hitting create method"
        if system('ruby scripts/populate_automation_runs.rb')
            puts "Automation Run Created Successfully!"
            system('ruby scripts/populate_test_runs.rb')
        end
        redirect_to dashboard_index_path
      end
end
