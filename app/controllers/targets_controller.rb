
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

    @firmanal_path = "/home/eecs/firmanal"

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

      @my_args =  "'#{Rails.root}/public/uploads/target/attachment/#{@target[:id]}/#{@target[:name]}' -i #{@target[:id]} #{@source_code} #{@afl} #{@network_fuzz} #{@metasploits}"

      puts "#{@firmanal_path}/analyze.py #{@my_args}"

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
    @target = Target.find(params[:id])
    @firmanal_path = "/home/eecs/firmanal/results/#{@target[:id]}/source/"
    def procdir(dir)
      Dir[ File.join(dir, '**', '*') ].reject { |p| File.directory? p }
    end

    @file_list = procdir("#{@firmanal_path}")

  end

  def angr
    @target = Target.find(params[:id])
    @firmanal_path = "/home/eecs/firmanal/results/#{@target[:id]}/metasploit/"
    def procdir(dir)
      Dir[ File.join(dir, '**', '*') ].reject { |p| File.directory? p }
    end

    @file_list = procdir("#{@firmanal_path}")
  end

  def afl
    @target = Target.find(params[:id])
    @firmanal_path = "/home/eecs/firmanal/results/#{@target[:id]}/afl/out/"
    def procdir(dir)
      Dir[ File.join(dir, '**', '*') ].reject { |p| File.directory? p }
    end

    @file_list = procdir("#{@firmanal_path}")
  end

  def network_fuzz
    @target = Target.find(params[:id])
    @firmanal_path = "/home/eecs/firmanal/results/#{@target[:id]}/metasploit/"
    def procdir(dir)
    end

    @file_list = procdir("#{@firmanal_path}")

  end

  def metasploits
    @target = Target.find(params[:id])
    @firmanal_path = "/home/eecs/firmanal/results/#{@target[:id]}/metasploit/"
    def procdir(dir)
      Dir[ File.join(dir, '**', '*') ].reject { |p| File.directory? p }
    end

    @file_list = procdir("#{@firmanal_path}")
  end

  def destroy
  end

  private
  def target_params
    params.require(:target).permit!.except()
  end
end
