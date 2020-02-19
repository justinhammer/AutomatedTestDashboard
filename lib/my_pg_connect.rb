require 'pg'

class MyPgConnect
    HOSTADR = "127.0.0.1"
    PORT = "5432"
    DBNAME = "justinhammer"
    USER = "rails_app"
    PASSWORD = "automation"

    def connect
        begin
            conn = PG.connect(
                :hostaddr=>HOSTADR,
                :port=>PORT,
                :dbname=>DBNAME,
                :user=>USER,
                :password=>PASSWORD
            )
        rescue PG::Error => e
            puts e.message
            return false
        ensure
            puts "Connection successful!" if conn
            return conn
        end
    end
end