FROM python:3.12-slim
WORKDIR /srv
COPY requirements.txt app.zip ./
RUN pip install --no-cache-dir -r requirements.txt && python -m zipfile -e app.zip . && rm app.zip
ENV DATA_DIR=/data PYTHONUNBUFFERED=1
CMD ["sh", "-c", "uvicorn app.main:app --host 0.0.0.0 --port ${PORT:-8000} --proxy-headers --forwarded-allow-ips='*'"]
