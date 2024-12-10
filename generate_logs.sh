APACHE_LOG="/tmp/apache.log"
ACCESS_LOG="/tmp/access.log"
MAIL_LOG="/tmp/mail.log"

# Function to generate 10 random Apache log entries
generate_apache_log() {
    for ((i = 1; i <= 10; i++)); do
        echo "$(date '+%d/%b/%Y:%H:%M:%S %z') - - \"GET /page$((RANDOM % 100)).html HTTP/1.1\" $((200 + RANDOM % 100)) $((RANDOM % 5000))" >> $APACHE_LOG
    done
}

# Function to generate 10 random Access log entries
generate_access_log() {
    for ((i = 1; i <= 10; i++)); do
        echo "$(date '+%Y-%m-%d %H:%M:%S') CLIENT_IP=192.168.$((RANDOM % 256)).$((RANDOM % 256)) \"Accessed endpoint /api/$((RANDOM % 50))\"" >> $ACCESS_LOG
    done
}

# Function to generate 10 random Mail log entries
generate_mail_log() {
    for ((i = 1; i <= 10; i++)); do
        echo "$(date '+%Y-%m-%d %H:%M:%S') postfix/smtpd[$((1000 + RANDOM % 9000))]: connect from mail$((RANDOM % 100)).example.com" >> $MAIL_LOG
    done
}

# Generate logs
generate_apache_log
generate_access_log
generate_mail_log
