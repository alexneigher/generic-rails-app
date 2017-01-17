class Product < ActiveRecord::Base

  def self.get_results(results)
    Product.where("id in (?)", results.map(&:id))
  end

end
