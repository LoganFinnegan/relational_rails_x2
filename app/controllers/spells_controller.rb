class SpellsController < ApplicationController
  def index
    @spells = Spell.learned_spells
  end

  def show
    @spell = Spell.find(params[:id])
  end

  def edit
    @spell = Spell.find(params[:id])
  end

  def update 
    spell = Spell.find(params[:id])
    spell.update(spell_params)
    redirect_to "/spells/#{spell.id}"
  end

  def destroy
    Spell.find(params[:id]).destroy
    redirect_to "/spells"
  end

  private 

  def spell_params
    params.permit(:name, :learned, :spell_level)
  end
end