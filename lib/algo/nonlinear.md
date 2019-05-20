---
parent: Mitchell Libraries
---
# Nonlinear Activation Functions

Nonlinear functions(activation functions).

##### Dependencies

None.

##### Methods

- Nonlinear.
    + `real sigmoid(real x)`. Sigmoid, return `1.0 / (1.0 + (e^(-x)))`.
    + `real dsigmoid(real x)`. Derivative of sigmoid.
    + `real tanh(real x)`. Tanh.
    + `real dtanh(real x)`. Derivative of tanh.
    + `real sigmoidf(real x)`. Also Sigmoid.
    + `real sigmoidh(real x)`. Return `2.0 / (1.0 + (e^(-x))) - 1.0`.
    + `real sigmoidg(real x)`. Return `4.0 / (1.0 + (e^(-x))) - 2.0`.
    + `real softmax((real array) arr, int n)`. Softmax.
    + `real exp(real x)` Return e^x.
    + `real log(real x)`. Return ln(x).

