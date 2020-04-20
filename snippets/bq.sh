curl -H "Authorization: Bearer $(gcloud auth print-access-token)" 'https://www.googleapis.com/bigquery/v2/projects/{PROJ_ID}/jobs?alt=json&allUsers=true&projection=full&stateFilter=RUNNING'
