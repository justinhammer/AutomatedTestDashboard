require 'date'
require '../lib/my_pg_connect'
require '../lib/test_run'

testStatusValues = ["pass", "pass", "pass", "pass", "pass", "pass", "pass", "pass", "pass", "fail", "fail", "skip"]
nameQuery = "SELECT name FROM Test;"
automationRunQuery = "SELECT id FROM automation_run ORDER BY timestamp DESC LIMIT 1;"

def createNanosecondTimestamp
    now = DateTime.now.strftime("%Y%m%d%H%M%6N")
    return now.to_s
end

#Retrieve testNames:
testNames = []

begin
    pgConn = MyPgConnect.new
    conn = pgConn.connect
    results = conn.exec(nameQuery)
    puts "Executing query..."
rescue PG::Error => e
    puts e.message
ensure
    if results
        puts "Retrieved results!"
        results.each do |res|
            testNames<<res["name"]
        end
    end

    conn.close
    puts "Connection closed."
end

#Retrieve latest automationRun id:
automationRunId = nil

begin
    pgConn = MyPgConnect.new
    conn = pgConn.connect
    results = conn.exec(automationRunQuery)
    puts "Executing query..."
rescue PG::Error => e
    puts e.message
ensure
    if results
        puts "Retrieved results!"
        automationRunId = results[0]["id"]
    end

    conn.close
    puts "Connection closed"
end

#Create TestRuns:
testRuns = []
testNames.each do |name|
    timestamp = createNanosecondTimestamp
    status = testStatusValues.sample
    testRun = TestRun.new(timestamp, status, name, automationRunId)
    testRuns<<testRun
end

#Insert TestRuns into db:
testRuns.each do |testRun|
    pgConn = MyPgConnect.new
    conn = pgConn.connect

    begin
        conn.prepare 'stm', "INSERT INTO test_run (timestamp, status, test_name, automation_run) VALUES ($1, $2, $3, $4);"
        puts "Executing statement..."
        res = conn.exec_prepared 'stm', [testRun.timestamp, testRun.status, testRun.testName, testRun.automationRunId]
    rescue PG::Error => e
        puts e.message
    ensure
        puts "Result Status:" + res.result_status.to_s if res
        conn.close
        puts "Connection closed."
    end
end