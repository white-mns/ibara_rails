module MoveHelper
  def move_no_text(move)
    if !move then
      return
    end

    if move.move_no == 0 then sprintf("%d", move.move_no) + "(待機)"
    else move.move_no
    end
  end
end
