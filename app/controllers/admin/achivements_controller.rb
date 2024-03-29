class Admin::AchivementsController < ApplicationController

  def edit
    @achivement = Achivement.includes(:results).find(params[:id])
  end
  def update
    achivement = Achivement.find(params[:id])
    ActiveRecord::Base.transaction do
      achivement.update_attributes!(achivement_params)
      Result.multi_update(results_params)
    end
    redirect_to request.referer
  end

  private
  def achivement_params
    params.require(:achivement).permit(:comment)
  end
  def results_params
    params.require(:achivement).permit(results: :amount)[:results]
  end
end
