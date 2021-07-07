class Pokemon
  attr_accessor :id, :name, :type, :db 
  def initialize(keyword)

end

def self.save(name,type,db)
  db.execute(" INSERT INTO pokemon (name,type)
  VALUES (?,?)",name,type)
end 

def self.find(number,db)
  pokemon = db.execute("SELECT * FROM pokemon WHERE id = ? ",number)
  new = Pokemon.new(pokemon)
  new.id = pokemon[0][0]
  new.name = pokemon[0][1]
  new.type = pokemon[0][2]
  return new
end
end 