use lambda_runtime::{run, service_fn, Error, LambdaEvent};
use serde_json::Value as JsonValue;
use serde_json::json;

async fn function_handler(event: LambdaEvent<JsonValue>) -> Result<JsonValue, Error> {
    tracing::info!("received event payload: {}", serde_json::to_string(&event.payload)?);
    tracing::info!("received event context: {:?}", event.context);
    let resp = json!({
        "message": "Hello"
    });

    Ok(resp)
}

#[tokio::main]
async fn main() -> Result<(), Error> {
    tracing_subscriber::fmt()
        .with_max_level(tracing::Level::INFO)
        .without_time()
        .with_ansi(false)
        .init();

    tracing::info!("Start function_handler");

    run(service_fn(function_handler)).await
}
