# AXI4-Lite-Protocol
AXI4-Lite is a simplified version of the AXI4 protocol, designed for register access and low-throughput communication in embedded systems. It provides a lightweight and efficient mechanism for reading and writing control or status registers of components, making it suitable for peripherals that don’t require high data rates. Here are some key features of the AXI4-Lite protocol:

Key Features
Simplified Addressing: AXI4-Lite is used for single-word read and write transactions, typically for accessing control and status registers. Unlike the full AXI4 protocol, it doesn’t support burst transfers, simplifying its implementation.

Basic Channels: AXI4-Lite uses the same set of five channels as the full AXI4 protocol:

Write Address Channel (AW): Carries the address for write transactions.
Write Data Channel (W): Carries the data to be written.
Write Response Channel (B): Provides a response from the slave to indicate the success or failure of a write.
Read Address Channel (AR): Carries the address for read transactions.
Read Data Channel (R): Returns the requested data and status.
Transaction Model: A typical AXI4-Lite transaction involves:

Write Transaction:
The master sends the write address (AWADDR) through the Write Address Channel.
The master sends the write data (WDATA) through the Write Data Channel.
The slave responds via the Write Response Channel (BRESP) to indicate the outcome (success/failure).
Read Transaction:
The master sends the read address (ARADDR) through the Read Address Channel.
The slave responds with the read data (RDATA) and a response code (RRESP) through the Read Data Channel.
