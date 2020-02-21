require '../lib/my_pg_connect'
require 'csv'

#Create Random Test Names:
testSuffixes = [
    "Explodes",
    "DefeatsTheirNemesis",  
    "GetsRebooted", 
    "MeltsInAVolcano", 
    "GetsLostInSpace", 
    "GainsFlying", 
    "SavesTheWorld",
    "CreatesANeverEndingTimeLoop"   
]
table = CSV.parse(File.read("../lib/superheros.csv"), headers: true)

def createRandomName table
    tableRows = table.length
    name = table[rand(1..tableRows)]["name"]
    name = name.match(/^[\S]+/)
    return name.to_s
end

testNames = []
for i in 0..800
    name = createRandomName table
    suffix = testSuffixes.sample
    testName = name + suffix
    testNames<<testName
end
testNames = testNames.uniq

#Create List of Test Owners:
testOwners = []
for i in 0..49
    ownerName1 = createRandomName table
    ownerName2 = createRandomName table
    ownerName = ownerName1 + ownerName2
    testOwners<<ownerName
end

#Insert Test Names and Owners Into Test Table:
pgConn = MyPgConnect.new
conn = pgConn.connect
conn.prepare 'stm', "INSERT INTO Test (name, owner) VALUES ($1, $2);"
for testName in testNames
    testOwner = testOwners.sample
    conn.exec_prepared 'stm', [testName, testOwner]
end

conn.close