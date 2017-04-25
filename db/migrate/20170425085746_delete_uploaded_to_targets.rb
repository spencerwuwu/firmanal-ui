class DeleteUploadedToTargets < ActiveRecord::Migration[5.0]
  def change
    remove_column :targets, :uploaded
  end
end
