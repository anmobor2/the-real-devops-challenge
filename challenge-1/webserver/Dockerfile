FROM python:3.9-alpine as build

WORKDIR /app

COPY main.py /app

FROM python:3.9-alpine

RUN addgroup -S appgroup && adduser -S appuser -G appgroup

WORKDIR /app

COPY --from=build /app /app

RUN chown -R appuser:appgroup /app

RUN chmod -R 555 /app

USER appuser

EXPOSE 8000

ENTRYPOINT ["python", "main.py"]