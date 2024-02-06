class WizardSpellsController < ApplicationController
  def index 
    @wizard = Wizard.find(params[:id])
    if params[:sorted] 
      @wizard_spells = @wizard.spells.alphebetize
    elsif params[:threshold]
      @wizard_spells = @wizard.spells.level_over(params[:threshold])
    else
      @wizard_spells = @wizard.spells
    end
  end 

  def new
    @wizard = Wizard.find(params[:id])
  end

  def create
    wizard = Wizard.find(params[:id])
    wizard_spells = wizard.spells.create!(wizard_spell_params)
    redirect_to "/wizards/#{wizard.id}/wizard_spells"
  end

  # def spells_apha
  #   @wizard = Wizard.find(params[:id])
  #   @wizard_spells = @wizard.spells.order(:name)
  # end

  private 

  def wizard_spell_params
    params.permit(:name, :learned, :spell_level)
  end
end