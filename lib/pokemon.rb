class Pokemon
  attr_accessor :name, :type, :db
  attr_reader :id

  def initialize(name:, type:, db:, id:nil)
    @name = name
    @type = type
    @db = db
    @id = id
  end

  def self.save(name, type, db)
    sql = "INSERT INTO pokemon (name, type) VALUES (?, ?);"
    db.execute(sql, name, type)
    @id = db.execute("SELECT last_insert_rowid() FROM pokemon;")[0][0]
  end

  def self.find(id, db)
    sql = "SELECT * FROM pokemon WHERE id = ?;"
    pokemon = db.execute(sql, id).flatten
    self.new(id: pokemon[0], name: pokemon[1], type: pokemon[2], db: db)
  end
end
