class AddIdentifierAndProjectLeadToProject < ActiveRecord::Migration
  def change
    add_column :projects, :identifier, :string
    add_column :projects, :project_lead, :string
  end
end
