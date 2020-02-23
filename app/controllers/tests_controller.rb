class TestsController < ApplicationController
    def index
        @tests = Test.all.page params[:page]
    end
    
    def show
        @test = Test.find(params[:id])
    end
end
