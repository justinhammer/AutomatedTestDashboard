require 'date'
require '../lib/my_pg_connect'
require '../lib/test_run'

testStatusValues = ["pass", "pass", "pass", "pass", "pass", "pass", "pass", "pass", "pass", "fail", "fail", "skip"]
idQuery = "SELECT id FROM tests;"
automationRunQuery = "SELECT id FROM automation_runs ORDER BY timestamp DESC LIMIT 1;"

def createNanosecondTimestamp
    now = DateTime.now.strftime("%Y%m%d%H%M%6N")
    return now.to_s
end

#Retrieve testNames:
testIds = []

begin
    pgConn = MyPgConnect.new
    conn = pgConn.connect
    results = conn.exec(idQuery)
    puts "Executing query..."
rescue PG::Error => e
    puts e.message
ensure
    if results
        puts "Retrieved results!"
        results.each do |res|
            testIds<<res["id"]
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
testIds.each do |testId|
    timestamp = createNanosecondTimestamp
    status = testStatusValues.sample
    testRun = TestRun.new(timestamp, status, testId, automationRunId)
    testRuns<<testRun
end

#Insert TestRuns into db:
testRuns.each do |testRun|
    pgConn = MyPgConnect.new
    conn = pgConn.connect

    begin
        conn.prepare 'stm', "INSERT INTO test_runs (timestamp, status, test_id, automation_runs_id) VALUES ($1, $2, $3, $4);"
        puts "Executing statement..."
        res = conn.exec_prepared 'stm', [testRun.timestamp, testRun.status, testRun.testId, testRun.automationRunId]
    rescue PG::Error => e
        puts e.message
    ensure
        puts "Result Status:" + res.result_status.to_s if res
        conn.close
        puts "Connection closed."
    end
end