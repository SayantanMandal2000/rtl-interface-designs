# Valid-Ack FSM Handshaking Protocol

![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)
![Language: Verilog](https://img.shields.io/badge/language-Verilog-yellow.svg)
![Build: Simulated](https://img.shields.io/badge/build-simulated-green)
![Waveform: Vivado](https://img.shields.io/badge/waveform-Vivado-blue)
![FSM: Implemented](https://img.shields.io/badge/FSM-Implemented-red)
![CI](https://github.com/SayantanMandal2000/rtl-interface-designs/blob/main/.github/workflows/sim.yml/badge.svg).

This project implements a **valid/acknowledge (valid-ack)** handshaking protocol using **Finite State Machines (FSMs)** in Verilog. It is inspired by AXI-Stream-style interfaces, where a master transfers data when `valid` is asserted, and the slave responds by asserting `ack` after a simulated delay.


---

## 📦 Modules Overview

### 🔷 `handshake_master.v`
- FSM-driven control for asserting `valid`
- Holds `data_in` until `ack` is received from slave

### 🔷 `handshake_slave.v`
- Waits for `valid` from master
- Simulates latency using an internal counter
- Sends back `ack` and forwards `data_out`

### 🔷 `handshake_top.v`
- Connects the master and slave
- Central module for testing and integration

---

## 🎮 Testbench: `handshake_tb.v`

- Stimulates `data_in` values: `8'hA1`, `8'hB2`, `8'hC9`, etc.
- Observes `valid` / `ack` interactions and `data_out` behavior
- Generates waveform output for verification

---

## 📊 FSM Diagrams

![FSM Diagram](valid_ack_fsm_handshake/docs/HandShakeSlave_FSM.png)
![FSM Diagram](valid_ack_fsm_handshake/docs/HandShakeMaster_FSM.png).

- **Master FSM:** `IDLE → SEND → WAIT_ACK → IDLE`
- **Slave FSM:** `S_IDLE → S_WAIT → S_ACK → S_IDLE`

FSM source: [`docs/fsm_master_slave.dot`](docs/fsm_master_slave.dot)

---

## ⏱️ Waveform Preview

![Waveform](docs/HandShakewaveform.png)

- Captured using Xilinx Vivado
- Shows valid/ack signals and corresponding data flow

---

## 🚀 Simulation (Vivado)

### ✅ Requirements
- Vivado 2020.2 or later

### ▶ Run Simulation:

```bash
make simulate
# OR manually
vivado -mode batch -source run_sim.tcl
