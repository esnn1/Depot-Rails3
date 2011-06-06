class Cart < ActiveRecord::Base
  has_many :line_items, :dependant => :destroy
end
