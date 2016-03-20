class Milestone < ActiveRecord::Base
  include ActiveModel::Model

   attr_accessor :title, :description, :due_date
end
