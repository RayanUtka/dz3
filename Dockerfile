FROM python:3.13
WORKDIR /app
COPY app/requirements.txt .
RUN pip install -r requirements.txt
COPY app/app.py .
EXPOSE 8000
CMD ["python", "app.py"]