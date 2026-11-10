
#!/bin/sh
set -eu

JAVA_PID=""

stop_java() {
    echo "[EcoTecidos] Stopping services..."
    if [ -n "$JAVA_PID" ]; then
        kill "$JAVA_PID" 2>/dev/null || true
        wait "$JAVA_PID" 2>/dev/null || true
    fi
}

trap 'stop_java; exit 143' TERM INT

echo "[EcoTecidos] Starting Spring Boot..."

java -Djava.awt.headless=true -jar /app/app.jar &
JAVA_PID=$!

echo "[EcoTecidos] Java PID: $JAVA_PID"
echo "[EcoTecidos] Waiting for backend health..."

READY=0
ATTEMPT=0

while [ "$ATTEMPT" -lt 120 ]; do
    if ! kill -0 "$JAVA_PID" 2>/dev/null; then
        echo "[EcoTecidos] ERROR: Java process exited."
        wait "$JAVA_PID" || true
        exit 1
    fi

    HEALTH_RESPONSE=$(curl --silent --show-error \
        --max-time 3 \
        http://127.0.0.1:9090/actuator/health 2>/dev/null || true)

    if echo "$HEALTH_RESPONSE" | grep -q '"status":"UP"'; then
        READY=1
        echo "[EcoTecidos] Backend health is UP."
        break
    fi

    ATTEMPT=$((ATTEMPT + 1))

    if [ $((ATTEMPT % 10)) -eq 0 ]; then
        echo "[EcoTecidos] Still waiting ($ATTEMPT/120)..."
    fi

    sleep 2
done

if [ "$READY" -ne 1 ]; then
    echo "[EcoTecidos] ERROR: Backend did not become healthy."
    stop_java
    exit 1
fi

echo "[EcoTecidos] Starting Nginx..."

nginx -g 'daemon off;' &
NGINX_PID=$!

while kill -0 "$NGINX_PID" 2>/dev/null; do
    if ! kill -0 "$JAVA_PID" 2>/dev/null; then
        echo "[EcoTecidos] ERROR: Backend stopped."
        kill "$NGINX_PID" 2>/dev/null || true
        wait "$NGINX_PID" 2>/dev/null || true
        exit 1
    fi
    sleep 2
done

echo "[EcoTecidos] Nginx stopped."
stop_java
exit 1
