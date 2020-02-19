require '../lib/automation_run'
require '../lib/my_pg_connect'
require '../lib/test_run'

testStatusValues = ["pass", "pass", "pass", "pass", "pass", "pass", "pass", "fail", "fail", "skip"]
osValues = ["RHEL6.10", "RHEL7.4", "RHEL7.5", "SLES12SP3", "SLES12SP4", "SLES15"]
buildNumberValues = [55,56,57,58,59,60,61]

def createTimestamp
    return time.now.to_i
end

#Create an automation_run:
timestamp = createTimestamp
os = osValues.sample
buildNumber = buildNumberValues.sample
automationRun = AutomationRun.new(timestamp, os, buildNumber)

#Insert automation_run into db:
pgConn = MyPgConnect.new
conn = pgConn.connect
conn.prepare 'stm', "INSERT INTO automation_run (timestamp, os, build_number) VALUES ($1, $2, $3);"
conn.exec_prepared 'stm', [automationRun.timestamp, automationRun.os, automationRun.buildNumber]

#Create test_runs:


#Insert test_runs into db: