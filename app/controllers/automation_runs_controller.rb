class AutomationRunsController < ApplicationController
    def index
        @automationRuns = AutomationRun.all.page params[:page]
    end
    
    def show
        @automationRun = AutomationRun.find(params[:id])
    end
end
