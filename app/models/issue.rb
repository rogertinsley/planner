class Issue < ActiveRecord::Base
  include ActiveModel::Model

   attr_accessor :title, :description, :owner, :repo

end
