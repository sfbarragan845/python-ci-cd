FROM python:3.11-slim

WORKDIR /app

COPY requirements.txt .
RUN  pip install --no-cache-dir -r requirements.txt

COPY app.py .

#USUARIO NO ROOT
RUN adduser --disabled-password --gecos '' apppuser && \
    chown -R apppuser:apppuser /app
USER apppuser

EXPOSE 5000

HEALTHCHECK --interval=30s --timeout=10s --start-period=5s --retries=3 CMD curl -f http://localhost:5000/health || exit 1

CMD ["python", "app.py"]