class TestRunsController < ApplicationController
    def index
        @test_runs = TestRun.all.page params[:page]
    end
    
    def show
        @test_run = TestRun.find(params[:id])
    end
end
