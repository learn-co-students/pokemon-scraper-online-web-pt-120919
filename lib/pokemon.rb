class Pokemon
  attr_accessor :name, :type
  attr_reader :id, :db 
  
  @@all = []
  
  def initialize(id:nil, name:, type:, db:)
    @id = id 
    @name = name 
    @type = type 
    @db = db 
    @@all << self
  end
  
  def update
    sql = "UPDATE pokemon SET name = ?, type = ? WHERE id = ?"
    @db.execute(sql, self.name, self.type, self.id)
  end
  
  def self.save(name, type, db)
    sql = <<-SQL
      INSERT INTO pokemon (name, type)
      VALUES (?, ?)
    SQL
    db.execute(sql, name, type)
    @id = db.execute("SELECT last_insert_rowid() FROM pokemon")[0][0]
  end
  
  def self.find(id, db)
    sql = <<-SQL
      SELECT * FROM pokemon
      WHERE id = ?
    SQL
    row = db.execute(sql, id)[0]
    Pokemon.new(id: id, name: row[1], type: row[2], db: db)
  end
end
