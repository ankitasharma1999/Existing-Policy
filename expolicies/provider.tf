terraform {
  required_providers {
    newrelic = {
      source  = "newrelic/newrelic"
    }
  }
}


provider "newrelic" {
  account_id = "4043843"
  api_key = "NRAK-SKD9RWRB92G9KZ9FQ8LJ5R2RHSR" 
  region = "US"                    
}
