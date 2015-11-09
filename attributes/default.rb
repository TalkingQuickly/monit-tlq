default[:monit][:notify_emails] = false
default[:monit][:mailserver][:emailfrom] = "emailfrom@example.com"
default[:monit][:mailserver][:emailreplyto] = "emailreplyto@example.com"
default[:monit][:mailserver][:emailsubject] = "$SERVICE $EVENT at $DATE"
default[:monit][:mailserver][:emailmessage] = "Monit $ACTION $SERVICE at $DATE on $HOST: $DESCRIPTION.\nYours sincerely,\nmonit"
