class RemoveNameAndIdentifierAndProjectLeadFromProjects < ActiveRecord::Migration
  def change
    remove_column :projects, :name, :string
    remove_column :projects, :identifier, :string
    remove_column :projects, :project_lead, :identifier
  end
end
