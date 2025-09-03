# Build stage: use Rust official image
FROM rust:latest AS builder

WORKDIR /usr/src/app

# Copy source code into the container
COPY . .

# Build the release version
RUN cargo build --release

# Runtime stage: use a minimal base image
FROM debian:buster-slim

# Copy the built binary from the builder stage
COPY --from=builder /usr/src/app/target/release/rustplusplus /usr/local/bin/rustplusplus

# Run the binary when container starts
ENTRYPOINT ["rustplusplus"]
