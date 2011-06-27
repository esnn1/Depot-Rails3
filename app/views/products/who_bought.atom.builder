

# Lets build an atom feed 

atom_feed do |feed|
  feed.title "Who bought #{@product.title}"
  latest_order = @product.orders.sort_by(&:updated_at).last
  feed.updated( latest_order && latest_order.updated_at )

  @product.orders.each do |order|
    feed.entry(order) do |entry|
      entry.title "Order #{order.id}"
      entry.summary :type => 'xhtml' do |xhtml|
        xhtml.p "Shipped to #{order.address}"
      end
      entry.author do |author|
        entry.name order.name
        entry.email order.email
      end
    end
  end

end
