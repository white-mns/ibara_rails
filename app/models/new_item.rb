class NewItem < ApplicationRecord
    proper_name = ProperName.pluck(:name, :proper_id).inject(Hash.new(0)){|hash, a| hash[a[0]] = a[1] ; hash}
    critical = proper_name["素材"]
	belongs_to :item,  -> { where(kind_id: critical)}, :foreign_key => [:result_no, :generate_no, :name], :primary_key => [:result_no, :generate_no, :name], :class_name => 'Item'
end
