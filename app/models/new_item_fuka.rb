class NewItemFuka < ApplicationRecord
	belongs_to :fuka, :foreign_key => :fuka_id, :primary_key => :proper_id, :class_name => "ProperName"
end
