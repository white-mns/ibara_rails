class NewItem < ApplicationRecord
  proper_name = ProperName.pluck(:name, :proper_id).inject(Hash.new(0)){|hash, a| hash[a[0]] = a[1] ; hash}
  belongs_to :item,  -> { where(kind_id: proper_name["素材"])}, :foreign_key => [:result_no, :generate_no, :association_name], :primary_key => [:result_no, :generate_no, :name], :class_name => 'Item'
end
