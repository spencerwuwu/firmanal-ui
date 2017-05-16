
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

      if @target[:source_code] == -1
        @source_code = "-s"
      else
        @source_code = ""
      end

      if @target[:afl] == -1
        @afl = "-f"
      else
        @afl = ""
      end

      if @target[:network_fuzz] == -1
        @network_fuzz = "-n"
      else
        @network_fuzz = ""
      end

      if @target[:metasploits] == -1
        @metasploits = "-m"
      else
        @metasploits = ""
      end

      @my_args =  "#{Rails.root}/public/uploads/target/attachment/#{@target[:id]}/#{@target[:name]} -i #{@target[:id]} #{@source_code} #{@afl} #{@network_fuzz} #{@metasploits}"

      puts "#{@my_args}"

      @my_pid = Process.fork do
        exec("/home/eecs/firmanal/analyze.py #{@my_args} &")
      end

      Process.wait

      redirect_to targets_path, notice: "The target file #{@target.name} is analyzing. Pid = #{@my_pid}"
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
