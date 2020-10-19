class BreweriesController < ApplicationController

    def index 
        if params [:state]
            @breweries = Brewery.filter_by_state
        else
            @breweries = Brewery.all
        end
        render json: @breweries
    end

    def show   
        @brewery = Brewery.find(params: [:id])
        render json: @brewery
    end

end 
