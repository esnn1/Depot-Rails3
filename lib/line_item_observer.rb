class LineItemObserver < ActiveRecord::Observer
  def after_create(model)
    model.logger.info(">>Line item created: #{model.product.title}")
  end
end
