# 🛒 FSM-Based Vending Machine Controller (Verilog)

## 📌 Overview

This project implements a **Finite State Machine (FSM)-based vending machine controller** using Verilog HDL. The system is designed to simulate a coin-operated vending machine that accepts coins of multiple denominations and dispenses an item once a threshold is reached. It demonstrates a practical application of digital design principles, sequential logic, and FSM architecture.

> 💡 Designed and simulated as part of digital systems coursework at **NIT Rourkela** to reinforce concepts of modular Verilog design, state transition logic, and test-driven verification.

---

## ⚙️ Features

- Accepts coins of denomination **1, 2, and 5 units**
- Dispenses item once balance ≥ **7 units**
- Includes a **cancel input** to reset the balance
- **Mealy-style FSM**: Outputs depend on current state and input
- Fully verified using testbench and waveform simulation
- Cleanly modular and scalable Verilog code structure

---

## 🧠 FSM Design

### 🔄 FSM States:

| State      | Description                                      |
|------------|--------------------------------------------------|
| `IDLE`     | Initial state, waiting for coin input            |
| `COLLECT`  | Accumulating coin input until threshold is met   |
| `DISPENSE` | Item is dispensed, balance resets                |

### 🚦 State Transition Logic:

- From `IDLE` → `COLLECT` on any coin input
- From `COLLECT` → `DISPENSE` when balance ≥ 7
- From any state → `IDLE` on cancel or after dispense

---

## 📁 Directory Structure

