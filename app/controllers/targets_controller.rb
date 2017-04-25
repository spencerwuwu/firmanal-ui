class TargetsController < ApplicationController
  def index
    @targets = Target.all
  end

  def new
    @target = Target.new
  end

  def create
    @target = Target.new(target_params)
    @target[:extracted] = false

    if @target.save
      redirect_to targets_path, notice: "The target file #{@target.name} is uploaded."
    else
      render "new"
    end
  end

  def show
    @target = Target.find(params[:id])
  end

  def destroy
    @target = Target.find(params[:id])
    @target.destroy
    redirect_to targets_path, notice: "The report of #{@target.name} has been deleted."
  end

  private
  def target_params
    params.require(:target).permit!.except()
  end
end
