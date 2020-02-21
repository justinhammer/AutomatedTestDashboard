class AutomationRunsController < ApplicationController
    def index
        @automationRuns = AutomationRun.all
    end
    
    def show
        @automationRun = AutomationRun.find(params[:id])
    end
end
