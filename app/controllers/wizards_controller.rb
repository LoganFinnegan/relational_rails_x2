class WizardsController < ApplicationController
  def index
    @wizards = Wizard.sort_by_creation_date
  end

  def show
    @wizard = Wizard.find(params[:id])
  end

  def new; end

  def create 
    Wizard.create!(wizard_params)
    redirect_to '/wizards'
  end

  def edit 
    @wizard = Wizard.find(params[:id])
  end

  def update
    @wizard = Wizard.find(params[:id])
    @wizard.update(wizard_params)
    redirect_to "/wizards/#{@wizard.id}"
  end

  def destroy
    Wizard.find(params[:id]).destroy
    redirect_to "/wizards"
  end
  
  private
  
  def wizard_params
    params.permit(:name, :level, :graduated, :age)
  end
end