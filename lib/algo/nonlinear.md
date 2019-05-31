---
grand_parent: Mitchell Libraries
parent: Algorithmic Libraries
---
# Nonlinear Activation Functions

This library provides several nonlinear functions commonly used as activation
functions in neural networks.

## Interface

To use this library, prefix the types and functions below with `Nonlinear.`.

### Methods

- `val sigmoid : real -> real`
- `val dsigmoid : real -> real`
- `val tanh : real -> real`
- `val dtanh : real -> real`
- `val sigmoidf : real -> real`
- `val sigmoidh : real -> real`
- `val sigmoidg : real -> real`
- `val softmax : real array * int -> real`
- `val exp : real -> real`
- `val log : real -> real`

## Method Overview
- `sigmoid x`
  - [Sigmoid function](https://en.wikipedia.org/wiki/Sigmoid_function). Returns
    `1.0 / (1.0 + (e^(-x)))`.
- `dsigmoid x`
  - Derivative of sigmoid.
- `tanh (x)`
  - The [hyperbolic tangent](https://en.wikipedia.org/wiki/Hyperbolic_function).
- `dtanh x`.
  - Derivative of tanh.
- `sigmoidf x`
  - Alias for the sigmoid function.
- `sigmoidh x`
  - Returns `2.0 / (1.0 + (e^(-x))) - 1.0`.
- `sigmoidg x`
  - Returns `4.0 / (1.0 + (e^(-x))) - 2.0`.
- `softmax (arr, n)`
  - The [softmax function](https://en.wikipedia.org/wiki/Softmax_function).
- `exp x`
  - Returns the base of the natural logarithm raised to the `x`th power.
- `log x`
  - The natural logarithm.
