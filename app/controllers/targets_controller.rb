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
      puts "gogogo"
      redirect_to targets_path, notice: "The target file #{@target.name} is uploaded."
      puts "gone gone"
    else
      render "new"
    end
  end

  def show
    @target = Target.find(params[:id])
  end

  def source_code
    @target = Target.find(params[:id])
    @target[:source_code_data] = File.read("#{Rails.root}/public/firmanal/file")
    @target.save
  end

  def angr
    @target = Target.find(params[:id])
    @target[:angr_data] = File.read("#{Rails.root}/public/firmanal/file")
    @target.save
  end

  def afl
    @target = Target.find(params[:id])
    @target[:afl_data] = File.read("#{Rails.root}/public/firmanal/file")
    @target.save
  end

  def network_fuzz
    @target = Target.find(params[:id])
    @target[:network_fuzz_data] = File.read("#{Rails.root}/public/firmanal/file")
    @target.save
  end

  def metasploits
    @target = Target.find(params[:id])
    @target[:metasploits_data] = File.read("#{Rails.root}/public/firmanal/file")
    @target.save
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
