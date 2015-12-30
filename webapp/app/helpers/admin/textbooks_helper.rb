module Admin::TextbooksHelper

  def units
    if @textbook.units and @textbook.units.length >=1
      @textbook.units
    else
      {"0"=>{"unit"=>""}}
    end
  end
end
