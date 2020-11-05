class World < ApplicationRecord
  belongs_to :pc_name, :foreign_key => [:e_no, :result_no, :generate_no], :primary_key => [:e_no, :result_no, :generate_no], :class_name => "Name"

  scope :world_graph, ->(params)   {
    notnil().group(:world).search(params[:q]).result.world_id_to_name()
  }

  scope :world_id_to_name, ->()   {
    hash = self.count
    hash[:イバラシティ] = hash.delete(0)
    hash[:アンジニティ] = hash.delete(1)
    hash
  }

end
