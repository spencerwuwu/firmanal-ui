
class TargetsController < ApplicationController

  @firmanal_path = "/home/eecs/firmanal"

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
        exec("#{@firmanal_path}/analyze.py #{@my_args} &")
      end

      Process.wait
      @target[:pid] = @my_args
      @target.save

      redirect_to targets_path, notice: "The target file #{@target.name} is analyzing. Pid = #{@my_pid}"
    else
      render "new"
    end
  end

  def show
    @target = Target.find(params[:id])
  end

  def source_code
    @tmp_string = ""
    @target = Target.find(params[:id])
    Dir.glob("#{@firmanal_path}/results/#{@target[:id]}/source_code/*") do | single_file |
      @tmp_string += "#{single_file}"
      @tmp_string += ("\n")
      @tmp_string += File.read("#{single_file}")
    end
    @target[:source_code_data] = @tmp_string
    @target.save
  end

  def angr
    @target = Target.find(params[:id])
    @tmp_string = ""
    Dir.glob("#{@firmanal_path}/results/#{@target[:id]}/angr/*") do | single_file |
      @tmp_string += "#{single_file}"
      @tmp_string += ("\n")
      @tmp_string += File.read("#{single_file}")
    end
    @target[:angr_data] = @tmp_string
    @target.save
  end

  def afl
    @target = Target.find(params[:id])
    @tmp_string = ""
    Dir.glob("#{@firmanal_path}/results/#{@target[:id]}/afl/*") do | single_file |
      @tmp_string += "#{single_file}"
      @tmp_string += ("\n")
      @tmp_string += File.read("#{single_file}")
    end
    @target[:afl_data] = @tmp_string
    @target.save
  end

  def network_fuzz
    @target = Target.find(params[:id])
    @tmp_string = ""
    Dir.glob("#{@firmanal_path}/results/#{@target[:id]}/network_fuzz/*") do | single_file |
      @tmp_string += "#{single_file}"
      @tmp_string += ("\n")
      @tmp_string += File.read("#{single_file}")
    end
    @target[:network_fuzz_data] = @tmp_string
    @target.save
  end

  def metasploits
    @target = Target.find(params[:id])
    @tmp_string = ""
    Dir.glob("#{@firmanal_path}/results/#{@target[:id]}/metasploits/*") do | single_file |
      @tmp_string += "#{single_file}"
      @tmp_string += ("\n")
      @tmp_string += File.read("#{single_file}")
    end
    @target[:metasploits_data] = @tmp_string
    @target.save
  end

  def destroy
  end

  private
  def target_params
    params.require(:target).permit!.except()
  end
end
