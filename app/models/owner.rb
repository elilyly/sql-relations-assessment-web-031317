class Owner
  include Databaseable::InstanceMethods
  extend Databaseable::ClassMethods
  ATTRIBUTES = {
    id: "INTEGER PRIMARY KEY",
    name: "TEXT",
  }

  attr_accessor(*self.public_attributes)
  attr_reader :id

  def restaurants
    sql =<<-SQL
    SELECT * FROM restaurants
    WHERE restaurants.owner_id = owner.id
    GROUP BY restaurant.name
    SQL
    DB[:conn].execute(sql)
  end
end
