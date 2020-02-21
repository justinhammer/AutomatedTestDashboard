require '../lib/automation_run'
require '../lib/my_pg_connect'

osValues = ["RHEL6.10", "RHEL7.4", "RHEL7.5", "SLES12SP3", "SLES12SP4", "SLES15"]
buildNumberValues = [55,56,57,58,59,60,61]

def createTimestamp
    now = Time.now.to_i
    return now.to_s
end

#Create an automation_run:
timestamp = createTimestamp
os = osValues.sample
buildNumber = buildNumberValues.sample
automationRun = AutomationRun.new(timestamp, os, buildNumber)

#Insert automation_run into db:
pgConn = MyPgConnect.new
conn = pgConn.connect

begin
    conn.prepare 'stm', "INSERT INTO automation_runs (timestamp, os, build_number) VALUES ($1, $2, $3);"
    puts "Executing statement..."
    res = conn.exec_prepared 'stm', [automationRun.timestamp, automationRun.os, automationRun.buildNumber]
rescue PG::Error => e
    puts e.message
ensure
    puts "Result Status:" + res.result_status.to_s if res
    conn.close
    puts "Connection closed."
end