class UploadCheckJob < ApplicationJob
  queue_as :default

  def perform(id)
    # Do something later
    @target = Target.find(params[:id])
    @target[:uploaded] = true
    @target.save
    redirect_to target, notice: "The target file #{@target.name} has been uploaded."
  end
end
