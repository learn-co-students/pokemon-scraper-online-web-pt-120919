class Pokemon

    attr_accessor :id, :name, :type, :db


    def initialize(id=nil)
        @name = name 
        @type = type 
        @db = db 
        @id = id 
    end 

    def self.save(name, type, db)
        sql = <<-SQL
            INSERT INTO pokemon(name, type)
            VALUES (?, ?)
        SQL
        db.execute(sql, name, type)
        @id = db.execute("SELECT last_insert_rowid() FROM pokemon")[0][0]
    end 

    def self.find(id, db)
        sql = "SELECT * FROM pokemon WHERE id = ?"
        arr = db.execute(sql, id)[0]
        new_pokemon = self.new(arr)
        new_pokemon.id = arr[0]
        new_pokemon.name = arr[1]
        new_pokemon.type = arr[2]
        new_pokemon
    end

end
