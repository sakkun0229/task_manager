class LabelsController < ApplicationController

  def index
    @labels = Label.all
  end

  def create
    @label = Label.new(params.require(:label).permit(:name))
    @label.save
    redirect_to labels_path
  end

  def destroy
    @label = Label.find(params[:id])
    @label.destroy
    redirect_to labels_path
  end

end
