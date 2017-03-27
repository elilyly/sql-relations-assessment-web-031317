class Review
  include Databaseable::InstanceMethods
  extend Databaseable::ClassMethods

  ATTRIBUTES = {
    id: "INTEGER PRIMARY KEY",
    customer_id: "INTEGER",
    restaurant_id: "INTEGER"
  }

  attr_accessor(*self.public_attributes)
  attr_reader :id



  def customer
    sql =<<-SQL
      SELECT name FROM customers
      INNER JOIN reviews ON reviews.customer_id = customer.id
    SQL
    DB[:conn].execute(sql)
  end

  def restaurant
    sql =<<-SQL
      SELECT name FROM restaurants
      INNER JOIN reviews ON reviews.restaurant_id = restaurant.id
    SQL
    DB[:conn].execute(sql)
  end
end
