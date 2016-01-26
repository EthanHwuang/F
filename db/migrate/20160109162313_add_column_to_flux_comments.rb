class AddColumnToFluxComments < ActiveRecord::Migration
  def change
    add_column :flux_comments, :childComment_id, :integer,  index: true, foreign_key: true
    add_column :flux_comments, :parentComment_id, :integer,  index: true, foreign_key: true
  end
end
