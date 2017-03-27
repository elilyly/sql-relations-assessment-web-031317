class Restaurant
  include Databaseable::InstanceMethods
  extend Databaseable::ClassMethods

  ATTRIBUTES = {
    id: "INTEGER PRIMARY KEY",
    name: "TEXT",
    location: "TEXT",
    owner_id: "INTEGER"
  }

  attr_accessor(*self.public_attributes)
  attr_reader :id

  def owner
    sql =<<-SQL
    SELECT name FROM owners
    JOIN restaurants ON restaurant_id.owner_id = owner.id
    GROUP BY owner.name
    SQL
    DB[:conn].execute(sql)
  end
end
