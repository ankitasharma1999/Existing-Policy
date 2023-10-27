resource "newrelic_infra_alert_condition" "high_disk_usage" {
  policy_id = var.policy_id

  name        = "High disk usage"
  description = "Warning if disk usage goes above 80% and critical alert if goes above 90%"
  type        = "infra_metric"
  event       = "StorageSample"
  select      = "diskUsedPercent"
  comparison  = "above"
  where       = "(hostname LIKE '%frontend%')"

  critical {
    duration      = 25
    value         = 90
    time_function = "all"
  }

  warning {
    duration      = 10
    value         = 80
    time_function = "all"
  }
}

resource "newrelic_infra_alert_condition" "high_db_conn_count" {
  policy_id = var.policy_id

  name        = "High database connection count"
  description = "Critical alert when the number of database connections goes above 90"
  type        = "infra_metric"
  event       = "DatastoreSample"
  select      = "provider.databaseConnections.Average"
  comparison  = "above"
  where       = "(hostname LIKE '%db%')"
  integration_provider = "RdsDbInstance"

  critical {
    duration      = 25
    value         = 90
    time_function = "all"
  }
}

resource "newrelic_infra_alert_condition" "process_not_running" {
  policy_id = var.policy_id

  name             = "Process not running (/usr/bin/ruby)"
  description      = "Critical alert when ruby isn't running"
  type             = "infra_process_running"
  comparison       = "equal"
  where            = "hostname = 'web01'"
  process_where    = "commandName = '/usr/bin/ruby'"

  critical {
    duration      = 5
    value         = 0
  }
}

resource "newrelic_infra_alert_condition" "host_not_reporting" {
  policy_id = var.policy_id

  name        = "Host not reporting"
  description = "Critical alert when the host is not reporting"
  type        = "infra_host_not_reporting"
  where       = "(hostname LIKE '%frontend%')"

  critical {
    duration = 5
  }
}